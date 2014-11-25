Introduction
============
Naturalis offers web services for free text and indexed field search in multiple taxonomy and specimen occurrence data sources. Searches can be done on either taxons, specimen occurrences and multimedia linked to either a taxon or a specimen occurrence. The searchable data is stored text documents in Elastic search document store. The following information has been made available per service type: add table with references.

Access
======
Access information will be made available soon. 

Services
========

  **Taxonomic data services**
  
    *1.TAXON search*
    
    *description*
     Free text or indexed field search through taxonomic data from multiple data sources. It searches a specific predefined set of indexed taxon document fields and returns taxonomic data from all taxonomic statuses or levels, i.e. kingdom to varieties.
     
    *request*
     *URL*
      The basic request url for free text search is:
      <base url>/taxon/search/?_search=[term], e.g. <base url>/taxon/search/?_search=Abies
      
      The basic request url for indexed field search is:
      <base url>/taxon/search/?indexedField1=[term]&indexedField2[term], e.g. <base url>/taxon/search/?genusOrMonomial=Parus or genusOrMonomial=Parus&species=major
      
     *Indexed field parameters*
      For indexed field search indexed field parameters
      
      - document field name
      - aliases and multi mapped fields
      - whole path
      
     *General meta parameters*
      For both free text and indexed field search requests optional extra request parameters – so called meta parameters - can be added. These parameters instruct the NBA on how to execute a query. 
      
      Paging parameters
      
      ===================  ========================================================================
      Name                 Description
      ===================  ========================================================================
      _maxResults          - _maxResults instructs NBA to return maximum amount of search results per page
      ===================  ========================================================================

     

       

     

    
    
    
  




