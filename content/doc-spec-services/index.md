---
title: Type specific services
weight: 40
---

## Specimen occurrence services
Specimen records constitute the core of data served by the NBA. Museum specimens can represent a whole variety of 
different objects such as plants, animals or single parts thereof, DNA samples, fossils, rocks or meteorites. 
The specimens in our collection are therefore described using an extensive data model. All components and data 
types in the Specimen model, as well as a comprehensive list of all specimen-related endpoints are documented in 
the {{<swagger-ui-link text="API endpoint reference">}}. Below, the major components of specimen records are introduced 
and examples are given on how to query them. A list of available fields is also available at

http://145.136.240.125:30076/v2/specimen/metadata/getFieldInfo

### Base URL
The base URL for specimen-specific services is http://145.136.240.125:31932/v2/specimen/

### Data source systems
Specimen occurrence data are harvested from two main data sources, (i) the CRS (Collection Registration System for zoological and 
geological specimens) and (ii) BRAHMS (http://herbaria.plants.ox.ac.uk/bol/) for botanical specimen including fungi. This 
information is stored in the path sourceSystem.code. The query

http://145.136.240.125:31932/v2/specimen/query/?sourceSystem.code=BRAHMS

Will return all plant and fungi specimens. In the future, Naturalis plans to also include specimen occurrence data from 
third-party data providers.

### Identifiers
Specimen records  have several identifiers. The field  `untitID` is the identifier from the specific source system. 
Since uniqueness across source systems is not ensured, the field id, consisting of `{unitID}@{sourceSystem.code}`. Further, the 
field `unitGUID` represents the a permanent uniform web location (PURL, see also PURL services [LINK]).

### Collection types
All of our more than 8 million specimens are categorised into different subcollections (e.g. mammals, aves, 
petrology or paleobotany, …). The following query retrieves the names of all available collections and their specimen counts.

http://145.136.240.125:31932/v2/specimen/getDistinctValues/collectionType

### Gathering events
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

### Identifications
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

### Multimedia
A specimen record can link to one or more multimedia items. Multimedia information is stored in the multimedia data type. 
Additionally, links to the associated multimedia records are also stored within specimens, 
in the fields `associatedMultiMediaUris.accessUri` and `associatedMultiMediaUris.format`.


## Taxonomic data services
A taxon record stores the hierarchical classification of a taxon, its scientific names and synonyms, and other relevant data retrieved 
from the respective source system. All components and data types in the taxon model, as well as a comprehensive list of all 
taxon-related endpoints are documented in the {{<swagger-ui-link text="API endpoint reference">}}. A list of available fields is also available at

http://145.136.240.125:30076/v2/taxon/metadata/getFieldInfo

### Base URL
The base URL for taxon-specific services is http://145.136.240.125:31932/v2/taxon

### Data source systems
Currently, Naturalis provides data from (i) the [Catalogue of Life](http://www.catalogueoflife.org/) and (ii) 
the [Dutch Species Registry](http://www.nederlandsesoorten.nl/). The field `sourceSystem.code` stores the source system 
of a taxon (COL and NSR, respectively).

### Identifiers
The field `sourceSystemId` of a taxon is the identifier as it is in the source database. A unique identifier consisting of `{sourceSystem.code}@{sourceSystemId}` 
is stored in the field id. The `recordURI` is a direct link to the database entry in the source system.

### Classification
The classification of the taxon is according to the source system. In taxon records, there are two different types of classification: 
`systemClassification` and `defaultClassification`. The systemClassification is the verbatim classification as found in the taxonomic source system. 
During the import process, this classification is converted to satisfy the Biodiversity Information standards of 
the Taxonomic Database Working group (TDWG, see [here](http://rs.tdwg.org/dwc/terms/#taxonindex)). The TDWG-conform classification 
is termed `defaultClassification` here.

### Names, descriptions and synonyms
Each taxon has an `acceptedName` that represents this taxon in the source system. The `acceptedName` block stores additional 
taxonomic information, such as species and genus names and the authors that termed the taxon name. For example, we 
can retrieve all taxa that have been described by Linnaeus:

http://145.136.240.125:31932/v2/taxon/query/?acceptedName.author=Linnaeus

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


## Multimedia data services
Digitisation of the specimens in our collection includes a detailed photographic documentation. So far, there are more than 
5 million photos stored in the Naturalis MediaLib. NBA’s multimedia data services provide an interface to the *MediaLib* for 
the public. Since each multimedia record has to be associated with a specimen or taxon which in turn has to have an identification, 
this dataset has great potential to be used in automatic image recognition applications. Furthermore, the MediaLib features 
videos and also artistic drawings of animals and plants. 

### Base URL
The base URL for multimedia-specific services is http://145.136.240.125:31932/v2/multimedia

### Data Source Systems
Most multimedia data are retrieved from our in-house registration systems for botanical (BRAHMS) or zoological/geological (CRS) specimens, 
and most are plant photos. A small fraction items is retrieved from the [Dutch Species Registry](http://www.nederlandsesoorten.nl/). As for 
the other data types, the source system can be retrieved by querying the fields `sourceSystem.code` and `sourceSystem.name`. 

### Link to specimen and taxa
Each multimedia record is linked either to the id of a specimen or a taxon via the fields `associatedSpecimenReference` 
and `associatedTaxonReference`, respectively. In order to provide a faster search for specific specimen/taxon attributes within multimedia 
content, their identifications block is included in a multimedia record. For example, one can search for 
the pygmy cormorant, given its species name *Phalacrocorax pygmeus*:

http://145.136.240.125:30076/v2/multimedia/query/?identifications.defaultClassification.genus=Phalacrocorax&identifications.defaultClassification.specificEpithet=pygmeus

### Downloading multimedia content
Each multimedia record has one or more download URLs retrievable via the field(s) `serviceAccessPoints.accessURI`. Below we query for 
the image location of the pygmy cormorant: 

[http://145.136.240.125:30076/v2/multimedia/query/?identifications.defaultClassification.genus=Phalacrocorax&identifications.defaultClassification.specificEpithet=pygmeus
&_fields=serviceAccessPoints.accessUri](http://145.136.240.125:30076/v2/multimedia/query/?identifications.defaultClassification.genus=Phalacrocorax&identifications.defaultClassification.specificEpithet=pygmeus&_fields=serviceAccessPoints.accessUri)

<figure>
<div style="text-align: center;">
	<p><img src="http://medialib.naturalis.nl/file/id/ZMA.AVES.38187/format/large" align="center"
		alt="pigmy-cormorant" width=300>
		<figcaption>Museum specimen of the Pygmy cormorant (Phalacrocorax pygmeus)</figcaption>
	</div>
</figure>


### Artistic images
Next to photos and videos of specimens, the NBA also gives access to about 2500 artistic scientific drawings and lithographs. 
These documents are categorised in the collection Arts and can be retrieved via the field collectionType. To obtain all drawings 
picturing species of genus Phalacrocorax, one can query within the Arts collection:

http://145.136.240.125:30076/v2/multimedia/query/?identifications.defaultClassification.genus=Phalacrocorax&collectionType=Arts

Among the results we find for instance this nice drawing of *Phalacrocorax aristotoles*:
 
<figure>
<div style="text-align: center;">
	<p><img src="http://medialib.naturalis.nl/file/id/image-134788/format/large" align="center" width=500
    alt="shag-drawing">
  <figcaption>Drawing of the European shag (Phalacrocorax aristotoles)</figcaption>
</div>
</figure>

### Licensing
Each multimedia item is published under a copyright license. Licenses can be accessed by the fields licenseType 
and license. Most of them are published under one of the [Creative Commons licenses](https://creativecommons.org/).


## Geographical data services

Geographical mapping of species occurrences is essential in biogeographical analyses. More than 1.2 Million of our specimen records are 
geo-referenced, i.e. they have latitude and longitude coordinates reported for the sita at which they were collected. The data type 
geo stores geographical areas to which the geo-referenced species can be mapped. This enables querying for specimens found in a specific 
region, to e.g. retrieve all the primate species collected on Madagascar. The areas are represented as polygons of longitude/latitude pairs. 
All polygons are coded in the GeoJSON format (see below).

### Base URL
The base URL for geo-area specific services is http://145.136.240.125:31932/v2/geo

### Data Source Systems {#geo-sources}
The data is comprised of 

* a list of countries, source: http://gadm.org/
* detailed geographical data of the Netherlands, including provinces and municipalities, source: http://www.cbs.nl/
* a comprehensive list of nature reserves, sources: http://www.natura2000.nl/, http://www.staatsbosbeheer.nl/, https://www.natuurmonumenten.nl/, http://www.pwn.nl/,  http://www.landschapnoordholland.nl/.

### GeoJSON
Polygons of geographic regions as well as point occurrences of specimen are represented in the GeoJSON format 
(https://en.wikipedia.org/wiki/GeoJSON), a geospatial data-exchange standard. GeoJSON allows for encoding various types of shapes. 
Regions and point occurrences are represented by the GeoJSON types MultiPolygon and Point, respectively. In geo areas, the information is stored in the field `shape`, for instance:

http://145.136.240.125:31932/v2/geo/query/?\_size=1&\_fields=shape

If a specimen is geo-referenced, the GeoJSON can be found in the field `gatheringEvent.siteCoordinates.geoShape`, for example 

http://145.136.240.125:31932/v2/specimen/query/?unitID=L.1213823&_fields=gatheringEvent.siteCoordinates

Note that GeoJSON encodes a coordinate as a `[longitude, latitude]` array and that all GeoJSON coordinates in the NBA represent decimal degrees. 

### Area type and Locality
The NBA offers polygon data for the following areas (field areaType). Countries (world), and Nature, Municipality and Province (NL). Entries with 
the `areaType` Nature are nature reservations in the Netherlands, such as the Veluwe, a push moraine in Gelderland. The field locality gives the name of 
the locality. For example. To retrieve the polygon outlining the country Bermuda, we query for locality: 

### Searching in geo shapes
shape fields in geo areas can be compared using the operators `IN` and `NOT_IN`, telling us if one point or polygon is fully contained in another, 
or not. For this, it is not necessary to use a GEOJson representation in the query; this can be done with either the id of a geo area record or 
its locality field.

Example: Retrieve all Nature reservation located in the Dutch province “Noord-Holland”. 

```JSON
{
  "conditions": [
    {
      "field": "areaType",
      "operator": "EQUALS",
      "value": "Nature"
    },
    {
      "field": "shape",
      "operator": "IN",
      "value": "Noord-Holland"
    }
  ]
}
```

We would get the same results when querying with the id of the area Noord-Holland (`"value": "1003483@GEO"`). 

Likewise, we can look for specimens that have coordinates in a certain area. Suppose that we want to get all species 
collected in the country Bermuda. 
This time, we search for specimens, using either the search term “Bermuda” or the id for Bermuda (`1003922@GEO`):

```JSON
{
  "conditions": [
    {
      "field": "gatheringEvent.siteCoordinates.geoShape",
      "operator": "IN",
      "value": "Bermuda"
    }
  ]
}
```

This query yields 14 specimen occurrences.

### Searching in custom GeoJSON Areas
It is also possible to enter a GeoJSON directly into a query term. Suppose that we want to query for all specimens that were 
collected in the *Bermuda Triangle*. However, the Bermuda Triangle is not available as a geo shape in the NBA, so we cannot search 
using locality or id but must specify a custom location. The GeoJSON describing the Bermuda triangle is as follows:

```JSON
{
  "type": "MultiPolygon",
  "coordinates": [
    [
      [
        [
          -64.73,
          32.31
        ],
        [
          -80.19,
          25.76
        ],
        [
          -66.09,
          18.43
        ],
        [
          -64.73,
          32.31
        ]
      ]
    ]
  ]
}
```

We can then query for specimens using the JSON string:


```JSON
{
  "conditions": [
    {
      "field": "gatheringEvent.siteCoordinates.geoShape",
      "operator": "IN",
      "value": "{\"type\":\"MultiPolygon\",\"coordinates\":[[[[-64.73, 32.31],[-80.19, 25.76],[-66.09, 18.43],[-64.73, 32.31]]]]}"
    }
  ]
}
```

Note that the quotes in the GeoJSON string have to be escaped and that linebreaks are removed. 
This query will yield 158 specimens that have been collected within the boundaries of the Bermuda Triangle. 


## Metadata services

Metadata services provide miscellaneous information about the data available via the NBA. For a full list of services, please refer ti the
{{<swagger-ui-link text="API endpoint reference">}}. Metadata services can be categorised into two classes:

### Controlled vocabularies
To maintain data integrity, some fields in our source systems are constrained by controlled vocabularies. These exist for 
the fields `PhaseOrStage`, `Sex`, `SpecimenTypeStatus` (Specimens), `TaxonomicStatus` (Taxa). The 
endpoint `/medata/getControlledList/{field}` returns the allowed values for this field, e.g. for the type status:

http://145.136.240.125:31932/v2/metadata/getControlledList/SpecimenTypeStatus

Allowed formats for date fields can be retrieved with `/metadata/getAllowedDateFormats`. The service `/metadata/getRestServices` gives a list of all available NBA endpoints.

### Type-specific metadata
These services reside under `/{dataType}/metadata` and give information about the field structure of the data type, such as all available 
paths (`getPaths`) or detailed information about data types, allowed operators and whether a field is indexed or not (`getFieldInfo`), for example:

http://145.136.240.125:31932/v2/multimedia/metadata/getPaths

http://145.136.240.125:31932/v2/multimedia/metadata/getFieldInfo

