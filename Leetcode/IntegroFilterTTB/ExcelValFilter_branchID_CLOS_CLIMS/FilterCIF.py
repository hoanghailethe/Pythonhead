
import pandas as pd
import csv


# assign directory
directory = 'D:/11.29.HH.moveLaptop/HHgithub/Pythonhead/Leetcode/IntegroFilterTTB/ExcelValFilter_branchID_CLOS_CLIMS'
 
# file input name
file_name = 'cifthieubranch.xlsx'

# inpu clos cms data
df_clos = pd.read_excel(open(directory + '/' +file_name, 'rb'),sheet_name='CLOS_in')
df_cms = pd.read_excel(open(directory + '/' +file_name, 'rb'),sheet_name='CMS_in')

df_cms['LSP_LE_ID'] = df_cms['LSP_LE_ID'].astype(str)
df_clos['CIF_NUMBER'] = df_clos['CIF_NUMBER'].astype(str)

# Filter 1
CIF_CMS = set(df_cms['LSP_LE_ID'])   #contain of clims
CIF_CLOS = set(df_clos['CIF_NUMBER'])   #contain of clos


# Filter 2 as RES
CIF_CMS_ONLY = []
CIF_CLOS_ONLY = []
CIF_BOTH = [] 

if CIF_CMS & CIF_CLOS :
    CIF_BOTH = CIF_CMS & CIF_CLOS
CIF_CLOS_ONLY = [i for i in CIF_CLOS if i not in CIF_BOTH]
CIF_CMS_ONLY = [i for i in CIF_CMS if i not in CIF_BOTH]

print(CIF_CMS_ONLY)
print('CIF_CMS_ONLY')
print(CIF_CLOS_ONLY)
print('CIF_CMS_ONLY')
print(CIF_BOTH)

# -- OUTPUT
OUTPUT_FILE = directory + "/" + "filter_CIF.csv"

result_strings =[]
result_strings.append("BOTH : ")
result_strings.extend(CIF_BOTH)
result_strings.append("CMS : ")
result_strings.extend(CIF_CMS_ONLY)
result_strings.append("CLOS : ")
result_strings.extend(CIF_CLOS_ONLY)

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

