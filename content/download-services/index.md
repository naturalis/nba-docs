---
weight: 40
title: Download Services
---

# Download services

NBA’s download services offer bulk retrieval of taxonomic and specimen occurrence data. Instead of 
JSON format, download services return zip files containing the data. The zip files are formatted according to the [Darwin Core 
archive standard for the exchange of biodiversity data](http://tools.gbif.org/dwca-assistant/gbif\_dwc-a\_asst\_en\_v1.1.pdf) (also see below). 
While static download services offer pre-compiled datasets, dynamic download services produce Darwin Core archives for the results of any query 
for taxon or specimen documents.


## Static download service
The path for static downloads is `/{specimen|taxon}/dwca/getDataSet/{name}` with the name of a specific dataset. The names of predefined datasets can be 
retrieved with the endpoint `getDataSetNames`, for example for specimen documents:

http://145.136.240.125:31932/v2/specimen/dwca/getDataSetNames

A dataset, for instance the *tunicata* can then be downloaded as follows:

http://145.136.240.125:31932/v2/specimen/dwca/getDataSet/tunicata


## Dynamic download service
Dynamic download queries follow the same syntax as regular queries with the query endpoint. Suppose we have a simple query 
for taxa from the catalogue of life that are in the genus crocus: 

http://145.136.240.125:31932/v2/taxon/query?sourceSystem.code=COL&defaultClassification.genus=Crocus

Simply adding the path dwca in front of query will return the zipped archive:

http://145.136.240.125:31932/v2/taxon/dwca/query?sourceSystem.code=COL&defaultClassification.genus=Crocus


## Darwin Core archives
Following files are contained in the zip archives generated by the download services:

* A *core data file* in csv format named Occurrence.txt and Taxa.txt for specimen and taxon downloads, respectively. 
  This file contains a tabular representation of the data with the first row defining the column names. 
* A *descriptor file* named meta.xml which maps the columns in the core data file to their respective [TWDG term](http://rs.tdwg.org/dwc/terms/). 
  Each column in the data is thus mapped to a specific concept termed by the TDWG consortium.
* A *metadata file* named eml.xml formatted according to the Electronic Metadata Language specification 
  [EML](https://knb.ecoinformatics.org/#external//emlparser/docs/index.html). Metadata in this file includes a description of 
  the dataset and details about the source institution.
* *Extension data*: For taxa, the csv file Vernacular_names.txt gives information about common taxon names. 
  The mapping of columns to TDWG terms is provided in meta.xml.