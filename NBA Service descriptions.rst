Introduction
============
Naturalis offers web services for free text and indexed field search in multiple taxonomy and specimen occurrence data sources. Searches can be done on either taxons, specimen occurrences and multimedia linked to either a taxon or a specimen occurrence. The searchable data is stored text documents in Elastic search document store. The following information has been made available per service type.

================================== ========= ================== ========== =========
Taxonomic data services
================================== ========= ================== ========== =========
Taxon search                       requests_ searchable_fields_ responses_ examples_
================================== ========= ================== ========== =========

================================== ========= ================== ========== =========
Specimen occurrence data services
================================== ========= ================== ========== =========
Specimen search                    requests  searchable_fields  responses  examples
---------------------------------- --------- ------------------ ---------- ---------
Specimen name-search               requests  searchable_fields  responses  examples
================================== ========= ================== ========== =========

================================== ========= ================== ========== =========
Multimedia data services
================================== ========= ================== ========== =========
Multimedia search                  requests  searchable_fields  responses  examples
================================== ========= ================== ========== =========

.. _searchable_fields: https://github.com/naturalis/nba-docs/blob/master/Searchable%20fields%20per%20NBA%20service.rst

Access
======
The access to all Naturalis data services is open. 

Taxonomic data services
=======================

1.TAXON SEARCH
--------------
 
*Description*
 This services comes in two flavours, i.e. 1. Free text search, and 2. Indexed field search. 
 Both search types execute searches on taxonomic data harvested from - currently - two data sources, i.e. a. Catalogue_of_life_, b. Nederlands_Soortenregister_. It searches a predefined subset of indexed taxon document fields and returns in JSON responses multilingual taxonomic data from basically species and subspecies. 

 .. _Catalogue_of_Life: http://www.catalogueoflife.org/
 .. _Nederlands_Soortenregister: http://www.nederlandsesoorten.nl

 The base url for this service is: http://10.42.1.177:8080/v0

.. _requests:

*Requests*
 *url*
  The basic request url for free text search is:
  <base url>/taxon/search/?_search=[term], e.g. http://10.42.1.177:8080/v0/taxon/search/?_search=Abies
  
  The basic request url for indexed field search is:
  <base url>/taxon/search/?indexedField1=[term]&indexedField2[term], e.g. http://10.42.1.177:8080/v0/taxon/search/?genusOrMonomial=Parus
  
 *indexed field name(s) in an url*
  A taxon document incorporates an extensive set of taxonomic fields. A subset of this set is searchable and is listed in this document_. Stating a field name in a indexed field search request can be done by either,

  a. field path(s), e.g. <base url>/taxon/search/?genusOrMonomial=Abies
  b. field aliasses, e.g. <base url>/taxon/search/?genus=Abies

 .. _document: https://github.com/naturalis/nba-docs/blob/master/Searchable%20fields%20per%20NBA%20service.rst
  
 *general meta parameters in an url*
  For both types of searches optional extra request parameters – so called meta parameters - can be added to the request. These meta-parameters instruct the NBA on how to execute a query.

  Paging parameters

  ===========   =========================================================================================================
  Name          Description
  ===========   =========================================================================================================
  _maxResults   - _maxResults instructs NBA to return maximum amount of search results per page 
                - example: <base url>/taxon/search/?_search=Abies&_maxResults=20, shows maximum amount of 60 documents in a response
                - default setting: _maxResults=10
  -----------   ---------------------------------------------------------------------------------------------------------
  _offset       - _offset instructs NBA to start filling first response from search result no = offset value + 1
                - example: <base url>/taxon/search/?_search=Abies&_offset=20. In first response search result no 21 is first document in response 
                - default setting: _offset=0
  ===========   =========================================================================================================
  
  Sorting parameters
   
  ==============   ======================================================================================================
  Name             Description
  ==============   ======================================================================================================
  _sort            - _sort instructs NBA to return responses sorted on a single specified indexed field included in Taxon documents
                   - example: <base url>/taxon/search/?genus=Abies&_sort=unitID, shows taxon documents sorted on unitID
                   - default setting: _sort = _score
                   - remarks: _sort parameter can be used for all fields in a taxon document. Sort parameter values should be fieldpaths, e.g. gatheringEvent.locality
  --------------   ------------------------------------------------------------------------------------------------------
  _sortDirection   - _sortDirection instructs NBA on sorting direction, i.e. either descending or ascending
                   - example: <base url>/taxon/search/?genus=Abies&_sort=unitID&_sortDirection=ASC 
                   - default setting: _sortDirection=ASC
  ==============   ======================================================================================================
      
 *specific meta parameters for indexed field search*
  For indexed field search extra meta parameters are available. 
   
  ===========   =========================================================================================================
  Name          Description
  ===========   =========================================================================================================
  _andOr        - _andOr instructs NBA to use logical operator AND (conjunction) for multiple indexed field search
                - example: <base url>/taxon/search/?genus=Parus&species=major&_andOr=AND
                - default setting: _andOr=AND
  ===========   =========================================================================================================

.. _responses:

*Responses*
  
 *basic response structure*
  The xsd structure of a taxon response can be viewed here (document reference to be added, reengineer xsd structure from xml with xml spy). 

.. _examples:

*Examples*

 1. Free text search

  Search for value Parus in any taxon                          
   http://10.42.1.177:8080/v0/taxon/search/?_search=Parus
  
  Search for value paardenbloem in any taxon                   
   http://10.42.1.177:8080/v0/taxon/search/?_search=paardenbloem
  
  Search for value PAARDENBLOEM in any taxon                   
   http://10.42.1.177:8080/v0/taxon/search/?_search=PAARDENBLOEM
  
  Search for value BLOEM in any taxon                          
   http://10.42.1.177:8080/v0/taxon/search/?_search=Bloem
  
  Search for value BLOEM in any taxon | 20 documents in result | sort = ascending
   http://10.42.1.177:8080/v0/taxon/search/?_search=Bloem&_maxResults=20&_sort=_score&_sortDirection=DESC

  Search for value BLOEM in any taxon | start from document 21
   http://10.42.1.177:8080/v0/taxon/search/?_search=Bloem&_offset=20

  Search for value BLOEM in any taxon | start from document 21
   http://10.42.1.177:8080/v0/taxon/search/?_search=Bloem&_offset=20

 2. Indexed field search
 
  Search for key:value pair genus=Parus in any taxon                          
   http://10.42.1.177:8080/v0/taxon/search/?genus=Parus

  Search for key:value pair genus=Parus and species=major in any taxon (default=AND)                         
   http://10.42.1.177:8080/v0/taxon/search/?genus=Parus&species=major

  Search for key:value pair genus=Parus or species=major in any taxon                           
   http://10.42.1.177:8080/v0/taxon/search/?genus=Parus&species=major&_andOr=OR
  
  Search for key:value pair paardenbloem in any taxon                   
   http://10.42.1.177:8080/v0/taxon/search/?vernacularNames.name=paardenbloem
  
  Search for key:value pair PAARDENBLOEM in any taxon                   
   http://10.42.1.177:8080/v0/taxon/search/?vernacularNames.name=PAARDENBLOEM
  
  Search for key:value pair BLOEM in any taxon                          
   http://10.42.1.177:8080/v0/taxon/search/?vernacularNames.name=Bloem
  
  Search for key:value pair BLOEM in any taxon | 20 documents in result | sort = ascending
   http://10.42.1.177:8080/v0/taxon/search/?vernacularNames.name=Bloem&_maxResults=20&_sort=_score&_sortDirection=DESC

  Search for value BLOEM pair in any taxon | start from document 21
   http://10.42.1.177:8080/v0/taxon/search/?vernacularNames.name=Bloem&_offset=20

  Search for value BLOEM pair in any taxon | start from document 21
   http://10.42.1.177:8080/v0/taxon/search/?vernacularNames.name=Bloem&_offset=20
