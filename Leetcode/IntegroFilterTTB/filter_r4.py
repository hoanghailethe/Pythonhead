
# Import csv library to write the result list to excel
import csv

# import required module
import os
# assign directory
directory = 'D:/11.29.HH.moveLaptop/HHgithub/Pythonhead/Leetcode/IntegroFilterTTB'
 
# Set up an array to store the result strings matching the given criteria
result_strings = []


LOAD_INPUT_FROM_FILE = directory + "/" + "load_input_r4_added.csv"
FILE_TO_SCAN = directory + "/" + "load_input_r4_newInput.csv"

OUTPUT_FILE = directory + "/" + "filter_round_4.csv"

#REMOVE DUPLICATE

input_strings = ['INPUT EXISTED -REMOVE DUPLICATE:']

#Load input str from LOAD_IN
print('START LOADING INPUT')
with open(LOAD_INPUT_FROM_FILE, 'r') as file:
    for line in file:
        str = line.strip()
        if str not in input_strings:
           print(str)
           input_strings.append(str)
# print('TOTAL '  + len(input_strings))

print('FINISHED ADDED INPUT')
result_strings.extend(input_strings)

#SCaning to see  if input string at the end of LINE
print('START SCANNING')
result_strings.append('ADD NOT EXIST fields: ')
with open(FILE_TO_SCAN, 'r') as file2:
    for line in file2:
        str2 = line.strip()
        if str2 not in result_strings:
            result_strings.append(str2)
# print('TOTAL RES'  + len(result_strings))


# Set the output file name
output_file_name = OUTPUT_FILE
header = ['Filter data from properties']
# Open the output file in write mode
with open(output_file_name, 'w', encoding='UTF8', newline='') as file:
  # Set the properties of excel writer
  writer = csv.writer(file)
  writer.writerow(header)
  # Write the data of the result strings to the csv
   
  for str in result_strings : 
    writer.writerow([str])

print('START STRIMING')
result = ""
with open(output_file_name, "r+") as file:
    for line in file:
        if not line.isspace():
            result += line
 
    file.seek(0)  
    file.write(result)


print('Write Successfully!')