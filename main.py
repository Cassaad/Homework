import os
import csv
csvfile =os.path.join("budget_data_1.csv") 

month_count = 0
sum_revenue = 0
change_revenue = 0
previous_revenue = 0
total_change = 0
max_increase = ['', 0]
max_decrease = ['', 0]

with open(csvfile, "r") as budget_data_1:
    csvfile = csv.DictReader(budget_data_1)
    count = 1
    for row in csvfile:
        month_count += 1
        sum_revenue += int(row["Revenue"])
        change_revenue = (int(row["Revenue"]) - previous_revenue)
        total_change = total_change + change_revenue
        if previous_revenue != 0:
            if change_revenue > max_increase[1]:
                max_increase[0] = row['Date']
                max_increase[1] = int(change_revenue)
            elif change_revenue < max_decrease[1]:
                max_decrease[0] = row['Date']
                max_decrease[1] = int(change_revenue)  
        previous_revenue = int(row["Revenue"])  

print("Financial Analysis")
print("--------------------")
print("Months count is " + str(month_count) + ".")
print("Total revenue is " + str(sum_revenue) + ".")
print("Average Revenue Change: $" + str(change_revenue/41))
print("Greatest increase in Revenue: $" + max_increase[0] + " ($" +str(max_increase[1])+ ")")
print("Greatest decrease in Revenue: $" + max_decrease[0] + " ($" +str(max_decrease[1])+ ")")

 