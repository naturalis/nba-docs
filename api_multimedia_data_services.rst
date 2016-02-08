------------------------
Multimedia data services
------------------------

.. _Multimedia-search:

1.MULTIMEDIA SEARCH
===================

Description
-----------
This combined direct and indirect search service returns SPECIMEN occurrence documents. It comes in two varieties, i.e. 1. Free text search, and 2. Indexed field search. In the responses it combines the outcomes of two document search processes, a. direct search on multimedia documents, and, b. multimedia document search based on the outcome of the name-resolution process (indirect search). This preceding process is executed on taxonomic data from all available taxonomic data sources.

Both search types execute searches through both specimen occurrence data and taxonomic data which include multimedia references. This data is harvested from three data sources. The excluded source is Catalogue of Life. The service searches a `list of indexed multimedia document fields`_ and returns multilingual specimen documents in JSON responses. The contents of these multimedia documents depend on the type of data source. They always include taxomic information. Geospatial and temporal information are present in specimen-derivded multimedia documents.

Due to the nature of it's sources the list of searchable fields for this service contains both taxonomic fields (taxonomic data) and not-taxonomic fields, e.g. geographic and temporal fields 

.. _multimedia request section:

Requests
--------
url
```
The basic request url for free text search is:

.. code:: html

   <base url>/multimedia/search/?_search=[term], e.g. http://api.biodiversitydata.nl/v0/multimedia/search/?_search=paardenbloem

The basic request url for indexed field search is:

.. code:: html

   <base url>/multimedia/search/?indexedField1=[term]&indexedField2[term], e.g. http://api.biodiversitydata.nl/v0/multimedia/search/?genusOrMonomial=Parus

geospatial search option in an url
``````````````````````````````````
Geospatial search can be combined with either a free text search or an indexed field search. This combined search uses default the boolean operator AND. 

Geosearch can also be done without additional free text or indexed field search.

Geospatial parameter

.. list-table:: 
   :widths: 15 100
   :header-rows: 1

   * - Name
     - Description
   * - _geoShape
     - | • _geoshape instructs NBA to return specimen documents which are  gathered by collectors during field research in a specific area
       | • default NBA setting geoshape: not applicable
       | • remarks: use lat/long coordinates.
       | • example: request results in list of specimen gathered in Jordan 

       .. code:: html
           
          <base url>/multimedia/search/?_geoshape=decoded coordinates of Jordan

indexed field name(s) in an url
```````````````````````````````
A multimedia document incorporates an extensive set of fields. A subset of this set is indexed and therefore searchable. Stating a field name in an indexed field search request can be done by using either,

a. a field path, e.g. <base url>/multimedia/search/?genusOrMonomial=Larus, or
b. a field alias, e.g. <base url>/multimedia/search/?genus=Larus

.. _list of indexed multimedia document fields:

========================================================== ============================================= =====================
Indexed field                                              Aliasses                                      Single term handling
========================================================== ============================================= =====================
unitID                                                     registrationNumber, unitID                    exact match
sourceSystem.name                                          sourceSystem		                             exact match
sexes                                                      sex                                           exact match
specimenTypeStatus                                         typeStatus                                    exact match
phasesOrStages                                             phaseOrStage                                  exact match
collectionType                                             not applicable                                exact match

identifications.vernacularNames.name                       commonName, vernacularName                    \*term*\  match
identifications.defaultClassification.kingdom              kingdom                                       exact match
identifications.defaultClassification.phylum               phylum                                        exact match
identifications.defaultClassification.className            class, className                              exact match
identifications.defaultClassification.order                order                                         exact match
identifications.defaultClassification.family               family                                        exact match
identifications.defaultClassification.genusOrMonomial      genus, genusOrMonomial                        \*term*\  match
identifications.defaultClassification.subgenus             subgenus                                      exact match
identifications.defaultClassification.specificEpithet      species, specificEpithet                      exact match
identifications.defaultClassification.infraspecificEpithet infraspecificEpithet, subspecies              exact match
identifications.scientificName.genusOrMonomial             genus, genusOrMonomial                        exact match
identifications.scientificName.subgenus                    subgenus                                      exact match
identifications.scientificName.specificEpithet             species, specificEpithet                      exact match
identifications.scientificName.infraspecificEpithet        infraspecificEpithet, subspecies              exact match
_geoshape (= geo search parameter)                         not applicable                                in geoshape match
========================================================== ============================================= =====================

Some searchable fields have a predefined set of search values.

================================================= ==========================================================================
Indexed field                                     Search values
================================================= ========================================================================== 
sourceSystem.name                                 Naturalis - Zoology and Geology catalogues, Naturalis - Botany catalogues,
                                                  Naturalis - Nederlands Soortenregister
typeStatus                                        allotype, epitype, holotype, isoepitype, isolectortype, isoneotype,
                                                  isosyntype, isotype, lectotype, neotype, paralectotype, paratype, syntype,
                                                  topotype
phaseOrStage                                      adult, egg, embryo, immature, juvenile, larva, nymph, subadult
sex                                               female, hermaphrodite, male, mixed
collectionType                                    Arts, Aves, Brachiopoda, Bryozoa, Botany, Cainozoic Mollusca, 
                                                  Chelicerata and Myriapoda, Cnidaria, Coleoptera, Collembola, Crustacea, 
                                                  Diptera, Entomology, Foraminifera, Hemiptera, Hymenoptera, Invertebrates,
                                                  Lepidoptera, Mammalia, Micropaleontology, Mineralogy, Mineralogy and
                                                  Petrology, Mollusca, Odonata, Orthopteroidea, Paleobotany, Paleontology,
                                                  Paleontology Invertebrates, Petrology, Porifera, Protozoa, Remaining
                                                  insects, Tunicata, Vermes, miscellaneous
================================================= ==========================================================================

additional integrated search capabilities
`````````````````````````````````````````
Name resolution is a search process on taxonomic data from the available taxonomic data sources. This process carries out a Taxon search of the indexed field type. The basic request url is:

.. code:: html

   <basic url>/taxon/search/?vernacularNames.name=[terms out specimen name search, either simple or indexed field search].

The full scientific names of the taxon documents in the responses are input for an additional search on specimen documents.

general meta parameters
```````````````````````
For both free text and indexed field search requests optional extra request parameters – so called meta parameters - can be added. These parameters instruct the NBA on how to execute a query.

Paging parameters

.. list-table:: 
   :widths: 15 100
   :header-rows: 1

   * - Name
     - Description
   * - _maxResults
     - | • _maxResults instructs NBA to return maximum amount of search results per page
       | • default NBA setting maxResults: 10 (for requests without _maxResults parameter)
       | • example: request results in list of maximum 20 documents

       .. code:: html

          <base url>/multimedia/search/?_search=Larus&_maxResults=20
   * - _offset
     - | • _offset instructs NBA to start filling first response from search result no = offset value + 1
       | • default NBA setting offset: 0 (for requests without _offset parameter)
       | • example: request results in list in which first document is search result no 21.

       .. code:: html

          <base url>/multimedia/search/?_search=Larus&_offset=20

Sorting parameters

.. list-table:: 
   :widths: 15 100
   :header-rows: 1

   * - Name
     - Description
   * - _sort
     - | • _sort instructs NBA to return responses sorted on a single specified indexed field included in multimedia documents          
       | • default NBA setting sort: _score (for requests without _score parameter)
       | • remarks: _sort parameter can be used for all fields in a multimedia document. Sort parameter values should be a fieldpath, e.g. identifications.scientificName.subgenus
       | •  example: request results in list sorted on unitID

       .. code:: html

          <base url>/multimedia/search/?genus=Larus&_sort=unitID

   * - _sortDirection
     - | • _sortDirection instructs NBA on sorting direction, i.e. either descending (DESC) or ascending (ASC)
       | • default NBA setting sortDirection: ASC (for requests without _sortDirection parameter)
       | • example: request results in list sorted on unitID and sort direction is descending

       .. code:: html

          <base url>/multimedia/search/?genus=Larus&_sort=unitID&_sortDirection=DESC

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
       | • example: request results in list based on OR search

       .. code:: html

          <base url>/multimedia/search/?genus=Larus&species=argentatus&_andOr=OR

.. _multimedia response section:

Responses
---------
basic response structure
````````````````````````
The basic structure of the responses can be viewed in the subsequent example section. 

.. _multimedia examples section:

Examples
--------

.. _free text multimedia search examples section:

1. Free text search
```````````````````

Search for koolmees in any multimedia document

.. code:: html

   http://api.biodiversitydata.nl/v0/multimedia/search/?_search=koolmees

Search for mees in any multimedia document

.. code:: html

   http://api.biodiversitydata.nl/v0/multimedia/search/?_search=mees

Search for Parus major in any multimedia document

.. code:: html

   http://api.biodiversitydata.nl/v0/multimedia/search/?_search=Parus major

Search for Melicertus kerathurus in any multimedia document

.. code:: html 

   http://api.biodiversitydata.nl/v0/multimedia/search/?_search=Abies abies
    
Search for L.4275659 in Brahms in any multimedia document

.. code:: html

   http://api.biodiversitydata.nl/v0/multimedia/search/?_search=L.4275659

.. _indexed field multimedia search examples section:

2. Indexed field search
```````````````````````

Search for key:value pair unitID=AHCYFCKPYRK:1560587210 in NSR in any multimedia document
  
.. code:: html

   http://api.biodiversitydata.nl/v0/multimedia/search/?unitID=AHCYFCKPYRK:1560587210

Search for key:value pair vernacularName=paardenbloem in any multimedia document
   
.. code:: html

   http://api.biodiversitydata.nl/v0/multimedia/search/?vernacularName=paardenbloem

Search for key:value pairs genus=Parus and species=major in any multimedia document

.. code:: html

   http://api.biodiversitydata.nl/v0/multimedia/search/?genus=Parus&species=major
