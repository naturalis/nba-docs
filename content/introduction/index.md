---
title: Introduction
weight: 10
---

## Background
The Netherlands Biodiversity API (NBA) facilitates access to the Natural
History Collection at the Naturalis Biodiversity Center. Next to than
museum specimen records and metadata, access to taxonomic
classification and nomenclature, geographical information, and to
multimedia files is provided. By using the powerful Elasticsearch
engine, the NBA facilitates searching for collection- and biodiversity
data in near real-time. Furthermore, by incorporating information from
taxonomic databases, taxonomic name resolution can be accomplished
with the NBA.  Persistent Uniform Resource Identifiers (PURLs) ensure
that each species accessible via the NBA is represented by a citable
unambiguous web reference. Access to our data is provided via a REST
interface and several clients such as the
[BioPortal](http://bioportal.naturalis.nl/"), a web application for
browsing biodiversity data that is served by the NBA.

<figure> <div style="text-align: center;"> <p><img
src="https://github.com/naturalis/nba-docs/raw/V2_master/static/images/overview.png"
align="center" alt="overview" width=500> <figcaption>NBA overview:
From data sources to end users. Icons credit: Freepik from
[flaticon](www.flaticon.com)</figcaption> </div> </figure>


## Available data types 
The NBA provides access to four basic data
types that are interlinked:

* A **Specimen** record represents a biological (botanical or
  zoological) or geological entity stored at Naturalis. Specimen data
  usually comprise information on preservation, identification,
  classification, taxonomy (see below), and details about the
  gathering/acquisition process of the specimen, such as geospatial
  information. Data are harvested from -- currently -- two in-house
  collection registration systems for animal and plant specimens,
  respectively.
* **Taxonomic** information about a biological entity is provided in
  Taxon the taxon data type, comprising hierarchy and placement in the
  Tree of Life, information on synonymy and the mapping to common
  (species) names in different languages. These data are taken from
  two taxonomic databases, the
  [Catalogue of Life](http://www.catalogueoflife.org/) and the
  [Dutch Species Register (NSR)](http://www.nederlandsesoorten.nl/), a
  comprehensive classification of all species in the
  Netherlands. Taxon and Specimen data typesc can be aggregated on
  fields such as scientific or common taxon names.
* **Multimedia** data store photos, videos or drawings that are
  associated with Specimen and Taxon data.  Data sources are our
  in-house collection registration systems and the
  [NSR](http://www.nederlandsesoorten.nl/).
* Objects of type **GeoArea** refer to geographical regions coded as
  polygons in the GeoJSON format.  The NBA thereby facilitates
  geographical searches such as searching for all specimens that were
  collected in a certain region, or, vice versa, retrieve the region
  (e.g. a specific nature reserve) where a specimen was found. Data
  sources are listed in the
  [detailed service description](/doc-spec-services/geo/#geo-sources).

## Services summary 
The services provided by the NBA can be roughly
categorised into the following categories:

* **Query services** provide access to all indexed (and therefore
  searchable) fields within a data type. Simple queries can be written
  as [*human readable queries*](/quickstart/#human-readable) which
  means the query parameters are simply passed as URL
  parameters. [*Complex JSON queries*](/advanced-queries/#queryspec)
  provide a more powerful mechanism to access the data, since query
  terms can be nested, weighted and/or filtered in a more
  sophisticated manner.

* **Data access services** allow the access of specific fields within
  a data type. These fields are generally identifier fields. Note that
  all data access services are essentially query services for a
  certain value, implemented for a more convenient user experience.

* **Type specific metadata services** give information about data type
  specific fields and settings. This includes information about
  available fields and paths and the supported operators for comparison.

* **General metadata services** provide general information not
  specific to document types. This includes general settings and
  controlled vocabularies for certain field values.

* **Download services** facilitate the bulk retrieval of query results
  as
  [Darwin Core Archive(DwCA)](https://en.wikipedia.org/wiki/Darwin_Core_Archive)
  files.

* **Aggregation services** summarise a list of query results based on
  values that are shared for certain fields. Currently, this grouping
  is supported for specimen and taxon data types and the grouping is
  done on the scientific name.


A complete list of services can be found in the {{%swagger-ui-link
text="API endpoint reference"%}}{{%/swagger-ui-link%}}.  The table
below lists the NBA's different service types and gives links to
specific documentation resources and examples.

<center>

| <br> Service type |  | Document type |            | 
|------------------------------|------------|--------|-----------------|-------------|
|                         |  **Specimen**  | **Taxon**  | **GeoArea**  | **Multimedia**  |
| [**Query**](/quickstart/#human-readable)<br>[**Query (JSON)**](/advanced-queries/#queryspec) | Path:<br> /specimen/query/<br>  {{%table-links type="specimen" name="queryHttpGet_2"%}} <br> [Examples](/doc-spec-services/specimen)  | Path:<br> /taxon/query/<br> {{%table-links type="taxon" name="queryHttpGet_3"%}} <br> [Examples](/doc-spec-services/taxon)  | Path: <br> /geo/query/<br>{{%table-links type="geo" name="queryHttpGet"%}}<br>[Examples](/doc-spec-services/geo) |  Path: <br> /multimedia/query/<br> {{%table-links type="multimedia" name="queryHttpGet_1"%}}<br>[Examples](/doc-spec-services/multimedia)                |
| **Data access** | {{%table-links-sw-ex name="findByUnitID"%}}<br>[Examples](/doc-spec-services/specimen) | {{%table-links-sw-ex name="find_4"%}}<br>[Examples](/doc-spec-services/taxon ) | {{%table-links-sw-ex name="find_1"%}}<br>[Examples](/doc-spec-services/geo) | {{%table-links-sw-ex name="find_2"%}}<br>[Examples](/doc-spec-services/multimedia)
| **Download (static)**  | Path: <br> /specimen/dwca/getDataSet/<br> {{%table-links-sw-ex type="specimen" name="dwcaGetDataSet1"%}}<br>[Examples](/doc-spec-services/specimen#dl) | Path: <br> /taxon/dwca/getDataSet/ <br> {{%table-links-sw-ex type="taxon" name="dwcaGetDataSet2"%}}<br>[Examples](/doc-spec-services/taxon#dl) | not available | not available |
| **Download (dynamic)**  | Path: <br> /specimen/dwca/query/<br> {{%table-links-sw-ex type="specimen" name="dwcaQuery"%}}<br>[Examples](/doc-spec-services/specimen#dl) | Path: <br> /taxon/dwca/query/<br> {{%table-links-sw-ex type="taxon" name="dwcaQueryHttpGet"%}}<br>[Examples](/doc-spec-services/taxon#dl) | not available | not available |
| **Metadata (data specific)** | Path: <br>/specimen/metadata/ <br> {{%table-links-sw-ex type="specimen" %}}<br>[Examples](/doc-spec-services/specimen#md) | Path: <br>/taxon/metadata/ <br> {{%table-links-sw-ex type="taxon"%}}<br>[Examples](/doc-spec-services/taxon#md) | Path: <br>/geo/metadata/  <br> {{%table-links-sw-ex type="geo"%}} <br>[Examples](/doc-spec-services/geo#md) | Multimedia: <br>/multimedia/metadata/  <br> {{%table-links-sw-ex type="multimedia"%}}<br>[Examples](/doc-spec-services/multimedia#md)
| **Metadata (general)** | | Path: /metadata/ <br> {{%table-links-metadata%}}<br>[Examples](/doc-spec-services/metadata) |
| **Aggregation** | Path: <br> /specimen/groupByScientificName/ {{%table-links-sw-ex type="specimen" name="groupByScientificName_GET1"%}}<br>[Examples](/advanced-queries/#agg) | Path: <br> /taxon/groupByScientificName/ {{%table-links-sw-ex type="taxon" name="groupByScientificName_GET2"%}}<br>[Examples](/advanced-queries/#agg) | not available | not available

</center>

## Access to data
### REST
The NBA is implemented as a
[RESTful](https://en.wikipedia.org/wiki/Representational_state_transfer)
API and can thus be accessed using standard REST clients or a web
browser. For exploration or testing of the NBA services and/or PURL
services we recommend using a command-line tool for transferring data
as e.g. [curl](https://curl.haxx.se/) or a rest client browser plugin,
e.g. the [chrome rest client](https://advancedrestclient.com/).  A
summary of available REST endpoints and data models present in the NBA
can be found {{%swagger-ui-link text="here"%}}{{%/swagger-ui-link%}}.

### API clients {#api-clients} 
To provide programmatic access to the NBA, Naturalis plans to develop
clients for several programming languages. Thes clients are build upon
the NBA REST architecture and facilitate the integration of NBA access
within scripts or software applications.  Currently, a NBA
[Java client](https://github.com/naturalis/naturalis_data_api) is
available (see
[javadoc](http://naturalis.github.io/naturalis_data_api/javadoc/v2/client/)).

### Bioportal
The [Bioportal](http://bioportal.naturalis.nl/) provides easy access
via a web interface from which the user can browse and query the
Naturalis collection data. The Bioportal makes use of (a part of) the
NBA services to retrieve and display the data.

