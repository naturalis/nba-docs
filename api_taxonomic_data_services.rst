-----------------------
Taxonomic data services
-----------------------

1.TAXON SEARCH
==============

.. _Taxon-search:

Description
-----------
This direct search service returns TAXON documents. It comes in two search type flavours, i.e. 1. Free text search, and 2. Indexed field search. 
 
Both search types execute searches through taxonomic data harvested from - currently - two data sources, i.e. a. Catalogue_of_life_ , b. Nederlands_Soortenregister_. It searches a `list of indexed taxon document fields`_ and returns taxon multilingual taxon documents in JSON responses from basically species and subspecies.

.. _Catalogue_of_life: http://www.catalogueoflife.org/
.. _Nederlands_Soortenregister: http://www.nederlandsesoorten.nl
.. _taxon request section:

Requests
--------
url
```
The basic request url for free text search is:

.. code:: html

   <base url>/taxon/search/?_search=[term], e.g. http://api.biodiversitydata.nl/v0/taxon/search/?_search=Abies

The basic request url for indexed field search is:

.. code:: html

   <base url>/taxon/search/?indexedField1=[term]&indexedField2=[term], e.g. http://api.biodiversitydata.nl/v0/taxon/search/?genusOrMonomial=Parus

indexed field name(s) in an url
```````````````````````````````
A taxon document incorporates an extensive set of fields. A subset of this set is indexed and therefore searchable. Stating a field name in an indexed field search request can be done by the using either,

a. a field path, e.g. <base url>/taxon/search/?genusOrMonomial=Abies, or
b. a field alias, e.g. <base url>/taxon/search/?genus=Abies

.. _list of indexed taxon document fields:

================================================= ================================================= =====================
Indexed field                                     Aliasses                                          Single term handling
================================================= ================================================= =====================
sourceSystem.name                                 sourceSystem		                                 exact match	
acceptedName.genusOrMonomial                      genus, genusOrMonomial                            exact match
acceptedName.subgenus                             subgenus                                          exact match
acceptedName.specificEpithet                      species, specificEpithet                          exact match
acceptedName.infraspecificEpithet                 infraspecificEpithet, subspecies                  exact match
acceptedName.taxonomicStatus                      taxonomicStatus                                   exaxt match
defaultClassification.kingdom                     kingdom                                           exact match
defaultClassification.phylum                      phylum                                            exact match
defaultClassification.className                   class, className                                  exact match
defaultClassification.order                       order                                             exact match
defaultClassification.family                      family                                            exact match
defaultClassification.genus                       genus, genusOrMonomial                            exact match
defaultClassification.subgenus                    subgenus                                          exaxt match
defaultClassification.specificEpithet             species, specificEpithet                          exact match
defaultClassification.infraspecificEpithet        infraspecificEpithet, subspecies                  exact match
experts.fullName                                  expert                                            exact match
experts.organization.name                         expertOrganisation                                exact match
synonyms.genusOrMonomial                          genus, genusOrMonomial                            exact match
synonyms.subgenus                                 subgenus                                          exact match
synonyms.specificEpithet                          species, specificEpithet                          exact match
synonyms.infraspecificEpithet                     infraspecificEpithet, subspecies                  exact match
synonyms.experts.fullName                         expert                                            exact match
synonyms.experts.organization.name                expertOrganisation                                exact match
synonyms.taxonomicStatus                          taxonomicStatus                                   exaxt match
systemClassification.name                         not applicable                                    exact match
vernacularNames.name                              commonName, vernacularName                        \*term*\ match
vernacularNames.experts.fullName                  expert                                            exact match
vernacularNames.experts.organization.name         expertOrganisation                                exact match
================================================= ================================================= =====================

Some of the searchable fields have a predefined set of search values.

================================================= ========================================================================== 
Indexed field                                     Search values
================================================= ========================================================================== 
sourceSystem.name                                 Naturalis - Nederlands Soortenregister, Species 2000 - Catalogue Of Life
defaultClassification.kingdom                     Animalia, Archea, Bacteria, Chromista, Fungi, Plantae, Protozoa, Viruses
================================================= ==========================================================================

general meta parameters in an url
`````````````````````````````````
For both types of searches optional extra request parameters – so called meta parameters - can be added to the request. These meta-parameters instruct the NBA on how to execute a query.

Paging parameters

.. list-table:: 
   :widths: 15 100
   :header-rows: 1

   * - Name
     - Description
   * - _maxResults
     - | • _maxResults instructs NBA to return maximum amount of search results per page
       | • default NBA setting maxResults: 10 (for requests without _maxResults parameter)                  
       | • example: request results in a list of maximum 60 documents
        
       .. code:: html

          <base url>/taxon/search/?_search=Abies&_maxResults=20,
   * - _offset
     - | • _offset instructs NBA to start filling first response from search result no = offset value + 1
       | • default NBA setting offset: 0 (for requests without _offset parameter)
       | • example: request results in a list with search result no 21 as first document in list

       .. code:: html

          <base url>/taxon/search/?_search=Abies&_offset=20. 

Sorting parameters

.. list-table:: 
   :widths: 15 100
   :header-rows: 1

   * - Name
     - Description
   * - _sort
     - | • _sort instructs NBA to return responses sorted on a single specified indexed field included in taxon documents          
       | • default NBA setting sort: _score (for requests without _score parameter)
       | • remarks: _sort parameter can be used for all fields in a taxon document. Sort parameter values should be fieldpaths, e.g. gatheringEvent.locality
       | • example: request results in list sorted on unitID (in ascending order)
                   
       .. code:: html
 
          <base url>/taxon/search/?genus=Abies&_sort=defaultClassification.specificEpithet

   * - _sortDirection
     - | • _sortDirection instructs NBA on sorting direction, i.e. either descending (DESC) or ascending (ASC)
       | • default NBA setting sortDirection: ASC (for requests without _sortDirection parameter)
       | • example: request results in list sorted on unitID in descending order
     
       .. code:: html

          <base url>/taxon/search/?genus=Abies&_sort=defaultClassification.specificEpithet&_sortDirection=DESC


specific meta parameters for indexed field search
`````````````````````````````````````````````````
For indexed field search extra meta parameters are available.

.. list-table:: 
   :widths: 15 100
   :header-rows: 1

   * - Name
     - Description
   * - _andOr
     - | • _andOr instructs NBA to use logical operator AND (conjunction) for multiple indexed field search
       | • default NBA setting andOr: AND (for requests without _andOR parameter)
       | • example: request results in list with result of OR search on genus = Parus and species = major

       .. code:: html
               
          <base url>/taxon/search/?genus=Parus&species=major&_andOr=OR

.. _taxon response section:

Responses
---------
basic response structure
````````````````````````
The basic structure of the responses can be viewed in the subsequent example section. 
  
.. _taxon examples section:

Examples
--------

.. _free text taxon search examples section:

free text search
````````````````
Search for value Parus in any taxon document

.. code:: html
 
   http://api.biodiversitydata.nl/v0/taxon/search/?_search=Parus

Search for value paardenbloem (lower case term  search- english term = Dandelion) in any taxon document

.. code:: html
 
   http://api.biodiversitydata.nl/v0/taxon/search/?_search=paardenbloem

Search for value PAARDENBLOEM (upper case term search - english term = Dandelion) in any taxon document 
 
.. code:: html
 
   http://api.biodiversitydata.nl/v0/taxon/search/?_search=PAARDENBLOEM

Search for value Bloem in any taxon document

.. code:: html
 
   http://api.biodiversitydata.nl/v0/taxon/search/?_search=Bloem

Search for value Bloem in any taxon document, maximum of 20 documents in result, sort = ascending (ASC)
   
.. code:: html
 
   http://api.biodiversitydata.nl/v0/taxon/search/?_search=Bloem&_maxResults=20&_sort=_score&_sortDirection=ASC

Search for value Bloem in any taxon document, start from document 21

.. code:: html
 
   http://api.biodiversitydata.nl/v0/taxon/search/?_search=Bloem&_offset=20

.. _indexed field taxon search examples section:

indexed field search
````````````````````
Search for key:value pair genus=Parus in any taxon document
 
.. code:: html
 
   http://api.biodiversitydata.nl/v0/taxon/search/?genus=Parus

Search for key:value pair genus=Parus and species=major in any taxon document (default=AND)

.. code:: html
 
   http://api.biodiversitydata.nl/v0/taxon/search/?genus=Parus&species=major

Search for key:value pair genus=Parus or species=major in any taxon document
   
.. code:: html
 
   http://api.biodiversitydata.nl/v0/taxon/search/?genus=Parus&species=major&_andOr=OR

Search for key:value pair sourceSystem=Naturalis - Nederlands Soortenregister in any taxon document

.. code:: html
 
   http://api.biodiversitydata.nl/v0/taxon/search/?sourceSystem=Naturalis - Nederlands Soortenregister

Search for key:value pair PAARDENBLOEM in any taxon document

.. code:: html
 
   http://api.biodiversitydata.nl/v0/taxon/search/?vernacularNames.name=PAARDENBLOEM

Search for key:value pair Bloem in any taxon document

.. code:: html
 
   http://api.biodiversitydata.nl/v0/taxon/search/?vernacularNames.name=Bloem

Search for key:value pair Bloem in any taxon document, 20 documents in result, sort = ascending (ASC)

.. code:: html
 
   http://api.biodiversitydata.nl/v0/taxon/search/?vernacularNames.name=Bloem&_maxResults=20&_sort=_score&_sortDirection=ASC

Search for value Bloem pair in any taxon document, start from document 21
 
.. code:: html
  
   http://api.biodiversitydata.nl/v0/taxon/search/?vernacularNames.name=Bloem&_offset=20
