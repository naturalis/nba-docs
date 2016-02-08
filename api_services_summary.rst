-------------------------
Services summary
-------------------------

Introduction
========================
The Netherlands Biodiversity API offers web services for free text search and specific indexed field(s) search in multiple taxonomy and specimen occurrence data sources. Searches can be done on either taxa, specimen occurrences, and, multimedia linked to either a taxon or a specimen occurrence. The searchable data is stored as text documents in Elasticsearch document store. In nearly all cases an API request returns data as a JSON-formatted document. 

For each type of data, i.e. taxon, specimen occurrence and multimedia, one or more http GET services - data acquisition operations - are available. Each service is described in this document. 


Taxonomic data services
========================

.. list-table:: 
   :widths: 30 100
   :header-rows: 1

   * - TAXON search
     - 
   * - | **Description**
     - | This direct search service returns TAXON documents. Available direct search types are a. free text search, and b. indexed field search.
   * - | **Examples**
     - | Examples of both free text and indexed field taxon searches can be found in the `specimen examples section`_
   * - | **Request**
       |
       |
       |
       |
       |
       |
       |
       |
       |
       | 
       |
       |
       | More details in
       | `taxon request section`_       
     - .. list-table:: 
          :widths: 40 100 100
          :header-rows: 1

          * - 
            - Free text search
            - Indexed field search 
          * - *HTTP support*
            - GET
            - GET
          * - *Searchable fields*
            - :ref:`list of indexed taxon document fields <list of indexed taxon document fields>` are queried
            - `list of indexed taxon document fields`_ can be queried
          * - *Geospatial search*
            - Not available
            - Not available
          * - *Meta parameters*
            - Paging and sorting parameters are available.
            - | Paging and sorting parameters are available. 
              |
              | Additional logical operator _andOr for indexed field search.  
          * - *Details*
            - | Request examples are listed in the `free text taxon search examples section`_
            - | Request examples are listed in the `indexed field taxon search examples section`_
   * - | **Response**
       |
       |
       | More details in
       | `taxon response section`_
     - .. list-table:: 
          :widths: 40 100 100
          :header-rows: 1

          * - 
            - Free text search
            - Indexed field search 
          * - *Data format*
            - JSON
            - JSON
          * - *Details*
            - | A response example can be viewed after calling a request example in the `free text taxon search examples section`_
            - | A response example can be viewed after calling a request example in the `indexed field taxon search examples section`_     

Specimen Occurrence data services
=================================

.. list-table:: 
   :widths: 30 100
   :header-rows: 1

   * - SPECIMEN search
     - 
   * - | **Description**
     - | This direct search service returns SPECIMEN documents. Available direct search types are a. free text search, and b. indexed field search.
   * - | **Examples**
     - | Examples of both free text and indexed field taxon searches can be found in the `specimen examples section`_
   * - | **Request**
       |
       |
       |
       |
       |
       |
       |
       |
       |
       |
       | More details in
       | `specimen request section`_
     - .. list-table:: 
          :widths: 40 100 100
          :header-rows: 1

          * - 
            - Free text search
            - Indexed field search 
          * - *HTTP support*
            - GET
            - GET
          * - *Searchable fields*
            - `list of indexed specimen document fields`_ are queried
            - `list of indexed specimen document fields`_ can be queried
          * - *Geospatial search*
            - Geosearch is available. Combined geo - free text search uses default the boolean operator AND. Sec geosearch is also possible.
            - Geosearch is available. Combined geo - indexed field search uses default the boolean operator AND. Sec geosearch is also possible.
          * - *Meta parameters*
            - Paging and sorting parameters are available.
            - | Paging and sorting parameters are available. 
              |
              | Additional logical operator _andOr for indexed field search.  
          * - *Details*
            - | Request examples are listed in the `free text specimen search examples section`_
            - | Request examples are listed in the `indexed field specimen search examples section`_
   * - | **Response**
       |
       |
       |
       | More details in
       | `specimen response section`_
     - .. list-table:: 
          :widths: 40 100 100
          :header-rows: 1

          * - 
            - Free text search
            - Indexed field search 
          * - *Data format*
            - JSON
            - JSON
          * - *Details*
            - | A response example can be viewed after calling a request example in the `free text specimen search examples section`_
            - | A response example can be viewed after calling a request example in the `indexed field specimen search examples section`_

|

.. list-table:: 
   :widths: 30 100
   :header-rows: 1

   * - SPECIMEN NAME search
     - 
   * - | **Description**
     - | This combined direct and indirect search service returns SPECIMEN documents. Available direct search types are a. free text search, and b. indexed field search. The indirect search service is an in-built name resolution service which is default active. Name resolution can not be deactivated. 
   * - | **Examples**
     - | Examples of both free text and indexed field taxon searches can be found in the `specimen name examples section`_
   * - | **Request**
       |
       |
       |
       |
       |
       |
       |
       |
       |
       |
       |
       |
       |
       |
       | More details in
       | `specimen name request section`_
     - .. list-table:: 
          :widths: 40 100 100
          :header-rows: 1

          * - 
            - Free text search
            - Indexed field search 
          * - *HTTP support*
            - GET
            - GET
          * - *Searchable fields*
            - `list of indexed specimen document fields for specimen name search`_ are queried. There is no overlap between this list and the list of selected fields for specimen seaerch. 
            - `list of indexed specimen document fields for specimen name search`_ can be queried. There is no overlap between this list and the list of selected fields for specimen seaerch. 
          * - *Geospatial search*
            - Geosearch is available. Combined geo - free text search uses default the boolean operator AND. Sec geosearch is also possible.
            - Geosearch is available. Combined geo - indexed field search uses default the boolean operator AND. Sec geosearch is also possible.
          * - *Meta parameters*
            - Paging and sorting parameters are available.
            - | Paging and sorting parameters are available. 
              |
              | Additional logical operator _andOr for indexed field search.  
          * - *Details*
            - | Request examples are listed in the `free text specimen name search examples section`_
            - | Request examples are listed in the `indexed field specimen name search examples section`_

   * - | **Response**
       |
       |
       |
       | More details in
       | `specimen name response section`_
     - .. list-table:: 
          :widths: 40 100 100
          :header-rows: 1

          * - 
            - Free text search
            - Indexed field search 
          * - *Data format*
            - JSON
            - JSON
          * - *Details*
            - | A response example can be viewed after calling a request example in the `free text specimen name search examples section`_
            - | A response example can be viewed after calling a request example in the `indexed field specimen name search examples section`_

|

.. list-table:: 
   :widths: 30 100
   :header-rows: 1

   * - SPECIMEN COLLECTION search
     - 
   * - | **Description**
     - | This direct search service returns a DwCA zip file containing all available SPECIMEN occurrences of a Naturalis Collection. All DwCA zip files have a similar internal file structure and comply to multiple data standards. 
   * - | **Examples**
     - | Examples of DwCA file downloads can be found in the `specimen collection examples section`_
   * - | **Request**
       |
       |
       | More details in
       | `specimen collection request section`_
     - .. list-table:: 
          :widths: 40 150
          :header-rows: 0

          * - *HTTP support*
            - GET
          * - *Downloadable collections*
            - `list of Naturalis collections`_ which are available for download. The list is living document. 
          * - *Geospatial search*
            - Not available
          * - *Meta parameters*
            - No specific meta parameters are available
          * - *Details*
            - Request examples are listed in the `specimen collection examples section`_
   * - | **Response**
       |
       | More details in
       | `specimen collection response section`_
     - .. list-table:: 
          :widths: 50 150
          :header-rows: 0

          * - *Data format*
            - DwCA
          * - *Details*
            - The basic structure of a DwCA file can be viewed after calling a request example in the `specimen collection examples section`_

Multimedia data services
========================

.. list-table:: 
   :widths: 30 100
   :header-rows: 1

   * - MULTIMEDIA search
     - 
   * - | **Description**
     - | This combined direct and indirect search service returns MULTIMEDIA documents. Available direct search types are a. free text search, and b. indexed field search. The indirect search service is an in-built name resolution service which is default active. Name resolution can not be deactivated. 
   * - | **Examples**
     - | Examples of both free text and indexed field taxon searches can be found in the `multimedia examples section`_
   * - | **Request**
       |
       |
       |
       |
       |
       |
       |
       |
       |
       |
       | More details in
       | `multimedia request section`_
     - .. list-table:: 
          :widths: 40 100 100
          :header-rows: 1

          * - 
            - Free text search
            - Indexed field search 
          * - *HTTP support*
            - GET
            - GET
          * - *Searchable fields*
            - `list of indexed multimedia document fields`_ are queried
            - `list of indexed multimedia document fields`_ can be queried
          * - *Geospatial search*
            - Geosearch is available. Combined geo - free text search uses default the boolean operator AND. Sec geosearch is also possible.
            - Geosearch is available. Combined geo - indexed field search uses default the boolean operator AND. Sec geosearch is also possible.
          * - *Meta parameters*
            - Paging and sorting parameters are available.
            - | Paging and sorting parameters are available. 
              |
              | Additional logical operator _andOr for indexed field search.  
          * - *Details*
            - | Request examples are listed in the `free text multimedia search examples section`_
            - | Request examples are listed in the `indexed field multimedia search examples section`_
   * - | **Response**
       |
       |
       | More details in
       | `multimedia response section`_
     - .. list-table:: 
          :widths: 40 100 100
          :header-rows: 1

          * - 
            - Free text search
            - Indexed field search 
          * - *Data format*
            - JSON
            - JSON
          * - *Details*
            - | The basic structure of the responses can be viewed in `free text multimedia search examples section`_
            - | The basic structure of the responses can be viewed in `indexed field multimedia search examples section`_

.. _here: http://api.biodiversitydata.nl/v0/version
