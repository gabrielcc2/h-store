package edu.brown.catalog.conflicts;

import java.io.File;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.apache.log4j.Logger;
import org.voltdb.CatalogContext;
import org.voltdb.catalog.CatalogType;
import org.voltdb.catalog.ConflictPair;
import org.voltdb.catalog.Database;
import org.voltdb.catalog.Procedure;
import org.voltdb.catalog.Statement;
import org.voltdb.catalog.Table;
import org.voltdb.types.ConflictType;
import org.voltdb.utils.Pair;

import edu.brown.catalog.CatalogUtil;
import edu.brown.catalog.conflicts.ConflictGraph.ConflictEdge;
import edu.brown.catalog.conflicts.ConflictGraph.ConflictVertex;
import edu.brown.graphs.AbstractDirectedGraph;
import edu.brown.graphs.AbstractEdge;
import edu.brown.graphs.AbstractVertex;
import edu.brown.graphs.GraphUtil;
import edu.brown.graphs.GraphvizExport;
import edu.brown.utils.ArgumentsParser;
import edu.brown.utils.FileUtil;
import edu.uci.ics.jung.graph.DirectedSparseMultigraph;
import edu.uci.ics.jung.graph.util.EdgeType;

/**
 * Dump out all conflicts
 * @author pavlo
 */
public abstract class ConflictSetDump {
    private static final Logger LOG = Logger.getLogger(ConflictSetDump.class);
    
    private static class ProcedureTable extends Procedure {
        private final Pair<Procedure, Table> pair;
        private ProcedureTable(Procedure proc, Table table) { 
            this.pair = Pair.of(proc, table);
        }
        @Override
        public String toString() {
            return this.pair.toString();
        }
        @Override
        public int hashCode() {
            return this.pair.hashCode();
        }
        @Override
        public boolean equals(Object obj) {
            return this.pair.equals(obj);
        }
        @Override
        public int compareTo(CatalogType o) {
            return this.pair.compareTo(((ProcedureTable)o).pair);
        }
        @Override
        public <T extends CatalogType> T getParent() {
            return (T)this.pair.getFirst();
        }
    }
    private static class Vertex extends AbstractVertex {
        private Vertex(Procedure proc, Table table) {
            super(new ProcedureTable(proc, table));
        }
    }
    
    private static class Edge extends AbstractEdge {
        private final Pair<Statement, Statement> pair;
        private Edge(DumpGraph graph, Statement stmt0, Statement stmt1) {
            super(graph);
            this.pair = Pair.of(stmt0, stmt1);
        }
        @Override
        public String toString() {
            return this.pair.toString();
        }
        @Override
        public int hashCode() {
            return this.pair.hashCode();
        }
        @Override
        public boolean equals(Object obj) {
            return this.pair.equals(obj);
        }
    }
    
    private static class DumpGraph extends AbstractDirectedGraph<Vertex, Edge> {
        final Map<Pair<Procedure, Table>, Vertex> procTblXref = new HashMap<Pair<Procedure,Table>, Vertex>();
        final Map<Procedure, Set<Vertex>> procXref = new HashMap<Procedure, Set<Vertex>>();
        
        private DumpGraph(CatalogContext catalogContext) {
            super(catalogContext.database);
            for (Procedure proc : catalogContext.procedures) {
                this.populateProcedure(proc);
            } // FOR
        }
        
        public Vertex getVertex(Procedure proc, Table tbl) {
            return this.procTblXref.get(Pair.of(proc, tbl));
        }
        @Override
        public boolean addVertex(Vertex vertex) {
            boolean ret = super.addVertex(vertex);
            if (ret) {
                ProcedureTable pt = vertex.getCatalogItem();
                this.procTblXref.put(pt.pair, vertex);
                Set<Vertex> s = this.procXref.get(pt.pair.getFirst());
                if (s == null) {
                    s = new HashSet<Vertex>();
                    this.procXref.put(pt.pair.getFirst(), s);
                }
                s.add(vertex);
            }
            return (ret);
        }
        
        private void populateProcedure(Procedure proc0) {
            for (ConflictPair cp : ConflictSetUtil.getAllConflictPairs(proc0)) {
                Statement stmt0 = cp.getStatement0();
                Statement stmt1 = cp.getStatement1();
                Procedure proc1 = stmt1.getParent();
                
                for (Table tbl : CatalogUtil.getReferencedTables(stmt0)) {
                    Vertex v0 = this.getVertex(proc0, tbl);
                    if (v0 == null) {
                        v0 = new Vertex(proc0, tbl);
                    }
                    Vertex v1 = this.getVertex(proc1, tbl);
                    if (v1 == null) {
                        v1 = new Vertex(proc1, tbl);
                    }
                    Edge e = new Edge(this, stmt0, stmt1);
                    this.addEdge(e, v0, v1);
                } // FOR
            } // FOR
            
            
        }
    }
    
    
    public static void main(String[] vargs) throws Exception {
        ArgumentsParser args = ArgumentsParser.load(vargs,
            ArgumentsParser.PARAM_CATALOG
        );
        
        ConflictSetCalculator calculator = new ConflictSetCalculator(args.catalog);
        
        // Procedures to exclude in ConflictGraph
        if (args.hasParam(ArgumentsParser.PARAM_CONFLICTS_EXCLUDE_PROCEDURES)) {
            String param = args.getParam(ArgumentsParser.PARAM_CONFLICTS_EXCLUDE_PROCEDURES);
            for (String procName : param.split(",")) {
                Procedure catalog_proc = args.catalogContext.procedures.getIgnoreCase(procName);
                if (catalog_proc != null) {
                    calculator.ignoreProcedure(catalog_proc);
                } else {
                    LOG.warn("Invalid procedure name to exclude '" + procName + "'");
                }
            } // FOR
        }
        
        // Statements to exclude in ConflictGraph
        if (args.hasParam(ArgumentsParser.PARAM_CONFLICTS_EXCLUDE_STATEMENTS)) {
            String param = args.getParam(ArgumentsParser.PARAM_CONFLICTS_EXCLUDE_STATEMENTS);
            for (String name : param.split(",")) {
                String splits[] = name.split("\\.");
                if (splits.length != 2) {
                    LOG.warn("Invalid procedure name to exclude '" + name + "': " + Arrays.toString(splits));
                    continue;
                }
                Procedure catalog_proc = args.catalogContext.procedures.getIgnoreCase(splits[0]);
                if (catalog_proc == null) {
                    LOG.warn("Invalid procedure name to exclude '" + name + "'");
                    continue;
                }
                    
                Statement catalog_stmt = catalog_proc.getStatements().getIgnoreCase(splits[1]);
                if (catalog_stmt != null) {
                    calculator.ignoreStatement(catalog_stmt);
                } else {
                    LOG.warn("Invalid statement name to exclude '" + name + "'");
                }
            } // FOR
        }
        
        calculator.process();
        DumpGraph graph = new DumpGraph(args.catalogContext);
        
        // If we have a Procedure to "focus" on, then we need to remove any edges
        // that don't involve that Procedure
        if (args.hasParam(ArgumentsParser.PARAM_CONFLICTS_FOCUS_PROCEDURE)) {
            String procName = args.getParam(ArgumentsParser.PARAM_CONFLICTS_FOCUS_PROCEDURE);
            Procedure catalog_proc = args.catalogContext.procedures.getIgnoreCase(procName);
            if (catalog_proc != null) {
                for (Vertex v : graph.procXref.get(catalog_proc)) {
                    if (v != null) {
                        // GraphUtil.removeEdgesWithoutVertex(graph, v);
                        // GraphUtil.removeDisconnectedVertices(graph);
                    }
                } // FOR
            } else {
                LOG.warn("Invalid procedure name to focus '" + procName + "'");
            }
        }
        
        // Export!
        GraphvizExport<Vertex, Edge> gvx = new GraphvizExport<Vertex, Edge>(graph);
        gvx.setEdgeLabels(true);
        String graphviz = gvx.export(args.catalog_type.name());
        if (!graphviz.isEmpty()) {
            String output = args.getOptParam(0);
            if (output == null) {
                output = args.catalog_type.name().toLowerCase() + "-conflicts.dot";
            }
            File path = new File(output);
            FileUtil.writeStringToFile(path, graphviz);
            System.out.println("Wrote contents to '" + path.getAbsolutePath() + "'");
        } else {
            System.err.println("ERROR: Failed to generate graphviz data");
            System.exit(1);
        }
    }
}