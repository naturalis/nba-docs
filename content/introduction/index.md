---
type: index
title: Introduction
weight: 10
---

## Background

The Netherlands Biodiversity API (NBA) is a public service for retrieving biodiversity 
related data from one of the largest natural history collections in the world, present 
in the Naturalis Biodiversity Center, Leiden, the Netherlands. The NBA provides access to 
more than **8 million specimen records** and counts are steadily growing as our large-scale digitization 
project proceeds. Other than specimen records and metadata, access to taxonomic 
classification and nomenclature, geographical information, and to multimedia files is provided. By using 
the powerful Elasticsearch engine, the NBA facilitates searching for collection- and 
biodiversity data in near real-time. Furthermore, by incorporating information from 
taxonomic databases, taxonomic name resolution can be accomplished with the NBA. 
Persistent Uniform Resource Identifiers (PURLs) ensure that each species accessible 
via the NBA is represented by a citable unambiguous web reference. Access to our data is provided 
via a REST interface and several clients such as the [BioPortal](http://bioportal.naturalis.nl/"), 
a web application for browsing biodiversity data that is based on the NBA.


<!-- {{< figure src="https://github.com/naturalis/nba-docs/raw/V2_master/static/images/overview.png" class="alignright" title="NBA overview: From data sources to end users" >}} -->

<figure>
<div style="text-align: center;">
	<p><img src="https://github.com/naturalis/nba-docs/raw/V2_master/static/images/overview.png" align="center"
		alt="overview" width=500>
		<figcaption>NBA overview: From data sources to end users</figcaption>
	</div>
</figure>


## Available data types
The NBA provides access to four basic data types that are interlinked:

* A **Specimen** represents a biological (botanical or zoological) or 
  geological entity stored at Naturalis. Specimen data usually comprise information 
  on preservation, identification, classification, taxonomy (see below), and 
  details about the gathering/acquisition process of the specimen, such as 
  geospatial information. Data are harvested from -- currently -- two in-house collection registration systems 
  for animal and plant specimens, respectively.
* **Taxonomic** information about a biological entity is provided in Taxon the taxon data type, 
  comprising hierarchy and placement in the Tree of Life, information on synonymy and the 
  mapping to common (species) names in different languages. These data are taken from two taxonomic databases, 
  the [Catalogue of Life](http://www.catalogueoflife.org/) and [NSR](http://www.nederlandsesoorten.nl/), 
  a comprehensive classification of all species in the Netherlands. Taxon and Specimen data types 
  can be aggregated on fields such as scientific or common taxon names.
* **Multimedia** data store photos, videos or drawings that are associated with Specimen and Taxon data.
  Data sources are our in-house collection registration systems and the [NSR](http://www.nederlandsesoorten.nl/). 
* Objects of type **GeoArea** refer to geographical regions coded as polygons in the GeoJSON format. 
  The NBA thereby facilitates geographical searches such as searching for all specimens that were collected in a 
  certain region, or, vice versa, retrieve the region (e.g. a specific nature reserve) where a specimen was found. Data sources
  are listed in the [detailed service description](/doc-spec-services/#geo-sources).

## Services summary
The services provided by the NBA can be roughly categorised into the following categories:

* **Query services** provide access to all indexed (and therefore searchable) fields within a data type. Simple queries
can be written as  [*human readable queries*](/quickstart/#human-readable) which means the query parameters are simply passed as 
URL parameters. [*Complex JSON queries*](/quickstart/#human-readable)
provide a more powerful mechanism to access the data, since query terms can be nested, weighted and filtered in a more sophisticated manner.

* **Data access services** allow the access of specific fields within a data type. These fields are generally identifier fields.

* **Type specific metadata services** give information about data type specific fields and settings. This includes information about available
fields and paths and the supported operators for comparison. 

* **General metadata services**

* **Download services** facilitate the bulk retrieval of query results as 
[Darwin Core Archive (DwCA)](https://en.wikipedia.org/wiki/Darwin_Core_Archive) files. While [*static download services*](/download-services/#dl-static) offer predefined
data sets from our collection, [*dynamic download services*](/download-services/#dl-dynamic) allow for the download of any query result as DwCA files.


* **Aggregation services**

A complete list of services can be found in the {{%swagger-ui-link text="API endpoint reference"%}}{{%/swagger-ui-link%}}.
The table below lists the NBA's different service types and gives links to specific documentation 
resources and examples. 

<center>

| <br> Service type |  | Document type |            | 
|-------------------------|------------|--------|-----------------|-------------|
|                         |  **Specimen**  | **Taxon**  | **GeoArea**  | **Multimedia**  |
| [**Query (human readable)**](/quickstart/#human-readable)<br>for testing<br>[**Query (JSON)**](/advanced-queries/#queryspec)<br>for complex queries  | Path:<br> /specimen/query/<br>  {{%table-links type="specimen" ex="/doc-spec-services/specimen"%}} | Path:<br> /taxon/query/<br> {{%table-links type="taxon" ex="/doc-spec-services/taxon"%}} | Path: <br> /geo/query/<br>{{%table-links type="geo" ex="/doc-spec-services/geo"%}} |  Path: <br> /multimedia/query/<br> {{%table-links type="multimedia" ex="/doc-spec-services/multimedia"%}}                |
| **Data access** | | {{%table-links-metadata ex="/doc-spec-services/metadata"%}} |
| **Download (static)**  | Path: <br> /specimen/dwca/getDataSet/<br> {{%table-links-dl type="specimen" ex="/download-services/#dl-static" name="dwcaGetDataSet1"%}} | Path: <br> /taxon/dwca/getDataSet/ <br> {{%table-links-dl type="taxon" ex="/download-services/#dl-static" name="dwcaGetDataSet2"%}} | not available | not available |
| **Download (dynamic)**  | Path: <br> /specimen/dwca/query/<br> {{%table-links-dl type="specimen" ex="/download-services/#dl-dynamic" name="dwcaQuery"%}} | Path: <br> /taxon/dwca/query/<br> {{%table-links-dl type="taxon" ex="/download-services/#dl-static" name="dwcaQueryHttpGet"%}} | not available | not available |
| **Metadata (data specific)** | Path: <br>/specimen/metadata/ | Path: <br>/taxon/metadata/ | Path: <br>/geo/metadata/ | Multimedia: <br>/multimedia/metadata/
| **Metadata (general)** | | {{%table-links-metadata ex="/doc-spec-services/metadata"%}} |


</center>

## Access to data
### REST
The NBA is implemented as a [RESTful](https://en.wikipedia.org/wiki/Representational_state_transfer) API and can thus be accessed
using standard REST clients or a web browser. For exploration or testing of the NBA services and/or PURL services we recommend using a 
command-line tool for transferring data as e.g. [curl](https://curl.haxx.se/) or a rest 
client browser plugin, e.g. the [chrome rest client](https://advancedrestclient.com/).
A summary of available REST endpoints and data models present in the NBA can be found {{<swagger-ui-link text="here">}}.

### API clients
To provide programmatic access to the NBA, Naturalis plans to develop clients for several programming languages. Thes clients 
are build upon the NBA REST architecture and facilitate the integration of NBA access within scripts or software applications.
Currently, a NBA [Java client](https://github.com/naturalis/naturalis_data_api) is 
available (see [javadoc](http://naturalis.github.io/naturalis_data_api/javadoc/v2/client/)).

### Bioportal
The [Bioportal](http://bioportal.naturalis.nl/) provides easy access via a web interface from which the user can browse and query 
the Naturalis collection data. The Bioportal makes use of (a part of) the NBA services to retrieve and display the data.

