ant clean-all build-all
ant hstore-prepare -Dproject="voterdemohstorewXsYY" -Dhosts="localhost:0:0"
ant hstore-prepare -Dproject="voterdemosstorewXsYY" -Dhosts="localhost:0:0"

#h-store
python ./tools/autorunexp.py -p "voterdemohstorewXsYY" -o "experiments/0727/voterdemohstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --hstore --hscheduler --numruns 1 
#python ./tools/autorunexp.py -p "voterdemohstorewXsYY" -o "experiments/0727/voterdemohstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
#--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --groupcommit 0 --hstore --hscheduler --numruns 1 
python ./tools/autorunexp.py -p "voterdemohstorewXsYY" -o "experiments/0727/voterdemohstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --groupcommit 10 --hstore --hscheduler --numruns 1
python ./tools/autorunexp.py -p "voterdemohstorewXsYY" -o "experiments/0727/voterdemohstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --groupcommit 100 --hstore --hscheduler --numruns 1 
python ./tools/autorunexp.py -p "voterdemohstorewXsYY" -o "experiments/0727/voterdemohstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --groupcommit 1000 --hstore --hscheduler --numruns 1
python ./tools/autorunexp.py -p "voterdemohstorewXsYY" -o "experiments/0727/voterdemohstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --groupcommit 10000 --hstore --hscheduler --numruns 1   
python ./tools/autorunexp.py -p "voterdemohstorewXsYY" -o "experiments/0727/voterdemohstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --groupcommit 100000 --hstore --hscheduler --numruns 1   



#s-store weak recovery
python ./tools/autorunexp.py -p "voterdemosstorewXsYY" -o "experiments/0727/voterdemosstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --hscheduler --numruns 1 
#python ./tools/autorunexp.py -p "voterdemosstorewXsYY" -o "experiments/0727/voterdemosstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
#--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --groupcommit 0 --hscheduler --numruns 1 
python ./tools/autorunexp.py -p "voterdemosstorewXsYY" -o "experiments/0727/voterdemosstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --groupcommit 10 --hscheduler --numruns 1 
python ./tools/autorunexp.py -p "voterdemosstorewXsYY" -o "experiments/0727/voterdemosstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --groupcommit 100 --hscheduler --numruns 1 
python ./tools/autorunexp.py -p "voterdemosstorewXsYY" -o "experiments/0727/voterdemosstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --groupcommit 1000 --hscheduler --numruns 1 
python ./tools/autorunexp.py -p "voterdemosstorewXsYY" -o "experiments/0727/voterdemosstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --groupcommit 10000 --hscheduler --numruns 1 
python ./tools/autorunexp.py -p "voterdemosstorewXsYY" -o "experiments/0727/voterdemosstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --groupcommit 100000 --hscheduler --numruns 1 



#s-store strong recovery
python ./tools/autorunexp.py -p "voterdemosstorewXsYY" -o "experiments/0727/voterdemosstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --hscheduler --weakrecovery_off --numruns 1 
#python ./tools/autorunexp.py -p "voterdemosstorewXsYY" -o "experiments/0727/voterdemosstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
#--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --groupcommit 0 --hscheduler --weakrecovery_off --numruns 1 
python ./tools/autorunexp.py -p "voterdemosstorewXsYY" -o "experiments/0727/voterdemosstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --groupcommit 10 --hscheduler --weakrecovery_off --numruns 1 
python ./tools/autorunexp.py -p "voterdemosstorewXsYY" -o "experiments/0727/voterdemosstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --groupcommit 100 --hscheduler --weakrecovery_off --numruns 1 
python ./tools/autorunexp.py -p "voterdemosstorewXsYY" -o "experiments/0727/voterdemosstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --groupcommit 1000 --hscheduler --weakrecovery_off --numruns 1 
python ./tools/autorunexp.py -p "voterdemosstorewXsYY" -o "experiments/0727/voterdemosstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --groupcommit 10000 --hscheduler --weakrecovery_off --numruns 1 
python ./tools/autorunexp.py -p "voterdemosstorewXsYY" -o "experiments/0727/voterdemosstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --groupcommit 100000 --hscheduler --weakrecovery_off --numruns 1 

#h-store
python ./tools/autorunexp.py -p "voterdemohstorewXsYY" -o "experiments/0727/voterdemohstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --logtimeout 10 --hstore --hscheduler --numruns 1
python ./tools/autorunexp.py -p "voterdemohstorewXsYY" -o "experiments/0727/voterdemohstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --logtimeout 100 --hstore --hscheduler --numruns 1 
python ./tools/autorunexp.py -p "voterdemohstorewXsYY" -o "experiments/0727/voterdemohstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --logtimeout 1000 --hstore --hscheduler --numruns 1
python ./tools/autorunexp.py -p "voterdemohstorewXsYY" -o "experiments/0727/voterdemohstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --logtimeout 10000 --hstore --hscheduler --numruns 1   

#s-store weak recovery
python ./tools/autorunexp.py -p "voterdemosstorewXsYY" -o "experiments/0727/voterdemosstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --logtimeout 10 --hscheduler --numruns 1 
python ./tools/autorunexp.py -p "voterdemosstorewXsYY" -o "experiments/0727/voterdemosstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --logtimeout 100 --hscheduler --numruns 1 
python ./tools/autorunexp.py -p "voterdemosstorewXsYY" -o "experiments/0727/voterdemosstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --logtimeout 1000 --hscheduler --numruns 1 
python ./tools/autorunexp.py -p "voterdemosstorewXsYY" -o "experiments/0727/voterdemosstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --logtimeout 10000 --hscheduler --numruns 1 


#s-store strong recovery
python ./tools/autorunexp.py -p "voterdemosstorewXsYY" -o "experiments/0727/voterdemosstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --logtimeout 10 --hscheduler --weakrecovery_off --numruns 1 
python ./tools/autorunexp.py -p "voterdemosstorewXsYY" -o "experiments/0727/voterdemosstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --logtimeout 100 --hscheduler --weakrecovery_off --numruns 1 
python ./tools/autorunexp.py -p "voterdemosstorewXsYY" -o "experiments/0727/voterdemosstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --logtimeout 1000 --hscheduler --weakrecovery_off --numruns 1 
python ./tools/autorunexp.py -p "voterdemosstorewXsYY" -o "experiments/0727/voterdemosstorewXsYY-1c-90-0727-site10.txt" --txnthreshold 0.90 -e "experiments/0727/site10-0727-groupcommit.txt" \
--winconfig "tuple w100s10 (site10)" --threads 1 --rmin 300 --rstep 100 --finalrstep 10 --warmup 10000 --log --logtimeout 10000 --hscheduler --weakrecovery_off --numruns 1 
