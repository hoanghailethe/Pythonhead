
# Import csv library to write the result list to excel
import csv

# import required module
import os
# assign directory
directory = 'C:/Users/Victory/Downloads/docgen/docgen/data'
 
# Set up an array to store the result strings matching the given criteria
result_strings = []

CONTAIN_CHECK_STRING = "document/"
EQUAL_CHAR = "="

# iterate over files in
# that directory
for filename in os.listdir(directory):
  result_strings.append ("COLLECT from : " + filename) 
  # print(filename)
  # Set the path of the file that needs to be opened
  file_path = directory + "/" +filename

  # Open the file and read it
  f = open(file_path,  encoding="utf8")
  # f = open('Appliaction_Form.xls', "r")
  data = f.read()
  f.close()

  # Split the file to get strings between " and " 
  strings = data.split('"')


  # Iterate through the strings split from the file
  for i in range(len(strings)):
    
    # Check if strings matches the given criteria
    if CONTAIN_CHECK_STRING in strings[i]:
      shortenStringRes = strings[i]
      
      # Print the strings to terminal
      print(shortenStringRes)

      #Eliminate equal value
      if EQUAL_CHAR in shortenStringRes:
        shortenStringRes = shortenStringRes[:shortenStringRes.find(EQUAL_CHAR)]
    
      # Append it to result list if not existed
      if shortenStringRes not in result_strings:
        result_strings.append(shortenStringRes)

# Set the output file name
output_file_name = "D:/11.29.HH.moveLaptop/HHgithub/Pythonhead/Leetcode/IntegroFilterTTB/result_file3.csv"
header = ['Filter data']
# Open the output file in write mode
with open(output_file_name, 'w', encoding='UTF8', newline='') as file:
  
   # Set the properties of excel writer
   writer = csv.writer(file)
   writer.writerow(header)
   # Write the data of the result strings to the csv
   
   for str in result_strings : 
    writer.writerow([str])

print('Write Successfully!')