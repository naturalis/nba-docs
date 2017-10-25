---
title: Geographical data services
weight: 60
---

Geographical mapping of species occurrences is essential in biogeographical analyses. More than 1.2 Million of our specimen records are 
geo-referenced, i.e. they have latitude and longitude coordinates reported for the sita at which they were collected. The data type 
geo stores geographical areas to which the geo-referenced species can be mapped. This enables querying for specimens found in a specific 
region, to e.g. retrieve all the primate species collected on Madagascar. The areas are represented as polygons of longitude/latitude pairs. 
All polygons are coded in the GeoJSON format (see below).

## Base URL
The base URL for geo-area specific services is {{%nba-link%}}geo{{%/nba-link%}}

## Data Source Systems {#geo-sources}
The data is comprised of 

* a list of countries, source: http://gadm.org/
* detailed geographical data of the Netherlands, including provinces and municipalities, source: http://www.cbs.nl/
* a comprehensive list of nature reserves, sources: http://www.natura2000.nl/, http://www.staatsbosbeheer.nl/, https://www.natuurmonumenten.nl/, http://www.pwn.nl/,  http://www.landschapnoordholland.nl/.

## Available services

### Query

### Data access

### Metadata

## Identifiers


## GeoJSON
Polygons of geographic regions as well as point occurrences of specimen are represented in the GeoJSON format 
(https://en.wikipedia.org/wiki/GeoJSON), a geospatial data-exchange standard. GeoJSON allows for encoding various types of shapes. 
Regions and point occurrences are represented by the GeoJSON types MultiPolygon and Point, respectively. In geo areas, the information is stored in the field `shape`, for instance:

{{%nba-link%}}geo/query/?\_size=1&\_fields=shape{{%/nba-link%}}

If a specimen is geo-referenced, the GeoJSON can be found in the field `gatheringEvent.siteCoordinates.geoShape`, for example 

{{%nba-link%}}specimen/query/?unitID=L.1213823&_fields=gatheringEvent.siteCoordinates{{%/nba-link%}}

Note that GeoJSON encodes a coordinate as a `[longitude, latitude]` array and that all GeoJSON coordinates in the NBA represent decimal degrees. 

### Query for area type and Locality
The NBA offers polygon data for the following areas (field areaType). Countries (world), and Nature, Municipality and Province (NL). Entries with 
the `areaType` Nature are nature reserves in the Netherlands, such as the Veluwe, a push moraine in Gelderland. The field locality gives the name of 
the locality. For example. To retrieve the polygon outlining the country Bermuda, we query for locality: 

{{%nba-link%}}geo/query/?locality=Bermuda{{%/nba-link%}}

### Searching in geo shapes
Shape fields in geo areas can be compared using the operators `IN` and `NOT_IN`, telling us if one point or polygon is fully contained in another, 
or not. For this, it is not necessary to use a GEOJson representation in the query; this can be done with either the id of a geo area record or 
its locality field.

Example: Retrieve all Nature reserves located in the Dutch province “Noord-Holland”. 

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
