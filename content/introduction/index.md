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

## Access to data
* **REST**: The NBA offers a number of RESTful services that can be directly queried. Most services 
  return JSON content. A summary of available endpoints and data models present in the NBA can be found {{<swagger-ui-link text="here">}}. 

* **API clients:** To provide easy programmatic access to the NBA, Naturalis plans to develop clients for several programming languages. 
  Currently, a [Java client](https://github.com/naturalis/naturalis_data_api) is available (see [javadoc](http://naturalis.github.io/naturalis_data_api/javadoc/v2/client/))

* **Bioportal**
  The [Bioportal](http://bioportal.naturalis.nl/) provides easy access to our data via a web browser. 

