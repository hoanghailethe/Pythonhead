
# import required module
import os
# assign directory
directory = 'C:/Users/Victory/Downloads/docgen/docgen/data'
 
# iterate over files in
# that directory
for filename in os.listdir(directory):
    print(filename)
    # f = os.path.join(directory, filename)
    # checking if it is a file
    # if os.path.isfile(f):
    #     print(f)