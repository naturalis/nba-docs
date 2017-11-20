---
title: Advanced queries
weight: 80
---

## Special query parameters 
For extended query functionality, the NBA
offers a set of extended query parameters:

### Filter in results: _fields 
The `_fields` parameter allows for
filtering certain fields of interest in query results.  Suppose one
would like to query all taxa in the genus *Hydrochoerus* but is only
interested in the title of the scientific publication associated with
that taxon,

{{%nba-link%}}taxon/query/?defaultClassification.genus=Hydrochoerus&_fields=references.titleCitation{{%/nba-link%}}

This query will yield a minimal JSON document containing the desired
data. Note that multiple fields can be chosen if separated by commata,
e.g.

{{%nba-link%}}taxon/query/?defaultClassification.genus=Hydrochoerus&_fields=recordURI,references.titleCitation{{%/nba-link%}}
 
### Basic sorting: _sortFields 
To structure a query result, it is
possible to sort the result by the values of user-defined fields.
This example extracts all geo area records with `areaType` ‘Country’
and sorts the results by the name of the locality (country):

{{%nba-link%}}geo/query/?areaType=Country&_fields=locality&_sortFields=locality{{%/nba-link%}}

Note that more than one `_sortField` can be provided, separated by
commata. The results will then be first sorted on the first field, and
if there are multiple results matching the first field, the latter
fields will be considered in sorting the results.

It is also possible to specify a sort direction. To sort in ascending
order:

{{%nba-link%}}geo/query/?areaType=Country&_fields=locality&_sortFields=locality:ASC{{%/nba-link%}}

To sort in descending order:

{{%nba-link%}}geo/query/?areaType=Country&_fields=locality&_sortFields=locality:DESC{{%/nba-link%}}

### Controlling result size: _size and _from 
By default, the NBA
returns the first 10 best-scoring matches. The total size is always
the first number in the result set when using the query endpoint. It
is important to note that by default, the results returned from a
query are not sorted on any field. Controlling the size of the result
therefore makes most sense on sorted data. The below example uses the
`_size` parameter

{{%nba-link%}}geo/query/?areaType=Country&_fields=locality&_sortFields=locality&_size=100{{%/nba-link%}}

to return the first 100 geo areas that are countries. The scrolling
parameter `_from` controls the offset from which results are
retrieved. The query

{{%nba-link%}}geo/query/?areaType=Country&_fields=locality&_sortFields=locality&_size=100&_from=100{{%/nba-link%}}

thus returns 100 results starting from the 100th result. The first
item in this set is therefore ‘Hungary’ and not ‘Afghanistan’, which
would be the first hit of the query without `_from`.

### _ignoreCase 
By default, search fields are case-sensitive in the
NBA. As the name indicates, this parameter makes a query term case
insensitive.

### Combined search on multiple fields: _logicalOperator 
By default,
when querying multiple fields, the query terms are conjoined by the
operator `AND` meaning that each condition has to be met. To use an
`OR` conjunction, the query parameter `_logicalOperator` can be used,
e.g.

{{%nba-link%}}specimen/query/?gatheringEvent.worldRegion=Neotropical&gatheringEvent.continent=Southern%20America&_logicalOperator=OR{{%/nba-link%}}

## Complex queries: The _querySpec parameter {#queryspec} 
Human readable queries, as outlined above, provide an intuitive way to
search for one or multiple fields in the data. However, these queries
have limited power and therefore the NBA allows for a detailed query
specification in JSON format, a so-called `QuerySpec` object.  A
`QuerySpec` generally consists of an array of `QueryCondition` objects
(please refer to the NBA reference documentation for detailed
documentation of these object types) that, in turn, have the fields
field, operator and value. A simple QuerySpec for specimens of the
genus *Hydrochoerus* looks as follows

```JSON
{
  "conditions": [
    {
      "field": "identifications.defaultClassification.genus",
      "operator": "EQUALS",
      "value": "Hydrochoerus"
    }
  ]
}
```

Here is the
[entire query (URL encoded)]({{%nba-link-text%}}specimen/query/?_querySpec={{%/nba-link-text%}}%7B%0A%20%20%22conditions%22%3A%20%5B%0A%20%20%20%20%7B%0A%20%20%20%20%20%20%22field%22%3A%20%22identifications.defaultClassification.genus%22%2C%0A%20%20%20%20%20%20%22operator%22%3A%20%22EQUALS%22%2C%0A%20%20%20%20%20%20%22value%22%3A%20%22Hydrochoerus%22%0A%20%20%20%20%7D%0A%20%20%5D%0A%7D).

The QuerySpec object allows for partial matching of a query term. To
find, for instance, all specimen of mammal genera that start with
*Hydro*, we could query with two conditions:

```JSON
{
  "conditions": [
    {
      "field": "identifications.defaultClassification.genus",
      "operator": "STARTS_WITH",
      "value": "Hydro"
    },
    {
      "field": "collectionType",
      "operator": "EQUALS",
      "value": "Mammalia"
    }
  ]
}
```

### QuerySpec in the NBA scratchpad 
The {{%scratchpad-link text="NBAquery scratchpad"%}} 
is a convenient tool to design, optimise and debug QuerySpec JSON
strings. Its URL can even take a QuerySpec as parameter, and the query
will be automatically visible in the scratchpad:

[{{%scratchpad-link-text%}}/?_querySpec={my_queryspec_here}]({{%scratchpad-link-text%}}/?_querySpec={my_queryspec_here})


### Further QuerySpec options 
Next to the QueryCondition(s), the
parameters `fields, size, from, logicalOperator, sortFields` can be
set.  Note that these parameters are identical to the parameters
`_fields, _size`, etc. introduced above for human-readable
queries. Suppose, we want to query with the above conditions with
maximal 100 results, sorted by the country where the specimen was
found and only retrieve a subset of the specimen properties:

```JSON
{
  "conditions": [
    {
      "field": "identifications.defaultClassification.genus",
      "operator": "STARTS_WITH",
      "value": "Hydro"
    },
    {
      "field": "collectionType",
      "operator": "EQUALS",
      "value": "Mammalia"
    }
  ],
  "logicalOperator": "AND",
  "size": 100,
  "from": 0,
  "sortFields": [
    {
      "path": "gatheringEvent.country",
      "sortOrder": "ASC"
    }
  ],
  "fields": [
    "identifications.defaultClassification.genus",
    "identifications.scientificName.fullScientificName",
    "gatheringEvent.country"
  ]
}
```

## Comparison Operators
The available operators differ between search fields, depending if
they are words, numbers, or dates.  Most fields (except geo shapes)
have the matching operators `EQUALS` and `NOT_EQUALS`. For numbers and
dates, comparison operators such as `LT`, `GT` (less than and greater
than, respectively) are usually important, as well as querying numbers
within or outside a certain range (`BETWEEN, NOT_BETWEEN`). Partial
matching operators for text fields are very powerful. With the
operator `CONTAINS`, a search term must be an exact substring
(upper/lower cases are ignored) of a data field. The operator
`MATCHES` breaks up the query string into single search terms which
are conjoined with `OR` .  The metadata service
`{doctype}/metadata/getFieldInfo` lists all operators for every field
in a data type:

{{%nba-link%}}specimen/metadata/getFieldInfo{{%/nba-link%}}

Alternatively, it is possible to ask the API whether an operator is
valid for a specific field, e.g.

{{%nba-link%}}specimen/metadata/isOperatorAllowed/collectionType/EQUALS{{%/nba-link%}}

## Logical conjunctions
While the parameter logicalOperator can logically combine multiple
QueryConditions, this can also be accomplished in a nested manner,
using the fields and and or to add one or more conditions within a
QueryCondition. The below example will return specimens from both,
genus *Saguinus* and *Cebus*:

```JSON
{
  "conditions": [
    {
      "field": "identifications.defaultClassification.genus",
      "operator": "EQUALS",
      "value": "Saguinus",
      "or": [
        {
          "field": "identifications.defaultClassification.genus",
          "operator": "EQUALS",
          "value": "Cebus"
        }
      ]
    }
  ]
}
```

Note that the above query can also be implemented with two non-nested
QueryConditions.  Please refer to the
[java client documentation](http://naturalis.github.io/naturalis_data_api/javadoc/v2/client/nl/naturalis/nba/api/QueryCondition.html)
about details on nesting.

## Query for empty/non-empty fields
The pre-defined parameter value **@NULL@** matches a non-existent
value. Suppose we want to know which specimens are of rank species,
but do not have a default classification on the genus-level:

{{%nba-link%}}specimen/query/?identifications.taxonRank=species&identifications.defaultClassification.genus=@NULL@{{%/nba-link%}}

Conversely, it is possible to query for non-empty fields with the
query parameter `@NOT_NULL@`. Example: get all specimens that have
lat-long coordinates:

{{%nba-link%}}specimen/query/?identifications.taxonRank=species&gatheringEvent.siteCoordinates.latitudeDecimal=@NOT\_NULL@&gatheringEvent.siteCoordinates.longitudeDecimal=@NOT\_NULL@{{%/nba-link%}}

The parameters `@NULL@` and `@NOT_NULL@` can only be used for
human-readable queries. In QuerySpec JSON notation, we can use
`“value” : null` in combination with `“operator” : “EQUALS”` or
`“operator” : “NOT_EQUALS”`.  Example: Search for all taxa that have
no full scientific name in their synonyms:

```JSON
{
  "conditions": [
    {
      "field": "synonyms.fullScientificName",
      "operator": "EQUALS",
      "value": null
    }
  ]
}
```

Please note that if `“value” : null` is omitted in the above example,
the result will be the same.  However, it seems more intuitive to
explicitly specify the ‘null’ value in such queries.

## Scoring and Boosting 
By default, query results are sorted by
relevance, so hits that match the query conditions best will appear
first. The relevance is reflected in the score which is returned in
any NBA search result.  The higher the score, the more relevant the
search result. Please refer to the [ElasticSearch documentation] (
https://www.elastic.co/guide/en/elasticsearch/guide/current/practical-scoring-function.html)
on how the score is calculated. Suppose we look for taxa with genus
name matching “uinus” or family names matching “alsa”, using the
operator CONTAINS.

```JSON
{
  "conditions": [
    {
      "field": "defaultClassification.genus",
      "operator": "CONTAINS",
      "value": "uinus"
    },
    {
      "field": "defaultClassification.family",
      "operator": "CONTAINS",
      "value": "alsa"
    }
  ],
  "logicalOperator": "OR",
  "fields": [
    "defaultClassification.genus",
    "defaultClassification.family"
  ],
  "size": 100
}
```

The best-scoring hits are taxa of genus Saguinus, Guinusia and
Pinguinus while taxa with matching family names (e.g. Valsaceae) are
further behind, due to a larger edit distance. To lever the importance
of a match in family- rather than in genus name, the boost parameter
can be added to a `QueryCondition`:

```JSON
{
  "conditions": [
    {
      "field": "defaultClassification.genus",
      "operator": "CONTAINS",
      "value": "uinus"
    },
    {
      "field": "defaultClassification.family",
      "operator": "CONTAINS",
      "value": "alsa",
      "boost": 2
    }
  ],
  "logicalOperator": "OR",
  "fields": [
    "defaultClassification.genus",
    "defaultClassification.family"
  ],
  "size": 100
}
```

A `boost` parameter higher than 1 increases the relative weight of a
QueryCondition while a value between 0 and 1 decreases it. The default
boost of a `QueryCondition` is 1. More about boosting in ElasticSearch
can be found
[here](https://www.elastic.co/guide/en/elasticsearch/guide/current/_boosting_query_clauses.html).

In many applications, scoring might not be relevant at all. To turn
off scoring and sorting query results by score, the parameter
`constantScore` can be set in a QuerySpec object
(i.e. `“contantScore” : “true”`). Disabling the calculation of a
relevance score generally results in faster queries.

## GET vs POST requests 
All NBA services can process GET requests with
an (URL encoded) query string. Queries with complex QuerySpec objects
can however result in long strings, which can cause size issues in
certain REST clients. The NBA therefore also accepts POST requests for
the endpoints that can take a QuerySpec object: `query` and
`count`. The query spec is then passed as the payload. Below a cURL
example to query for all taxa of genus *Sempervivum* with POST:

```JSON
curl -X POST {{%nba-link-text%}}taxon/query/{{%/nba-link-text%}} -d '_querySpec={
  "conditions": [
    {
      "field": "defaultClassification.genus",
      "operator": "EQUALS",
      "value": "Sempervivum"
    }
  ]
}'
```

## Searching with dates 
All date fields of specimen, taxon and
multimedia data types (geo areas do not have a date field) are indexed
and therefore searchable.  Dates can be entered in different levels of
precision; the supported formats can be queried as follows:

{{%nba-link%}}metadata/getAllowedDateFormats{{%/nba-link%}}

The most precise format is `yyyy-MM-dd'T'HH:mm:ss.SSSZ`, with
resolution in milliseconds (SSS) and specification of time zone (Z);
for example `1981-01-09T08:40:59.880+02:00`. The least precise format
is `yyyy`. See also
[here](http://naturalis.github.io/naturalis_data_api/javadoc/v2/client/nl/naturalis/nba/common/es/ESDateInput.html)
for information and examples on NBA date formats. Date fields support
the same operator as numeric fields (see
[here]({{%nba-link-text%}}specimen/metadata/getFieldInfo{{%/nba-link-text%}})
e.g. for specimens), e.g. `EQUALS, IN, GT, LT` and `BETWEEN`.

Example: Find all specimens that were gathered before 1800, sorted
descendingly:

```JSON
{
  "conditions": [
    {
      "field": "gatheringEvent.dateTimeBegin",
      "operator": "LT",
      "value": "1800"
    }
  ],
  "sortFields": [
    {
      "path": "gatheringEvent.dateTimeBegin",
      "sortOrder": "DESC"
    }
  ]
}

```

**Caution**: When querying with less precise date strings, such as
`yyyy` or `yyyy-MM`, the missing precision is added and set to the
beginning of the unit. When querying for 2001 with the EQUALS
operator, for instance, not all dates in the year 2001 are matched,
but all dates that match 2001-01-01. Therefore, querying for a range
of values should be done with the `BETWEEN` operator. Example:
retrieve all specimens collected in April 2001:

```JSON
{
  "conditions": [
    {
      "field": "gatheringEvent.dateTimeBegin",
      "operator": "BETWEEN",
      "value": [
        "2001-04-01",
        "2001-04-30"
      ]
    }
  ]
}
```

## Aggregation {#agg} Aggregation functions summarise data from
multiple query results based on certain conditions in order to get a
higher-level view on the whole dataset. The NBA features two different
types of aggregation: Aggregation on distinct field values and
aggregation on scientific names.

### Distinct values for fields 
For a given field in a data type,
services with path `/{documentType}/getDistinctValues/{field}` return
all distinct values of that field in the data. Additionally, the
frequency for each value for the field is given and the result is
ordered by frequency.  This functionality is thus a simple count
aggregation. Example: To identify the amounts of specimens per
collection, one has to aggregate on all distinct values for the field
collectionType:

{{%nba-link%}}specimen/getDistinctValues/collectionType{{%/nba-link%}}

### Scientific Name Groups
The identification of a museum specimen is its assignment to a certain
taxon of a certain rank (e.g. species or subspecies) and the taxon
must be defined in some taxonomic reference resource. The concept of
Scientific name groups in the NBA establishes this link between a
specimen and a taxon. This allows to query which specimens are
associated with which taxa and vice versa.  The services available in
the path `{specimen|taxon}/groupByScientificName/{query}` allow for
aggregation of search results over both, specimen and taxa at the same
time. Aggregation is carried out on the field `scientificNameGroup`
(`identifications.scientificName.scientificNameGroup` for specimen and
`acceptedName.scientificName.scientificNameGroup/synonyms.scientificName.scientificNameGroup`
for taxa). A query gives a list of objects which contain both,
specimen and taxa, that share the same value for scientificNameGroup
Example: To retrieve all specimens and their associated taxa for the
genus *Felis*:

{{%nba-link%}}specimen/groupByScientificName/?identifications.scientificName.genusOrMonomial=Felis{{%/nba-link%}}

{{%nba-link%}}taxon/groupByScientificName/?acceptedName.genusOrMonomial=Felis{{%/nba-link%}}

The output of the `scientificNameGroup` queries can be tuned with some additional parameters when using advanced queries:

* `groupSort` determines how buckets are sorted. Valid values are
  COUNT_DESC, COUNT_ASC (sort by the number of documents in each
  bucket), NAME_ASC, NAME_DESC (sort by the scientific name by which
  the buckets are grouped) and TOP_HIT_SCORE (sort by the highest
  score-value within each bucket).
* `groupFilter` allows for filtering of documents based on the
  scientific name. It can be configured to either accept or reject,
  and has an implementation for a regular expression, or an array of
  values:

  * `{ "acceptRegexp" : ".*larus*." }`
  * `{ "acceptValues" : [ "meles meles", "larus fuscus" ] }`
  * `{ "rejectRegexp" : ".*\?.*" }`
  * `{ "rejectValues" : [ "? ?", "? meles", "unknown" ] }`

* `specimensSortFields`: controls the sorting of specimen within each
  bucket. Same syntax as 'sortFields'.
* `specimensFrom` & `specimensSize` allow you to control which and how
  large a subset of the documents within each bucket are included in
  the resultset. Same syntax as 'from' and 'size'. Note that these
  parameters control the contents of all buckets at once.
* `noTaxa`: the specimen groupBy-query also returns corresponding
  taxon-records with the results. Set `noTaxa` to true to suppress.

See the
[Elasticsearch documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-regexp-query.html)
for their implementation of the regular expressions-syntax.

