# EcotaxaScripts
Scripts for the export, import, and management of project data from Ecotaxa Servers

**Non-Native Packages:**

* argparse - used to add easy-to-read command arguments to scripts
* beautifulsoup4 - used for parsing html files for EcotaxaExport
* imageio - used in generating images for BuildMLDataSet
* requests - used for web-scraping with EcotaxaExport
* numpy - used for graphing in BuildMLDataSet
* pandas - used for easy reading of excel & csv files in BuildMLDataSet

# EcotaxaExport
**Summary:**
Using provided user information, connects to Ecotaxa server and pulls specific projects 
in basic .tsv format

**Arguments:**

* -u / --user           (required) email of Ecotaxa account
* -i / --ids            (required) ids of projects to be downloaded, separated by a space
    - 0 to export all projects
* -p / --path           (optional) path script will export to
    - default: cwd
* -a / --authorization  (optional) provide password for Ecotaxa via command-line
    - default: Manuel entry of password
```
example:
python3 EcotaxaExport -u exampleuser@website.net -i 1234 4321 0101 -p /path/of/export -a password
```

# BuildScientificDataSet
**Summary:**
Generates a matlab table struct using binary metadata from options stored in cfg file

**Arguments:**
* -p / --cfgpath (optional) defines path to cfg file
    - default: cwd
    - NOTE: WILL NOT RUN WITOUT CFG

```
example:
python3 BuildScientificDataSet.py -p /path/to/cfg
```

# BuildMLDataSet
**Summary:**
Combines tsv files exported from ecotaxa, metadata(exported to csv files), & raw images into a dataset. This dataset is
composed of a master.csv file linking images back to IFCB names, a learning & testing subset containing class-organized
photos & a metadata csv for all photos within a subset. Images not placed into a subset are added to the Excluded
folder.

**Arguments:**
* -e / --ecotaxadirectory (required) path to exported ecotaxa tsv files
* -r / --rawdirectory (required) directory of IFCB folder containing raw binary metadata
* -meta/ --metadirectory (required) directory of metadata CSVs
* -o / --outputdirectory (optional) directory of desired output
    - default: ./Dataset in cwd
* -m / --mode (optional) specifies image titling options from taxonomy spreadsheet
    - choices: 'species' or 'group'
    - default: 'species'
* -t / --taxfile (optional) directory of taxonomic translation spreadsheet
    - default: cwd
* -c / --classes (optional) class names separated by spaces which should be removed from the dataset(added to excluded)
    - default: classes with < 10 images
    
```
example:
python3 BuildMLDataSet.py -e /Path/To/Ecotaxa/Exportfiles -meta /Path/To/Metadata/CSVs -r /Path/to/Raw_Images -t /Path/To/Taxonomy_file -o /Desired/Output/Path
```
