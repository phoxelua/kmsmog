import re
from sets import Set
import csv
from unidecode import unidecode

def read():
	lines = [line.strip() for line in open('raw')]
	lines = lines[3:]
	tripled = []
	for line in lines:
		temp = line.split(',')
		year = temp[0].translate(None,',();')
		make = unidecode(temp[1].split("'")[1].decode('utf-8'))
		model = unidecode(temp[2].translate(None,',();').decode('utf-8'))
		tripled += [(year, make, model)]
	return tripled

# ignore year for now
def write(triples):
	mm_set = Set([(t[1], t[2]) for t in triples])
	make_set = Set([])
	make_dict = {}

	make_data = []
	model_data = []
	make_id = 1
	for pair in mm_set:
		make = pair[0]
		model = pair[1]
		if make not in make_set:
			make_set.add(make)
			make_dict[make] = make_id

			make_data += [[make_id, make]]
			model_data += [[model, make_id]]
			make_id += 1
		else:
			model_data += [[model, make_dict[make]]]
	with open('make.csv', 'w') as fp:
	    a = csv.writer(fp, delimiter=',')
	    a.writerows(make_data)	

	with open('model.csv', 'w') as fp:
	    a = csv.writer(fp, delimiter=',')
	    a.writerows(model_data)	

if __name__ == "__main__":
	triples = read()
	write(triples)	