---
title: Taxonomic data services
weight: 50
---

A taxon record stores the hierarchical classification of a taxon, its scientific names and synonyms, and other relevant data retrieved 
from the respective source system. All components and data types in the taxon model, as well as a comprehensive list of all 
taxon-related endpoints are documented in the {{swagger-ui-link text="API endpoint reference"}}. A list of available fields is also available at

{{%nba-link%}}taxon/metadata/getFieldInfo{{%/nba-link%}}

## Base URL
The base URL for taxon-specific services is {{%nba-link%}}taxon{{%/nba-link%}}

## Data source systems
Currently, Naturalis provides data from (i) the [Catalogue of Life](http://www.catalogueoflife.org/) and (ii) 
the [Dutch Species Registry](http://www.nederlandsesoorten.nl/). The field `sourceSystem.code` stores the source system 
of a taxon (COL and NSR, respectively).

## Identifiers
The field `sourceSystemId` of a taxon is the identifier as it is in the source database. A unique identifier consisting of `{sourceSystem.code}@{sourceSystemId}` 
is stored in the field id. The `recordURI` is a direct link to the database entry in the source system.

## Classification
The classification of the taxon is according to the source system. In taxon records, there are two different types of classification: 
`systemClassification` and `defaultClassification`. The systemClassification is the verbatim classification as found in the taxonomic source system. 
During the import process, this classification is converted to satisfy the Biodiversity Information standards of 
the Taxonomic Database Working group (TDWG, see [here](http://rs.tdwg.org/dwc/terms/#taxonindex)). The TDWG-conform classification 
is termed `defaultClassification` here.

## Names, descriptions and synonyms
Each taxon has an `acceptedName` that represents this taxon in the source system. The `acceptedName` block stores additional 
taxonomic information, such as species and genus names and the authors that termed the taxon name. For example, we 
can retrieve all taxa that have been described by Linnaeus:

{{%nba-link%}}taxon/query/?acceptedName.author=Linnaeus{{%/nba-link%}}

Furthermore, taxon records can have a list of synonyms, descriptions, references and vernacular names (common names). 
Suppose we would like to search for passion flowers, without having any prior knowledge (e.g. without knowing that their genus is *Passiflora*):

```JSON
{
  "conditions": [
    {
      "field": "vernacularNames.name",
      "operator": "MATCHES",
      "value": "passion flower"
    }
  ],
  "size": 100
}
```

And there at least three species of genus *Passiflora* in the result set. Note that our datasets also include vernacular names in different 
languages; searching for the term “passiebloem” also yields a Passiflora taxon.
