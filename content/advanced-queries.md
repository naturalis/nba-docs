---
weight: 30
title: Advanced queries
---

# Advanced queries

## Special query qarameters
For extended query functionality, the NBA offers a set of extended query parameters:

### Filter in results: `_fields`
The _fields parameter allows for filtering certain fields of interest in result documents. 
Suppose one would like to query all taxa in the genus Hydrochoerus but is only interested in the title of the 
scientific publication associated with that taxon,

<code>http://145.136.240.125:30076/v2/taxon/query/?defaultClassification.genus=Hydrochoerus&_fields=references.titleCitation</code>

This query will yield a minimal JSON document containing the desired data. Note that multiple fields can be chosen if separated by commata, e.g. 

<code>http://145.136.240.125:30076/v2/taxon/query/?defaultClassification.genus=Hydrochoerus&_fields=recordURI,references.titleCitation</code>
 
### Basic sorting: `_sortFields`
To structure the documents in a query result, it is possible to sort the result by the values of user-defined fields. This example 
extracts all GEO objects with `areaType` *Country* and sorts the results by the name of the locality (country):

http://145.136.240.125:30076/v2/geo/query/?areaType=Country&_fields=locality&_sortFields=locality

Note that more than one _sortField can be provided, separated by commata. The results will then be first sorted on the first field, 
and if multiple documents match the first field, the latter fields will be considered in sorting the results.

It is also possible to specify a sort direction. To sort in ascending order:

http://145.136.240.125:30076/v2/geo/query/?areaType=Country&_fields=locality&_sortFields=locality:ASC

To sort in descending order:

http://145.136.240.125:30076/v2/geo/query/?areaType=Country&_fields=locality&_sortFields=locality:DESC


### Controlling result size: `_size` and `_from` 
By default, the NBA returns the first 10 best-scoring matches. The *total size* is always the first number in the result set when 
using the `query` endpoint. It is important to note that by default, the documents returned from a query are not sorted on any 
field. Controlling the size of the result therefore makes most sense on sorted data. The below example uses the `_size` parameter

http://145.136.240.125:30076/v2/geo/query/?areaType=Country&_fields=locality&_sortFields=locality&_size=100

to return the first 100 GEO document that are countries. The scrolling parameter `_from` controls the offset from 
which documents are retrieved. The query 

http://145.136.240.125:30076/v2/geo/query/?areaType=Country&_fields=locality&_sortFields=locality&_size=100&_from=100

thus returns 100 documents starting from the 100th result. The first item in this set is therefore *Hungary* and not *Afghanistan*, 
which would be the first hit of the query without `_from`.

### Capitalisation: `_ignoreCase`
By default, search fields are case-sensitive in the NBA. As the name indicates, this parameter makes a query term case insensitive.

### Combined search on multiple fields: `_logicalOperator`
By default, when querying multiple fields, the query terms are conjoined by the operator AND meaning that each condition has to be met. 
To use an OR conjunction, the query parameter `_logicalOperator` can be used, e.g. 

http://145.136.240.125:30076/v2/specimen/query/?gatheringEvent.worldRegion=Neotropical&gatheringEvent.continent=Southern%20America&_logicalOperator=OR

## Complex queries: `_querySpec`

Human readable queries, as outlined above, provide an intuitive way to search for one or multiple fields in the data. However, 
these queries have limited power and therefore the NBA allows for a detailed query specification in 
JSON format, a so-called `QuerySpec` object. 
A QuerySpec generally consists of an array of QueryCondition objects 
(please refer to the NBA reference documentation for detailed documentation of these object types) that, in turn, have the fields field, 
operator and value. A simple QuerySpec for specimens of the genus Hydrochoerus looks as follows

```json
{
  "conditions" : 
      [
          { "field" : "identifications.defaultClassification.genus", 
      "operator" : "EQUALS", 
      "value" : "Hydrochoerus" }
      ]
}
```

and the entire query (with the URL encoded QuerySpec json):

<code>http://145.136.240.125:30076/v2/specimen/query/?_querySpec=%7B%0A%20%20%22conditions%22%20%3A%20%0A%20%20%20%20%20%20%5B%0A%20%20%20%20%20%20%20%20%20%20%7B%20%22field%22%20%3A%20%22identifications.defaultClassification.genus%22%2C%20%0A%20%20%20%20%20%20%22operator%22%20%3A%20%22EQUALS%22%2C%20%0A%20%20%20%20%20%20%22value%22%20%3A%20%22Hydrochoerus%22%20%7D%0A%20%20%20%20%20%20%5D%0A%7D%0A</code>

The QuerySpec object allows for partial matching of a query term. To find, for instance, all specimen of mammal genera that start 
with Hydro, we could query with two conditions:

```json
{
  "conditions" : 
      [
        { "field" : "identifications.defaultClassification.genus",
          "operator" : "STARTS_WITH", 
           "value" : "Hydro" },
        { "field" : "collectionType", 
          "operator" : "EQUALS", 
          "value" : "Mammalia" }
    ]
}
```

### Further QuerySpec options
Next to the QueryCondition(s), the parameters fields, size, from, logicalOperator, sortFields can be set. Note that these parameters 
are identical to the parameters `_fields`, `_size`, etc. introduced above for human-readable queries. Suppose, we want to query with 
the above conditions with maximal 100 results, sorted by the country where the specimen was found and only retrieve a 
subset of the specimen properties:

```json
{
	"conditions" : 
    [
	{ "field" : "identifications.defaultClassification.genus",
          "operator" : "STARTS_WITH", 
          "value" : "Hydro" },
      { "field" : "collectionType", 
          "operator" : "EQUALS", 
          "value" : "Mammalia" }
    ],
    "logicalOperator" : "AND",
    "size" : 100,
    "from" : 0,
    "sortFields" : [{"path" : "gatheringEvent.country", "sortOrder" : "ASC"}],
 "fields" : [ "identifications.defaultClassification.genus",  "identifications.scientificName.fullScientificName", "gatheringEvent.country"]
}
```

## Query Operators

The available operators differ between search fields, depending if they are words, numbers, or dates. Most fields (except geo shapes) 
have the matching operators `EQUALS` and `NOT_EQUALS`. For numbers and dates, comparison operators such as `LT`, `GT` 
(less than and greater than, respectively) are usually important, as well as querying numbers within or outside a 
certain range (`BETWEEN`, `NOT_BETWEEN`). Partial matching operators for text fields are very powerful. 
With the operator `CONTAINS`, a search term must be an exact substring (upper/lower cases are ignored) in a document. 
The operator `MATCHES` breaks up the query string into single terms which then are matched in the documents 
(using an OR conjunction). The metadata service `{doctype}/metadata/getFieldInfo` lists all operators for every field in a document:

http://145.136.240.125:30076/v2/specimen/metadata/getFieldInfo 

Alternatively, it is possible to ask the API whether an operator is valid for a specific field, e.g.

http://145.136.240.125:30076/v2/specimen/metadata/isOperatorAllowed/collectionType/EQUALS


### Logical conjunctions between QueryCondition objects
While the parameter logicalOperator can logically combine multiple **QueryConditions**, 
this can also be accomplished in a nested manner, using the parameters and and or to add one or more 
conditions within a **QueryCondition**. The below example will return specimens from both, genus Saguinus and Cebus:

{
  "conditions" :
      [
        { "field" : "identifications.defaultClassification.genus",
          "operator" : "EQUALS", 
           "value" : "Saguinus", 
        "or" : [
 	   { "field" : "identifications.defaultClassification.genus", 
          	    "operator" : "EQUALS", 
                "value" : "Cebus" }
                 ] 
         }
    ]
}

Note that the above query can also be implemented with two non-nested QueryConditions. 
Please refer to the 
[java client documentation](http://naturalis.github.io/naturalis_data_api/javadoc/v2/client/nl/naturalis/nba/api/QueryCondition.html)
about details on nesting. 

### Query for empty/nonempty fields
The pre-defined parameter value `@NULL@` matches a non-existent value. Suppose we want to know which specimens are of rank species, 
but do not have a default classification on the genus-level:

<code>http://145.136.240.125:30076/v2/specimen/query/?identifications.taxonRank=species&identifications.defaultClassification.genus=@NULL@</code>

Conversely, it is possible to query for non-empty fields with the query parameter `@NOT_NULL@`. Example: get all specimens that 
have lat-long coordinates:

<code>http://145.136.240.125:30076/v2/specimen/query/?identifications.taxonRank=species&gatheringEvent.siteCoordinates.latitudeDecimal=@NOT_NULL@&gatheringEvent.siteCoordinates.longitudeDecimal=@NOT_NULL@</code>

The parameters `@NULL@` and `@NOT_NULL@` can only be used for human-readable queries. In QuerySpec JSON notation, we can use `“value” : null` in combination with `“operator” : “EQUALS”` or `“operator” : “NOT_EQUALS”`.
Example: Search for all taxa that have no full scientific name in their synonyms:

```json
{
  "conditions" : 
      [
        { "field" : "synonyms.fullScientificName",
          "operator" : "EQUALS",
         “value” : null}
    ]
}
```

Please note that if `“value” : null` is omitted in the above example, the result will be the same. However, we find it more intuitive to explicitly 
specify the **null** value in such queries.

## Scoring and Boosting

By default, documents from a query are sorted by relevance, so the documents that match the query conditions best will appear 
first in the results. The relevance is reflected in the score which is returned in any NBA search result. The higher the score, the 
more relevant the search result. Please refer to the [ElasticSearch documentation]( https://www.elastic.co/guide/en/elasticsearch/guide/current/practical-scoring-function.html) on how the score is calculated. Suppose we look for taxa with genus name matching “uinus” or family names matching “alsa”, using the operator CONTAINS. 

```json
{
  "conditions" : 
      [
        { "field" : "defaultClassification.genus",
          "operator" : "CONTAINS", 
           "value" : "uinus",
        }, 
        { "field" : "defaultClassification.family", 
          "operator" : "CONTAINS", 
          "value" : "alsa" 
        }
    ], 
    "logicalOperator" : "OR",
    "fields" : ["defaultClassification.genus", "defaultClassification.family"],
    "size" : 100
}
```

The best-scoring hits are taxa of genus Saguinus, Guinusia and Pinguinus while taxa with matching family names 
(e.g. Valsaceae) are further behind, due to a larger edit distance. To lever the importance of a match in family- rather 
than in genus name, the boost parameter can be added to a QueryCondition:


```json
{
  "conditions" : 
      [
        { "field" : "defaultClassification.genus",
          "operator" : "CONTAINS", 
           "value" : "uinus"
        }, 
        { "field" : "defaultClassification.family", 
          "operator" : "CONTAINS", 
          "value" : "alsa",
          "boost" : 2 }
    ], 
    "logicalOperator" : "OR",
    "fields" : ["defaultClassification.genus", "defaultClassification.family"],
    "size" : 100
}
```

A boost parameter higher than 1 increases the relative weight of a QueryCondition while a value between 0 and 1 decreases it. 
The default boost of a QueryCondition is 1. More about boosting in ElasticSearch can be found 
[here](https://www.elastic.co/guide/en/elasticsearch/guide/current/_boosting_query_clauses.html)

In many applications, scoring might not be relevant at all. To turn off scoring and sorting query results by score, the parameter 
`"contantScore" : "true"` can be set in a QuerySpec. Disabling the calculation of a relevance 
score generally results in faster queries.
