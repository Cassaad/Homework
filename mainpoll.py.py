import os
import csv
csvfile = os.path.join (election_data_2.csv)

vote_count = 0 
list_candidates = []
votecount = {}

with open (csvfile,"r") as election_data_2
csvfile = csv.DictReader (election_data_2)

for row in csvfile:
	vote_count += 1
	if candidates not in list_candidates:
		list_candidates.append(row[candidates])
		votecount[row["candidates"]] = 1
	elif row['candidates'] in list_candidates:
		votecount[row["candidates"]] += 1
		prev_cand=0
print("Election Results")
print("-------------------------")
print("Total Vote Counts: "+ str(vote_count))
print("-------------------------")
for key, value in cand_votecount.items():
    print(key+": "+ str(round((float(value/vote_count)*100),1))+"%"+" ("+ str(value)+")")
for key, value in cand_votecount.items():
    if value > prev_cand:
        most_vote = key
        prev_cand = value
print("-------------------------")
print("Winner: " + most_vote)
print("-------------------------")
