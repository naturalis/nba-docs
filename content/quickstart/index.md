---
title: Quick Start
weight: 10
---

A collection of all services for all data types is available in the {{swagger-ui-link text="API endpoint reference"}}. 
A JSON representation of available REST endpoints can also be retreived at 

http://145.136.242.167:8080/v2/metadata/getRestServices

To get an idea of the NBA services’ possibilities and the available data, you can also have a look at the 
[Bioportal](http://bioportal.naturalis.nl/). 

## Basic (human readable) queries {#human-readable}
The base URL for querying the current version (v2) of the NBA is 

http://145.136.240.125:30076/v2

This 'home' screen lists some information including the build date and version. The data types in the NBA are: 
**specimen**, **taxon**, **multimedia**, **geo**, and **metadata**. They are accessed as path variables and queried via the query 
endpoint, for example:

http://145.136.240.125:30076/v2/specimen/query

## Query parameters
Simple queries for specific fields can be queried using standard URL query parameters, 
for example the parameter `collectionType` can be queried to get all specimens from the *Mammalia* collection:

http://145.136.240.125:30076/v2/specimen/query/?collectionType=Mammalia

An overview of all fields in a data type and whether you can query them, can be found at 

http://145.136.240.125:30076/v2/{doctype}/metadata/getFieldInfo

For example: 

http://145.136.240.125:30076/v2/taxon/metadata/getFieldInfo

Query parameters can be combined with an `&` to match multiple terms. Suppose we want to match the specimens from 
`collectionType` Mammalia that are female:

http://145.136.240.125:30076/v2/specimen/query/?sex=female&collectionType=Mammalia

## Result counts
When using the query endpoint, the first field in the JSON response is the amount of results found. It is also 
possible to retrieve the counts directly. The `count` endpoint can take exactly the same query 
parameters as `query` and, instead of a JSON string, returns an integer number. Example:

http://145.136.240.125:30076/v2/specimen/count/?sex=female&collectionType=Mammalia

## Objects and Paths
The fields available in a query directly map to the object structure used to model the four available data types. 
The objects are nested, so fields can contain subfields. For example, a specimen has (among others) the field 
`gatheringEvent` with multiple subfields. Below, for example, we see an excerpt of the JSON representation 
of a specimen:

```json
    "id": "ZMA.INS.800488@CRS",
    "gatheringEvent": {
        "country": "Cabo Verde",
        "provinceState": "Santiago",
        "locality": "São Jorge dos Órgãos",
        "localityText": "CABO VERDE, Santiago, S. Jorge dos Orgaos",
        "dateTimeBegin": "1990-05-01T00:00:00.000+0000",
        "gatheringPersons": [
            {
		    "fullName": "A. van Harten"
            }
        ]
    }
```

Here, `id` can be queried directly (`id=ZMA.INS.800488@CRS`). Subfields, e.g. the country of gathering or the person who 
collected the specimen can then be queried with `gatheringEvent.country` and `gatheringEvent.gatheringPersons.fullName`. 
Thus, fields and subfields are separated by a '.'. Note that `gatheringEvent` itself cannot be queried directly, since it 
is an object with subfields and not a simple data type. 

