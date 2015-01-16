#!python
from fdfgen import forge_fdf
import json, ast
import os
import sys
from sets import Set


NEW_KEYS = Set(['RESET', 'WrittenBy', 'TotalService', 'Today', 'OP 11', 'OP 10', 'OP 12', 'SVC 12', 'SVC 11', 'SVC 10', 'OP 6', 'ROI 7', 'ROI 6', 'ROI 5', 'ROI 4', 'ROI 3', 'ROI 2', 'ROI 1', 'Qty 8', 'VIN', 'ROI 9', 'ROI 8', 'Tax', 'Email', 'Engine', 'Qty 10', 'Qty 13', 'Qty 12', 'Amount 8', 'Amount 9', 'Qty 16', 'Amount 4', 'Amount 5', 'Amount 6', 'Amount 7', 'Amount 1', 'Amount 2', 'Amount 3', 'PO', 'EnvtlFee', 'SubmitButton1', 'Sign', 'D 5', 'D 4', 'D 3', 'D 2', 'D 1', 'Blank', 'Make', 'Amount 16', 'Amount 17', 'Amount 14', 'Amount 15', 'Amount 12', 'Amount 13', 'Amount 10', 'Amount 11', 'Qty 1', 'Qty 3', 'Qty 2', 'Qty 5', 'Qty 4', 'Qty 7', 'Qty 6', 'NDN 11', 'NDN 10', 'NDN 13', 'NDN 12', 'NDN 15', 'NDN 14', 'NDN 16', 'Phone', 'SVC 9', 'SVC 8', 'SVC 3', 'SVC 2', 'SVC 1', 'SVC 7', 'SVC 6', 'SVC 5', 'SVC 4', 'Odo', 'Special', 'Qty 14', 'Parts', 'OP 1', 'OP 3', 'OP 2', 'OP 5', 'OP 4', 'OP 7', 'Address', 'OP 9', 'OP 8', 'Qty 11', 'Name', 'License', 'Year', 'Qty 15', 'Model', 'ROI 11', 'ROI 10', 'Trim', 'OriginalEstimate', 'Qty 9', 'NDN 1', 'NDN 3', 'NDN 2', 'NDN 5', 'NDN 4', 'NDN 7', 'NDN 6', 'NDN 9', 'NDN 8', 'Total'])

def generate_pdf(model_id):
	new_dir = "../public/uploads/pdf_form/file/" + model_id
	os.system("mkdir " + new_dir)
	command = "pdftk BAS_inv_new.pdf fill_form temp_data_new.fdf output " + new_dir + "/test_new.pdf flatten" 
	os.system(command)

def create_fdf(data):
	fields = []
	for k in data.keys():
		if k in NEW_KEYS:
			fields += [(k,data[k])]
		elif k == "Repairs":
			for i, repair in enumerate(data["Repairs"]):
				op_key = "OP " + str(i+1)
				roi_key = "ROI " + str(i+1)
				svc_key = "SVC " + str(i+1)
				fields += [(op_key, repair["op"])]
				fields += [(roi_key, repair["instruction"])]
				fields += [(svc_key, repair["svc"])]
		elif k == "Invoice":
			inv = data[k]
			for i in range(5,-1, -1):
				invoice_key = "D " + str(i)
				if inv:
					fields += [(invoice_key, inv[-1])]
					inv = inv[:-1]
				else:
					fields += [(invoice_key, "0")]
	fdf = forge_fdf("",fields,[],[],[])
	fdf_file = open("temp_data_new.fdf","wb")
	fdf_file.write(fdf)
	fdf_file.close()

def read_new_data():
	path = os.path.dirname(os.path.realpath(__file__))
	with open(path + '/temp_dict.json', 'r') as inputfile:
		data = json.load(inputfile)
	return data

if __name__ == "__main__":
	data = read_new_data()
	create_fdf(data)
	model_id = sys.argv[1]
	generate_pdf(model_id)
