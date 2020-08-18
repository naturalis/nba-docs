---
title: Specimen occurrence services
weight: 30
---

Specimen records constitute the core of data served by the NBA. Museum
objects and observations can represent a whole variety of different entities such as
plants, animals or single parts thereof, DNA samples, fossils, rocks
or meteorites. Also species occurrences are described as a specimen in our data. 
The specimens in our document store are therefore
described with an extensive data model. All components and data types
in the Specimen model, as well as a comprehensive list of all
specimen-related endpoints are documented in the {{%swagger-ui-link
text="API endpoint reference"%}}{{%/swagger-ui-link%}}. Below, the
major components of specimen records are introduced and examples are
given on how to query them. A list of available fields can be found at
{{%nba-link%}}specimen/metadata/getFieldInfo{{%/nba-link%}}

## Base URL 
The base URL for specimen-specific services is
{{%nba-link-text%}}specimen{{%/nba-link-text%}}

## Data source systems 
Specimen occurrence data are harvested from four
main data sources, (i) the CRS (Collection Registration System for
zoological and geological specimens), (ii) BRAHMS
(http://herbaria.plants.ox.ac.uk/bol/) for botanical specimen
including fungi, (iii) the [Xeno-canto](https://www.xeno-canto.org/) database
of bird sounds, and (iv) species occurrences from 
[Observation International](https://observation.org/).
This information is stored in the path
*sourceSystem.code*. The query

{{%nba-link%}}specimen/query/?sourceSystem.code=BRAHMS{{%/nba-link%}}

will return all plant and fungi specimens. 

## Available services

### Query
Querying for specimens can be done using the 
{{%swagger-ui-link text="/specimen/query/endpoint"%}}#/specimen/queryHttpGet_2{{%/swagger-ui-link%}}, 
which accepts human-readable query strings and JSON encoded
[QuerySpec](/advanced-queries/#queryspec) parameters.

#### Retrieving large quantities of data
Note that the query service is limited to a maximum of 10.000 rercords to retrieve
with one query. For larger quantities, we offer a *download* service which returns the
data as a gzipped JSON stream. For example, retrieving the entire botany collection, 
the {{%swagger-ui-link text="/specimen/download"%}}#/specimen/downloadQueryHttpGet_1{{%/swagger-ui-link%}},  
service can be used. 

### Data access 
Several access methods offer the convenient retrieval
of specimens matching a certain identifier or being part of a certain
collection.  The services 
{{%swagger-ui-link text="/specimen/findByUnitID/"%}}#/specimen/findByUnitID{{%/swagger-ui-link%}},
{{%swagger-ui-link text="/specimen/find/"%}}#/specimen/find_3{{%/swagger-ui-link%}} and
{{%swagger-ui-link text="/specimen/findByIds/"%}}#/specimen/findByIds_3{{%/swagger-ui-link%}}
retrieve specimens according to their `unitID` or `id` fields (see
[here](#specids)).  The service 
{{%swagger-ui-link text="/specimen/getNamedCollections/"%}}#/specimen/getNamedCollections{{%/swagger-ui-link%}}
returns all available collections of species (e.g. *Mammalia*) and
{{%swagger-ui-link text="/specimen/getIdsInCollection/"%}}#/specimen/getIdsInCollection{{%/swagger-ui-link%}}
returns all identifiers of specimen that are part of that collection.

### Aggregation
A count aggregation of query results (using query parameters or a QuerySpec object) can be done using the 
{{%swagger-ui-link text="/specimen/count/"%}}#/specimen/countHttpGet_2{{%/swagger-ui-link%}} endpoint. 

For a specific field, {{%swagger-ui-link text="/specimen/getDistinctValues/"%}}#/specimen/getDistinctValuesHttpGet_2{{%/swagger-ui-link%}} 
returns all different values that there is in the data or that field. 

Nested aggreation over two fields can be done with 
{{%swagger-ui-link text="/specimen/getDistinctValuesPerGroup/"%}}#/specimen/getDistinctValuesPerGroupHttpGet_2{{%/swagger-ui-link%}}

{{%swagger-ui-link text="/specimen/countDistinctValues/"%}}#/specimen/countDistinctValuesHttpGet_2{{%/swagger-ui-link%}}
and {{%swagger-ui-link text="/specimen/countDistinctValuesPerGroup/"%}}#/specimen/countDistinctValuesPerGroupHttpGet_2{{%/swagger-ui-link%}}
do the same as the above, but return only the counts instead of any data.

For more information and examples on aggregation queries, please also refer to the 
[advanced queries](/advanced-queries/#agg) section. 

### DwC-A download{#dl}
Download services offer bulk retrieval of specimen occurrence
data. Instead of JSON format, download services return zip files
containing the data. The zip files are formatted according to the
[Darwin Core archive standard for the exchange of biodiversity data](http://tools.gbif.org/dwca-assistant/gbif\_dwc-a\_asst\_en\_v1.1.pdf)
(also see below).  While *collection* download services offer
pre-compiled datasets, dynamic download services produce Darwin Core
archives for the results of any query for taxon or specimen data
types.

#### Specimen collection DwC-A download

The endpoint for specimen collection downloads is 
{{%swagger-ui-link text="/specimen/dwca/getDataSet/"%}}#/specimen/dwcaGetDataSet1{{%/swagger-ui-link%}}
with the name of a specific dataset. The names of predefined datasets
can be retrieved with the endpoint 
{{%swagger-ui-link text="/specimen/dwca/getDataSetNames/"%}}#/specimen/dwcaGetDataSetNames1{{%/swagger-ui-link%}}. 
A dataset, for instance the *tunicata* can then be downloaded as
follows:

{{%nba-link%}}specimen/dwca/getDataSet/tunicata{{%/nba-link%}}

#### Dynamic DwC-A download
Dynamic download queries follow the same syntax as regular queries
with the query endpoint. Suppose we have a simple query for specimen
of the genus crocus:

{{%nba-link%}}specimen/query/?identifications.defaultClassification.genus=Crocus{{%/nba-link%}}

Simply adding the path dwca in front of query will return the zipped
archive:

{{%nba-link%}}specimen/dwca/query/?identifications.defaultClassification.genus=Crocus{{%/nba-link%}}

#### Darwin Core archives
Following files are contained in the zip archives generated by the
download services:

* A *core data file* in csv format named Occurrence.txt.  This file
  contains a tabular representation of the data with the first row
  defining the column names.
* A *descriptor file* named meta.xml which maps the columns in the
  core data file to their respective
  [TDWG term](http://rs.tdwg.org/dwc/terms/).  Each column in the data
  is thus mapped to a specific concept termed by the TDWG consortium.
* A *metadata file* named eml.xml formatted according to the
  Electronic Metadata Language specification
  [EML](https://knb.ecoinformatics.org/#external//emlparser/docs/index.html). Metadata
  in this file includes a description of the dataset and details about
  the source institution.

### Metadata{#md}
Specimen metadata services provide miscellaneous information about
specimen records.  This includes detailed information about a
specimen's 
{{%swagger-ui-link text="fields"%}}#/specimen/getFieldInfo_2{{%/swagger-ui-link%}} and
{{%swagger-ui-link text="paths"%}}#/specimen/getPaths_2{{%/swagger-ui-link%}}. 
A description of all specimen metadata services can be found
{{%swagger-ui-link text="here"%}}#/specimen{{%/swagger-ui-link%}}.

## Identifiers{#specids}
Specimen records have several identifiers. The field `untitID` is the
identifier from the specific source system.  Since uniqueness across
source systems is not ensured, the field id, consisting of
`{unitID}@{sourceSystem.code}`. Further, the field `unitGUID`
represents the a permanent uniform web location (PURL, see also
[PURL services](/purl-services)).

## Collection types 
All specimens are categorised into different subcollections (e.g. mammals, aves,
petrology or paleobotany, birdsounds, observations, …). The following query retrieves the names
of all available collections and their specimen counts.

{{%nba-link%}}specimen/getDistinctValues/collectionType{{%/nba-link%}}

## Gathering events
The gatheringEvent field of a specimen holds all relevant information
about the process of obtaining the specimen.  This includes finder,
date, exact location, and information about the estimated specimen age
(biostratigraphy/litostratigraphy).  A use-case could be for instance
the retrieval of all specimens that were collected between 1750 and
1800 by P. Miller:

```JSON
{
  "conditions": [
    {
      "field": "gatheringEvent.dateTimeBegin",
      "operator": "BETWEEN",
      "value": [
        "1750",
        "1800"
      ]
    },
    {
      "field": "gatheringEvent.gatheringPersons.fullName",
      "operator": "EQUALS",
      "value": "Miller, P"
    }
  ],
  "sortFields": [
    {
      "path": "gatheringEvent.dateTimeBegin",
      "sortOrder": "ASC"
    }
  ]
}
```

As a second example, we query for all specimen that are classified
within the family *Passifloraceae* and that have lat-long coordinates
(fields `gatheringEvent.siteCoordinates.latitudeDecimal`,
`gatheringEvent.siteCoordinates.longitudeDecimal`):

```JSON
{
  "conditions": [
    {
      "field": "identifications.defaultClassification.family",
      "operator": "EQUALS",
      "value": "Passifloraceae"
    },
    {
      "field": "gatheringEvent.siteCoordinates.longitudeDecimal",
      "operator": "NOT_EQUALS",
      "value": null
    },
    {
      "field": "gatheringEvent.siteCoordinates.latitudeDecimal",
      "operator": "NOT_EQUALS",
      "value": null
    }
  ]
}
```

## Identifications
A crucial part of information about a biological specimen is its
identification, i.e. the assignment to an existing taxonomic
classification. The identifications field of a specimen can contain
one or more species identifications.  Multiple identifications are
possible if for instance a specimen has been re-identified e.g. using
a new identification key or DNA barcoding. Also concretions containing
multiple fossils species will have multiple identifications. To
indicate that one identification is more reliable than the others, one
identification of a specimen can have the `identification.preferred`
flag set to `true`. Identifications usually store taxonomic rank, the
scientific (`identifications.scientificName`) name and higher-level
classifications (`identifications.defaultClassification`) of the
specimen. Also the person who identified the specimen, date and
references to scientific publications, type status and vernacular
(common) taxon names are stored in the identifications block.

Furthermore, the {{%nba-link%}}specimen/metadata/queryWithNameResolution{{%/nba-link%}} 
service allows for searching  for specimens by names other than the 
assigned taxonomic classification(s). The service accepts queries with 
a `nameResolutionRequest` clause, which triggers a sub-query for
synonyms and/or vernacular names in the Catalogue of Life and the Dutch
Species Register. From the resulting records, scientific names are 
extracted, which are subsequently used for the main specimen search. 
Example:
When we're not sure of the accepted scientific name of the European
badger, we could search directly for specimen that contain 'badger' as
part of the specimen record, using {{%nba-link%}}specimen/metadata/query{{%/nba-link%}}:

```JSON
{
  "conditions" : [
    { "field" : "identifications.vernacularNames.name", "operator" : "MATCHES", "value" : "badger" }
  ],
  "size": 1000
}
```

However, as the `vernacularNames` field is not mandatory, the query 
returns only a small number of records. If we, however, employ the name
resolution request, using {{%nba-link%}}specimen/metadata/queryWithNameResolution{{%/nba-link%}}:

```JSON
{
  "conditions": [],
  "nameResolutionRequest" : 
    {
      "searchString" : "badger",
      "nameTypes" : [ "VERNACULAR_NAME" ],
      "matchWholeWords" : true,
      "useCoL" : false,
      "size" : 100
   },
  "size": 1000
}
```

We will get a complete set of badger-specimens in the results.

When `useCoL` is set to true, the service will find scientific names by matching
the search string against the Catalogue of Life name usage API (https://api.catalogue.life/nameusage),
rather than by querying the Dutch Species Register and a local copy of the 
Catalogue of Life. As the external service searches more recent data, this might
improve results. But also be aware that when `useCoL` is set to true, your query
is partly dependent on an external service the availability of which we have no
direct control over.

Please note that the `nameResolutionRequest` currently only supports MATCHES 
and CONTAINS (`matchWholeWords : true` or `false`), which means that you may
get a wide array of matching names in your results.

To gain insight in the inner workings of `nameResolutionRequest` and see the
results of the sub-query, you can run your query against
{{%nba-link%}}specimen/metadata/explainNameResolution{{%/nba-link%}}. The output
provides insight into the intermediate results, as well as the precise effect of
the different query parameters.

<!--
Furthermore, the identification block features taxonomic
enrichments. Taxonomic enrichments basically hold synonyms for species
name, scientific name, but also for names of higher level taxa. The
synonyms are extracted from the Catalogue of Life and the Dutch
Species Register. This allows for taxonomic name resolution.  Example:
The common vampire bat was previously classified as *Phyllostoma
rotundum* but now the accepted scientific name is *Desmodus
rotondus*. If we search for the previous name:

```JSON
{
  "conditions": [
    {
      "field": "identifications.scientificName.fullScientificName",
      "operator": "MATCHES",
      "value": "Phyllostoma rotundum"
    }
  ],
  "fields": [
    "identifications.scientificName.fullScientificName"
  ],
  "size": 1000
}
```

We won’t find any specimens of the vampire bat. If we, however,
include synonyms into the search:

```JSON
{
  "conditions": [
    {
      "field": "identifications.scientificName.fullScientificName",
      "operator": "MATCHES",
      "value": "Phyllostoma rotundum",
      "or": [
        {
          "field": "identifications.taxonomicEnrichments.synonyms.fullScientificName",
          "operator": "MATCHES",
          "value": "Phyllostoma rotundum"
        }
      ]
    }
  ],
  "fields": [
    "identifications.scientificName.fullScientificName"
  ],
  "size": 1000
}
```

We will have multiple vampire bat specimen in the results.
-->


## Multimedia
A specimen record can link to one or more multimedia items. Multimedia
information is stored in the multimedia data type.  Additionally,
links to the associated multimedia records are also stored within
specimens, in the fields `associatedMultiMediaUris.accessUri` and
`associatedMultiMediaUris.format`.
