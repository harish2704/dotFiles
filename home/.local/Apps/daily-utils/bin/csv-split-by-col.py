#!/usr/bin/env python

# ॐ  Om Brahmarppanam  ॐ
#
# csv-split-by-col.py
# Created at: Sat Jan 28 2023 19:43:44 GMT+0530 (GMT+05:30)
#
# Copyright 2023 Harish Karumuthil <harish2704@gmail.com>
#
# Use of this source code is governed by an MIT-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/MIT.
#


import os
import argparse
import pandas as pd
import openpyxl

def pathToFilename(filePath):
    return os.path.splitext(os.path.basename(filePath))[0]

# Shamelessly copied from https://stackoverflow.com/a/39530676/1677234
def autoWidth(worksheet):
    for col in worksheet.columns:
         max_length = 0
         column = col[0].column_letter # Get the column name
         for cell in col:
             try: # Necessary to avoid error on empty cells
                 if len(str(cell.value)) > max_length:
                     max_length = len(str(cell.value))
             except:
                 pass
         adjusted_width = (max_length + 2)
         worksheet.column_dimensions[column].width = adjusted_width

def main(df, firstCol, secondCol, outputDir, fileName):
    firstColUniq = df[firstCol].unique()
    for i in firstColUniq:
        subDf = df[ df[firstCol] == i ]
        subDf = subDf.drop(firstCol, axis=1)
        with pd.ExcelWriter('{0}/{1}_{2}.xlsx'.format(outputDir,fileName,i), engine='openpyxl') as writer:
        # with pd.ExcelWriter('{0}/{1}_{2}.xlsx'.format(outputDir,fileName,i), engine='xlsxwriter') as writer: # Does not work with adjusted_width
            secondColUniq = subDf[secondCol].unique()
            for j in secondColUniq:
                sheetDf = subDf[ subDf[secondCol] == j ]
                sheetDf = sheetDf.drop(secondCol, axis=1)
                sheetName = j[0:20]
                sheetDf.insert(0, 'S.No', range(1, 1+len(sheetDf)))
                sheet = sheetDf.to_excel(writer, sheet_name=sheetName, index=False)
                writer.sheets[sheetName].header = sheetName
                # auto_adjust_xlsx_column_width(sheetDf, writer, sheetName)
            for _,sheet in writer.sheets.items():
                autoWidth(sheet)
                sheet.evenHeader.center.text = "&A - Page &[Page] of &N"
                sheet.oddHeader.center.text = "&A - Page &[Page] of &N"


parser = argparse.ArgumentParser(
                    prog = 'Split CSV',
                    description = 'Split big CSV file to N-files with M-sheets per file by grouping first and second column option',
                    epilog = 'Text at the bottom of help')
parser.add_argument('filename')
parser.add_argument('-d', '--delimiter', default=',', help="Delimiter (default=',')")
parser.add_argument('-f', '--first-column', help="title of primary column based on which files will be split")
parser.add_argument('-s', '--second-column', help="title of second column based on which each sheets will be created in single file")
parser.add_argument('-o', '--output-dir', help="Output director default( './csvsplit.out')", default='./csvsplit.out')
args = parser.parse_args()

dataFrame = pd.read_csv(args.filename, sep=args.delimiter)
firstColumn = args.first_column or dataFrame.columns[0]
secondColumn = args.second_column or dataFrame.columns[1]

# TODO: mkdir -p 
try:
    os.mkdir(args.output_dir)
except FileExistsError as e:
    pass

main( dataFrame, firstColumn, secondColumn, args.output_dir, pathToFilename(args.filename) )
