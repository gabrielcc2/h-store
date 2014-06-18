/* This file is part of VoltDB.
 * Copyright (C) 2008-2012 VoltDB Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
 * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */

//
// Accepts a vote, enforcing business logic: make sure the vote is for a valid
// contestant and that the voterdemosstore (phone number of the caller) is not above the
// number of allowed votes.
//

package edu.brown.benchmark.sstore4moveop.procedures;

import org.voltdb.ProcInfo;
import org.voltdb.SQLStmt;
import org.voltdb.StmtInfo;
import org.voltdb.VoltProcedure;
import org.voltdb.VoltTable;
import org.voltdb.types.TimestampType;

import edu.brown.benchmark.sstore4moveop.SStore4MoveOpConstants;

@ProcInfo (
	partitionInfo = "t2.part_id:0",
	partitionNum = 1,
    singlePartition = false
)
public class SP3 extends VoltProcedure {
	
	
	protected void toSetTriggerTableName()
	{
		addTriggerTable("s2");
	}
	
    // Put vote into leaderboard
//    public final SQLStmt trendingLeaderboardStmt = new SQLStmt(
//	   "INSERT INTO trending_leaderboard (vote_id, phone_number, state, contestant_number, time) SELECT * FROM proc_one_out;"
//    );
    
    // Put vote into leaderboard
	public final SQLStmt pullFromS2 = new SQLStmt(
		"SELECT vote_id FROM s2 WHERE part_id=0;"
	);
	
    public final SQLStmt inT2Stmt = new SQLStmt(
	   "INSERT INTO T2 (vote_id, part_id) VALUES (?, ?);"
    );
    
    public final SQLStmt clearS2 = new SQLStmt(
    	"DELETE FROM s2;"
    );
        
	
public long run(int part_id) {
		
        // Queue up leaderboard stmts
//		voltQueueSQL(trendingLeaderboardStmt);
		voltQueueSQL(pullFromS2);
		VoltTable s2Data[] = voltExecuteSQL();
		Long vote_id = s2Data[0].fetchRow(0).getLong(0);
		
		voltQueueSQL(inT2Stmt, vote_id, part_id);
        voltQueueSQL(clearS2);
//        voltQueueSQL(getTrendingLeaderboard);

        VoltTable validation[] = voltExecuteSQL();
		
//        // check the number of rows
//        if ((validation[2].fetchRow(0).getLong(0)) >= 0) {
//        	long phone_number = validation[2].fetchRow(0).getLong(0);
//        	long contestant_number = validation[2].fetchRow(0).getLong(1);
//        }
		
        // Set the return value to 0: successful vote
        return SStore4MoveOpConstants.VOTE_SUCCESSFUL;
    }
}