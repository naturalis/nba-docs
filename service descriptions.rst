Introduction
============
Naturalis offers web services for free text and indexed field search in multiple taxonomy and specimen occurrence data sources. Searches can be done on either taxons, specimen occurrences and multimedia linked to either a taxon or a specimen occurrence. The searchable data is stored text documents in Elastic search document store. The following information has been made available per service type: add table with references.

Access
======
Access information will be made available soon. 

Taxonomic data services
=======================

1.TAXON search
--------------
 
*Description*
  Free text or indexed field search through taxonomic data from multiple data sources. It searches a specific predefined set of indexed taxon document fields and returns taxonomic data from all taxonomic statuses or levels, i.e. kingdom to varieties.

*Requests*
 *url*
  The basic request url for free text search is:
  <base url>/taxon/search/?_search=[term], e.g. <base url>/taxon/search/?_search=Abies
  
  The basic request url for indexed field search is:
  <base url>/taxon/search/?indexedField1=[term]&indexedField2[term], e.g. <base url>/taxon/search/?genusOrMonomial=Parus or genusOrMonomial=Parus&species=major
  
 
*indexed field parameters*
 For indexed field search indexed field parameters
 
 - document field name
 - aliases and multi mapped fields
 - whole path
 
*general meta parameters*
 For both free text and indexed field search requests optional extra request parameters – so called meta parameters - can be added. These parameters instruct the NBA on how to execute a query.

 Paging parameters

 ===========   =========================================================================================================
 Name          Description
 ===========   =========================================================================================================
 _maxResults      
               - _maxResults instructs NBA to return maximum amount of search results per page 
               - example: <base url>/taxon/search/?..&_maxResults=60, shows maximum amount of 60 documents in responses
               - default setting: _maxResults=10
 _offset      
               - _offset instructs NBA to start filling first response from search result no = offset value + 1
               - example: <base url>/taxon/search/?..&_offset=100. In first response search result no 101 is first document in response 
               - default setting: _offset=0
 ===========   =========================================================================================================

 Sorting parameters. Add table

*specific meta parameters for indexed field search*
 For indexed fields search specific search meta parameters are available. Add table
  
*Responses*

- Basic structure
- Term handling
- Rest links
- Multi-language
- ABCD EFG
- JSON

*Examples*
1. Free test search
 Example 1: Search for ......in .....documents
 
 Request: create box with url
  
 Example 2: Search for ......in .....documents
 
 Request: create box with url

2. Indexed field search
 Example 1: Search for ......in .....documents
 
 Request: create box with url
  
 Example 2: Search for ......in .....documents
 
 Request: create box with url 

Specimen data services
======================

1.SPECIMEN search
-----------------

*Description*
 Free text or indexed field search through specimen occurrence data from multiple data sources. It searches a predefined set of specimen document fields and returns taxonomic, geospatial and temporal information from specimen
 
*Requests*
 *url*
  The basic request url for free text search is:
  <base url>/specimen/search/?_search=[term], e.g. <base url>/specimen/search/?_search=Parus
  
  The basic request url for indexed field search is:
  <base url>/specimen/search/?indexedField1=[term]&indexedField2=[term], e.g. <base url>/specimen/search/?typeStatus=holotype or <base url>/specimen/search/?typeStatus=holotype&sex=male 
 
 *geospatial search*
 Geospatial search is
 
 Geospatial search can be combined with either free text or indexed field search. It can also be used on its own.
 
 *additional integrated search capabilities*HIER GEBLEVEN
 
 *indexed field parameters*
  For indexed field search indexed field parameters
  
  - document field name
  - aliases and multi mapped fields
  - whole path
  
 *general meta parameters*
  For both free text and indexed field search requests optional extra request parameters – so called meta parameters - can be added. These parameters instruct the NBA on how to execute a query.
 
  Paging parameters
 
  ===========   =========================================================================================================
  Name          Description
  ===========   =========================================================================================================
  _maxResults      
                - _maxResults instructs NBA to return maximum amount of search results per page 
                - example: <base url>/taxon/search/?..&_maxResults=60, shows maximum amount of 60 documents in responses
                - default setting: _maxResults=10
  _offset      
                - _offset instructs NBA to start filling first response from search result no = offset value + 1
                - example: <base url>/taxon/search/?..&_offset=100. In first response search result no 101 is first document in response 
                - default setting: _offset=0
  ===========   =========================================================================================================
 
  Sorting parameters. Add table
 
 *specific meta parameters for indexed field search*
  For indexed fields search specific search meta parameters are available. Add table
   
*Responses*

- Basic structure
- Term handling
- Rest links
- Multi-language
- ABCD EFG
- JSON
 
*Examples*
 1. Free test search
  Example 1: Search for ......in .....documents
  
  Request: create box with url
   
  Example 2: Search for ......in .....documents
  
  Request: create box with url
 
 2. Indexed field search
  Example 1: Search for ......in .....documents
  
  Request: create box with url
   
  Example 2: Search for ......in .....documents
  
  Request: create box with url 
 
 
 TEst
 
   
 
 
 
 
 
  
