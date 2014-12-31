#!python
from fdfgen import forge_fdf
import json, ast
import os

def generate_pdf():
	command = "pdftk BAS_inv_new.pdf fill_form data_new.fdf output filled_new.pdf" 
	os.system(command)

def create_fdf(data_fields_dict):
	fields = []
	del data_fields_dict['RESET']
	for k in data_fields_dict.keys():
		fields += [(k,data_fields_dict[k]["possible_values"][0])]
	fdf = forge_fdf("",fields,[],[],[])
	fdf_file = open("data_new.fdf","wb")
	fdf_file.write(fdf)
	fdf_file.close()

def get_data_fields():
	
	data_fields_dict = {}
	if False:
		with open('data_fields_new.json', 'r') as inputfile:
			data_fields_dict =  json.load(inputfile)
	else:
		fname = 'data_fields_new.txt'
		lines = [line.strip() for line in open(fname)]
		curr_key = None
		default_value = "1"
		for line in lines:
			if "FieldName: " in line:
				k = get_value(line)
				if not k:
					print "WAAAAAAAAT"
				curr_key = k
				data_fields_dict[curr_key] = {"alias": default_value, "possible_values": [default_value]}
				default_value = str(int(default_value) + 1)

			if "FieldValue: " in line or "FieldStateOption: " in line:
				v = get_value(line)
				if v:
					data_fields_dict[curr_key]["possible_values"].append(v)
		with open('data_fields_new.json', 'wb') as fp:
		    json.dump(data_fields_dict, fp)

	return data_fields_dict

def get_value(line):
	return line.split(":")[1].strip()

if __name__ == "__main__":
	data_fields_dict = get_data_fields()
	create_fdf(data_fields_dict)
	generate_pdf()