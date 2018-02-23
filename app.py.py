import pandas as pd
import numpy as np
import json

from flask import Flask, jsonify

################
# Data points
################
# 1- Belly Buttons Sample
################
sample_name_path= "/Users/chris/OneDrive/Documents/GitHub/Homework/Week15/belly_button_biodiversity_samples.csv"
sample_name = pd.read_csv(sample_name_path,encoding='iso-8859-1',low_memory=False)
sample_name=sample_name.drop(["otu_id"],axis=1)
sample_list = list(sample_name)
################
#2- Belly Button description
bb_definition_path = "/Users/chris/OneDrive/Documents/GitHub/Homework/Week15/belly_button_biodiversity_otu_id.csv"
bb_definition = pd.read_csv(bb_definition_path,encoding='iso-8859-1',low_memory=False)
bb_definition = bb_definition.drop(["otu_id"],axis=1)
bb_definition_list = bb_definition.values.tolist()
bb_definition_list
#################
#3- Belly Button META data
#################
bb_meta_path = "/Users/chris/OneDrive/Documents/GitHub/Homework/Week15/Belly_Button_Biodiversity_Metadata.csv"
bb_meta = pd.read_csv(bb_meta_path,encoding='iso-8859-1',low_memory=False)
bb_meta_list= bb_meta.to_json(orient='records')
bb_meta_list= print(json.dumps(json.loads(bb_meta_list), indent=2, sort_keys=True))
bb_meta_list
##############################################################
# Flask setup
##############################################################
app = Flask(__name__)
##############################################################
# Flask route
##############################################################
@app.route("/")
	"""Return the dashboard homepage."""
@app.route('/names')
	 """List of sample names."""
	 return (sample_list)
@app.route('/otu')
	"""List of OTU descriptions."""
	return (bb_definition_list)
@app.route('/metadata/<sample>')
	"""MetaData for a given sample."""

    Args: Sample in the format: `BB_940`
    return (bb_meta_list)
if __name__ == '__main__':
	app.run(debug=True)