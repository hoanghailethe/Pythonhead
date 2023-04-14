
# Import csv library to write the result list to excel
import csv

# import required module
import os
# assign directory
directory = 'D:/11.29.HH.moveLaptop/HHgithub/Pythonhead/Leetcode/IntegroFilterTTB'
 
# Set up an array to store the result strings matching the given criteria
result_strings = []

CONTAIN_CHECK_STRING = "xsl:value-of "
EQUAL_CHAR = "="
NOT_EQUAL = "!="
MUST_NOT_CONTAIN = "document/"

LOAD_INPUT_FROM_FILE = directory + "/" + "load_input.csv"
FILE_TO_SCAN = directory + "/" + "docgen_nonlogic.properties"

OUTPUT_FILE = directory + "/" + "output.csv"


input_strings = []

#Load input str from LOAD_IN
print('START LOADING INPUT')
with open(LOAD_INPUT_FROM_FILE, 'r') as file:
    for line in file:
        if line not in input_strings:
           print(line)
           input_strings.append(line)
# print('TOTAL '  + len(input_strings))

#SCaning to see  if input string at the end of LINE
print('START SCANNING')
with open(FILE_TO_SCAN, 'r') as file2:
    for line in file2:
        for checkContainStr in input_strings:
          if line.endswith(checkContainStr):
             shortenStringRes = line 
             if EQUAL_CHAR in shortenStringRes:
                shortenStringRes = shortenStringRes[shortenStringRes.find(EQUAL_CHAR):]
             result_strings.append(shortenStringRes)
             break
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