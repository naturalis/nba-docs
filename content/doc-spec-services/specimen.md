---
title: Specimen occurrence services
weight: 40
---

Specimen records constitute the core of data served by the NBA. Museum specimens can represent a whole variety of 
different objects such as plants, animals or single parts thereof, DNA samples, fossils, rocks or meteorites. 
The specimens in our collection are therefore described using an extensive data model. All components and data 
types in the Specimen model, as well as a comprehensive list of all specimen-related endpoints are documented in 
the {{swagger-ui-link text="API endpoint reference"}}. Below, the major components of specimen records are introduced 
and examples are given on how to query them. A list of available fields is also available at

http://145.136.240.125:30076/v2/specimen/metadata/getFieldInfo

## Base URL
The base URL for specimen-specific services is http://145.136.240.125:31932/v2/specimen/

## Data source systems
Specimen occurrence data are harvested from two main data sources, (i) the CRS (Collection Registration System for zoological and 
geological specimens) and (ii) BRAHMS (http://herbaria.plants.ox.ac.uk/bol/) for botanical specimen including fungi. This 
information is stored in the path sourceSystem.code. The query

http://145.136.240.125:31932/v2/specimen/query/?sourceSystem.code=BRAHMS

Will return all plant and fungi specimens. In the future, Naturalis plans to also include specimen occurrence data from 
third-party data providers.

## Identifiers
Specimen records  have several identifiers. The field  `untitID` is the identifier from the specific source system. 
Since uniqueness across source systems is not ensured, the field id, consisting of `{unitID}@{sourceSystem.code}`. Further, the 
field `unitGUID` represents the a permanent uniform web location (PURL, see also PURL services [LINK]).

## Collection types
All of our more than 8 million specimens are categorised into different subcollections (e.g. mammals, aves, 
petrology or paleobotany, …). The following query retrieves the names of all available collections and their specimen counts.

http://145.136.240.125:31932/v2/specimen/getDistinctValues/collectionType

## Gathering events
The gatheringEvent field of a specimen holds all relevant information about the process of obtaining the specimen. 
This includes finder, date, exact location, and information about the estimated specimen age (biostratigraphy/litostratigraphy). 
A use-case could be for instance the retrieval of all specimens that were collected between 1750 and 1800 by P. Miller:

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

As a second example, we query for all specimen that are classified within the family *Passifloraceae* and that have lat-long 
coordinates (fields `gatheringEvent.siteCoordinates.latitudeDecimal`, `gatheringEvent.siteCoordinates.longitudeDecimal`):

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
A crucial part of information about a biological specimen is its identification, i.e. the  assignment to an existing 
taxonomic classification. The identifications field of a specimen can contain one or more species identifications. 
Multiple identifications are possible if for instance a specimen has been re-identified e.g. using a new identification 
key or DNA barcoding. Also concretions containing multiple fossils species will have multiple identifications. To indicate 
that one identification is more reliable than the others, one identification of a specimen can have the `identification.preferred` flag 
set to `true`. Identifications usually store taxonomic rank, the scientific (`identifications.scientificName`) name and higher-level 
classifications (`identifications.defaultClassification`) of the specimen. Also the person who identified the specimen, 
date and references to scientific publications, type status and vernacular (common) taxon names are stored in the identifications block. 
	Furthermore, the identification block features taxonomic enrichments. Taxonomic enrichments basically hold synonyms for species 
name, scientific name, but also for names of higher level taxa. The synonyms are extracted from the Catalogue of Life and 
the Dutch Species Registry. This allows for taxonomic name resolution. 
Example: The common vampire bat was previously classified as *Phyllostoma rotundum* but now the accepted scientific 
name is *Desmodus rotondus*. If we search for the previous name: 

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

We won’t find any specimens of the vampire bat. If we, however, include synonyms into the search:

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

## Multimedia
A specimen record can link to one or more multimedia items. Multimedia information is stored in the multimedia data type. 
Additionally, links to the associated multimedia records are also stored within specimens, 
in the fields `associatedMultiMediaUris.accessUri` and `associatedMultiMediaUris.format`.
