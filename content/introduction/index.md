---
weight: 20
title: Introduction
---

## Background
The Netherlands Biodiversity API (NBA) is a public service for retrieving biodiversity 
related data from one of the largest natural history collections in the world, present 
in the Naturalis Biodiversity Center, Leiden, the Netherlands.The NBA provides access to 
more than **8 million specimen records** and counts are steadily growing as our large-scale digitization 
project proceeds. Other than specimen records and metadata, we provide access to taxonomic 
classification and nomenclature, geographical information, and to multimedia files. By using 
the powerful Elasticsearch engine, the NBA facilitates searching for collection- and 
biodiversity data in near real-time. Furthermore, by incorporating information from 
taxonomic databases, taxonomic name resolution can be accomplished with the NBA. 
Persistent Uniform Resource Identifiers (PURLs) ensure that each species accessible 
via the NBA is represented by a citable unambiguous web reference. Access to our data is provided 
via a REST interface and several clients such as the [BioPortal](http://bioportal.naturalis.nl/"), 
a web application for browsing biodiversity data that is based on the NBA.


{{< figure src="https://github.com/naturalis/nba-docs/raw/V2_master/static/images/overview.png" class="alignright" title="NBA overview: From data sources to end users" >}}

## Available data
The NBA provides access to four basic document types that are interlinked:
* A **Specimen** document represents a biological (botanical or zoological) or 
  geological entity stored at Naturalis. Specimen documents usually hold information 
  on preservation, identification, classification, taxonomy (see Taxon documents), and 
  details about the gathering /acquisition process of the specimen, such as 
  geographic location and coordinates.
* **Taxonomic** information about a biological entity is provided in Taxon documents, 
  comprising hierarchy and placement in the Tree of Life, information on synonymy and the 
  mapping to common (species) names. These data consist of two taxonomic databases, 
  the [Catalogue of Life](http://www.catalogueoflife.org/) and [NSR](http://www.nederlandsesoorten.nl/), 
  a comprehensive classification of all species in the Netherlands. Taxon and Specimen documents 
  can be aggregated on fields such as scientific or common taxon names.
* **Multimedia documents**: Specimen and Taxon documents can have associated multimedia content, 
  such as photos, videos or drawings. Multimedia documents contain download links to these resources and 
  additional information about the associated specimen/taxon. 
* Objects of type **GeoArea** refer to geographical regions coded as polygons in the GeoJSON format. 
  The NBA thereby facilitates geographical searches such as searching for all specimens that were collected in a 
  certain region, or, vice versa, retrieve the region (e.g. a specific nature reserve) where a specimen was found. 

## Access
* **REST**: The NBA offers a number of RESTful services that can be directly queried. Most services 
  return JSON content. A summary of available endpoints and data models present in the NBA can be found here [Link: REST endpoints API reference]. 

* **API clients:** To provide easy programmatic access to the NBA, we are currently developing clients for 
  several programming languages. We currently offer the following clients:
  [Java client](https://github.com/naturalis/naturalis_data_api), [javadoc](http://naturalis.github.io/naturalis_data_api/javadoc/v2/client/)

* **Bioportal**
  The [Bioportal](http://bioportal.naturalis.nl/) provides easy access to our data via a web browser. 

