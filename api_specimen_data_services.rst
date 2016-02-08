---------------------------------
Specimen Occurrence data services
---------------------------------

.. _Specimen-search:

1.SPECIMEN SEARCH
=================

Description
-----------
This direct search service returns TAXON documents. It comes in two search type flavours, i.e. 1. Free text search, and 2. Indexed field search. 
 
Both search types execute searches through specimen occurrence data harvested from - currently - two voluminous, Naturalis data sources, i.e. a. CRS (Collection Registration System for zoological and geological specimen) and b. Brahms for botanical specimen. It searches a `list of indexed specimen document fields`_ and returns multilingual specimen documents in JSON responses. This list of searchable fields contains only fields that are not taxonomic, e.g. unitID and locality. Searches on specimen taxonomic fields can be done with the NBA service Specimen-name-search_.

.. _specimen request section:

Requests
--------
url
```
The basic request url for free text search is:

.. code:: html
 
   <base url>/specimen/search/?_search=[term], e.g. http://api.biodiversitydata.nl/v0/specimen/search/?_search=male

The basic request url for indexed field search is:

.. code:: html
 
   <base url>/specimen/search/?indexedField1=[term]&indexedField2=[term], e.g. http://api.biodiversitydata.nl/v0/specimen/search/?typeStatus=holotype

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
 
          <base url>/specimen/search/?_geoshape=list of decoded coordinates of Jordan

indexed field name(s) in an url
```````````````````````````````
A specimen document incorporates an extensive set of fields. A subset of this set is indexed and therefore searchable. Stating a field name in an indexed field search request can be done by using either,

a. a field path, e.g. <base url>/specimen/search/?genusOrMonomial=Abies, or
b. a field alias, e.g. <base url>/specimen/search/?genus=Abies

.. _list of indexed specimen document fields:

================================================= =================================================== ======================
Indexed field                                     Aliasses                                            Single term handling
================================================= =================================================== ======================
unitID                                            registrationNumber, unitID                          exact match
sourceSystem.name                                 sourceSystem		                                  exact match	
typeStatus                                        typeStatus                                          exact match
phaseOrStage                                      phaseOrStage                                        exact match
sex                                               sex                                                 exact match
collectorsFieldNumber                             collectorsFieldNumber                               exact match
collectionType                                    not applicable                                      exact match

gatheringEvent.localityText                       locality, localityText                              \*term*\  match
gatheringEvent.gatheringAgents.fullName           collector, gatheringAgent                           exact match
gatheringEvent.gatheringAgents.organization       collector, gatheringAgent                           exact match
gatheringEvent.dateTimeBegin                      collectingStartDate                                 exact match
_geoshape (= geo search parameter)                not applicable                                      in geoshape match
================================================= =================================================== ======================

Some searchable fields have a predefined set of search values.

================================================= ===========================================================================
Indexed field                                     Search values
================================================= =========================================================================== 
sourceSystem.name                                 Naturalis - Zoology and Geology catalogues, Naturalis - Botany catalogues
typeStatus                                        allotype, epitype, holotype, isoepitype, isolectortype, isoneotype,
                                                  isosyntype, isotype, lectotype, neotype, paralectotype, paratype, syntype,
                                                  topotype
phaseOrStage                                      adult, egg, embryo, immature, juvenile, larva, nymph, subadult
sex                                               female, hermaphrodite, male, mixed
collectionType                                    Amphibia and Reptilia, Arts, Aves, Brachiopoda, Bryozoa, Botany, 
                                                  Cainozoic Mollusca, Chelicerata and Myriapoda, Cnidaria, Coleoptera, 
                                                  Collembola, Crustacea, Diptera, Echinodermata, Entomology, Foraminifera, 
                                                  Hemiptera, Hymenoptera, Invertebrates, Lepidoptera, Mammalia, 
                                                  Micropaleontology, Mineralogy, Mineralogy and Petrology, Mollusca,	
                                                  Odonata, Orthopteroidea, Paleobotany, Paleontology, Paleontology 
                                                  Invertebrates, Petrology, Pisces, Porifera, Protozoa, Remaining insects,
                                                  Tunicata, Vermes, miscellaneous		
================================================= ===========================================================================

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
               
          <base url>/specimen/search/?_search=male&_maxResults=20
   * - _offset
     - | • _offset instructs NBA to start filling first response from search result no = offset value + 1
       | • default NBA setting offset: 0 (for requests without _offset parameter)
       | • example: request results in a list with search result in which first document is search result no 21

       .. code:: html

          <base url>/specimen/search/?_search=allotype&_offset=20. 

Sorting parameters

.. list-table:: 
   :widths: 15 100
   :header-rows: 1

   * - Name
     - Description
   * - _sort
     - | • _sort instructs NBA to return responses sorted on a single specified indexed field included in specimen documents          
       | • default NBA setting sort: _score (for requests without _score parameter)
       | • remarks: _sort parameter can be used for all fields in a specimen document. Sort parameter values should be fieldpaths, e.g. gatheringEvent.locality
       | • example: request results in list sorted on unitID (sortDirection is default Ascending) 
                   
       .. code:: html

          <base url>/specimen/search/?typeStatus=holotype&_sort=unitID

   * - _sortDirection
     - | • _sortDirection instructs NBA on sorting direction, i.e. either descending (DESC) or ascending (ASC)
       | • default NBA setting sortDirection: ASC (for requests without _sortDirection parameter)
       | • example: request results in list sorted on unitID and sortDirection is descending

       .. code:: html

          <base url>/specimen/search/?typeStatus=holotype&_sort=unitID&_sortDirection=DESC

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
                  
          <base url>/specimen/search/?typeStatus=holotype&unitID=RMNH.AVES.110000&_andOr=OR

.. _specimen response section:

Responses
---------
basic response structure
````````````````````````
The basic structure of the responses can be viewed in the subsequent example section. 

.. _specimen examples section:

Examples
--------

.. _free text specimen search examples section:

1. Free text search
```````````````````
Search for RMNH.AVES.110000 in CRS in any specimen document
  
.. code:: html
  
   http://api.biodiversitydata.nl/v0/specimen/search/?_search=RMNH.AVES.110000

Search for syntype in any specimen document

.. code:: html
  
   http://api.biodiversitydata.nl/v0/specimen/search/?_search=syntype

Search for juvenile in any specimen document

.. code:: html
  
   http://api.biodiversitydata.nl/v0/specimen/search/?_search=juvenile

Search for mees in any specimen document

.. code:: html
  
   http://api.biodiversitydata.nl/v0/specimen/search/?_search=mees

.. _indexed field specimen search examples section:

2. Indexed field search
```````````````````````
Search for key:value pair unitID=WAG.1500001 in CRS in any specimen document
   
.. code:: html
  
   http://api.biodiversitydata.nl/v0/specimen/search/?unitID=WAG.1500001

Search for key:value pair sex=male in any specimen document

.. code:: html
  
   http://api.biodiversitydata.nl/v0/specimen/search/?sex=male

Search for key:value pair collectorsFieldNumber=add a fieldnumber from a Brahms specimen

.. code:: html
   
   http://api.biodiversitydata.nl/v0/specimen/search/?collectorsFieldNumber=[Brahms fieldnumber]

Search for key:value pair sourceSystem=Naturalis - Zoology and Geology catalogues

.. code:: html
   
   http://api.biodiversitydata.nl/v0/specimen/search/?sourceSystem=Naturalis - Zoology and Geology catalogues

Search for key:value pair collectionType=Aves

.. code:: html
   
   http://api.biodiversitydata.nl/v0/specimen/search/?collectionType=Aves
   
.. _Specimen-name-search:

2.SPECIMEN-NAME SEARCH
======================

Description
-----------
This combined direct and indirect search service returns SPECIMEN occurrence documents. It comes in two search varieties, i.e. 1. Free text search, and 2. Indexed field search. In the responses it combines the outcomes of two document search processes, a. direct search on specimen occurrence documents, and, b. specimen occurrence document search based on the outcome of the name-resolution process (indirect search). This preceding process is executed on taxonomic data from all available taxonomic data sources.

Both search types execute searches though specimen occurrence data harvested from - currently - two voluminous, Naturalis data sources, i.e. a. CRS (Collection Registration System) for zoological and geological specimen, and b. Brahms for botanical specimen. It searches a `list of indexed specimen document fields for specimen name search`_ and returns multilingual specimen documents in JSON responses. The list of searchable fields for this service contains only specimen taxonomic fields where-as a search on specimen not taxonomic fields can be done with the NBA service Specimen-search_.

.. _specimen name request section:

Requests
--------
url
```
The basic request url for free text search is:

.. code:: html
  
   <base url>/specimen/name-search/?_search=[term], e.g. http://api.biodiversitydata.nl/v0/specimen/name-search/?_search=Larus

The basic request url for indexed field search is:

.. code:: html
  
   <base url>/specimen/name-search/?indexedField1=[term]&indexedField2, e.g. http://api.biodiversitydata.nl/v0/specimen/name-search/?typeStatus=holotype

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
 
          <base url>/specimen/name-search/?_geoshape=decoded lat. and long coordinates of Jordan

indexed field name(s) in an url
```````````````````````````````
A specimen document incorporates an extensive set of fields. A subset of this set is indexed and therefore searchable. Stating a field name in an indexed field search request can be done by using either,

a. a field path, e.g. <base url>/specimen/name-search/?genusOrMonomial=Abies, or
b. a field alias, e.g. <base url>/specimen/name-search/?genus=Abies

.. _list of indexed specimen document fields for specimen name search:

===================================================== ============================================ =====================
Indexed field                                         Aliasses                                     Single term handling
===================================================== ============================================ =====================
defaultClassification.kingdom                         kingdom                                      exact match
defaultClassification.phylum                          phylum                                       exact match
defaultClassification.className                       class, className                             exact match
defaultClassification.order                           order                                        exact match
defaultClassification.family                          family                                       exact match
defaultClassification.genus                           genus, genusOrMonomial                       exact match
defaultClassification.subgenus                        subgenus                                     exact match
defaultClassification.specificEpithet                 species, speciesEpithet, specificEpithet     exact match
defaultClassification.infraspecificEpithet            infraspecificEpithet, subpspecies            exact match
gatheringEvent.gatheringAgents.fullName               collector, gatheringAgent                    exact match
gatheringEvent.dateTimeBegin                          collectingStartDate                          exact match
identifications.scientificName.genusOrMonomial        genus, genusOrMonomial                       exact match
identifications.scientificName.subgenus               subgenus                                     exact match
identifications.scientificName.specificEpithet        species, speciesEpithet, specificEpithet     exact match
identifications.scientificName.infraspecificEpithet   infraspecificEpithet, subpspecies            exact match
identifications.vernacularNames.name                  commonName, vernacularName                   \*term*\  match
systemClassification.name                             not applicable                               exact match
_geoshape (= geo search parameter)                    not applicable                               in geoshape match
===================================================== ============================================ =====================

Some searchable fields have a predefined set of search values.

================================================= ==================================================================
Indexed field                                     Search values
================================================= ==================================================================
defaultClassification.kingdom                     Animalia, Archea, Bacteria, Chromista, Fungi, Plantae, Protozoa, 
                                                  Viruses          
================================================= ==================================================================

.. _process:

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
     - | • _maxResults instructs NBA to retrn maximum amount of search results per page
       | • default NBA setting maxResults: 10 (for requests without _maxResults parameter)
       | • example: request results in list of maximum 50 documents included.

       .. code:: html                 

          <base url>/specimen/name-search/?_search=bloem&_maxResults=50
   * - _offset
     - | • _offset instructs NBA to start filling first response from search result no = offset value + 1
       | • default NBA setting offset: 0 (for requests without _offset parameter)
       | • example: request results in list in which first document is search result no 21. 
                
       .. code:: html

          <base url>/specimen/name-search/?_search=paardenbloem&_offset=20

Sorting parameters

.. list-table:: 
   :widths: 15 100
   :header-rows: 1

   * - Name
     - Description
   * - _sort
     - | • _sort instructs NBA to return responses sorted on a single specified indexed field included in Specimen documents          
       | • default NBA setting sort: _score (for requests without _score parameter)
       | • remarks: _sort parameter can be used for all fields in a specimen document. Sort parameter values should be fieldpaths
       | • example: request results in list sorted on genus

       .. code:: html

          <base url>/specimen/name-search/?genus=Larus&_sort=identifications.scientificName.genusOrMonomial.

   * - _sortDirection
     - | • _sortDirection instructs NBA on sorting direction, i.e. either descending (DESC) or ascending (ASC)
       | • default NBA setting sortDirection: ASC (for requests without _sortDirection parameter)
       | • example: request results in list sorted on genus and with sort direction descending. 

       .. code:: html

          <base url>/specimen/name-search/?genus=Larus&_sort=..&_sortDirection=DESC

specific meta parameters for indexed field search
`````````````````````````````````````````````````
For indexed fields search specific search meta parameters are available.

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

          <base url>/specimen/name-search/?genus=Abies&species=alba&_andOr=OR

.. _specimen name response section:

Responses
---------
basic response structure
````````````````````````
The basic structure of the responses can be viewed in the subsequent example section. 

.. _specimen name examples section:

Examples
--------

.. _free text specimen name search examples section:

1. Free text search
```````````````````
Search with name resolution for Melicertus kerathurus in any specimen document
 
.. code:: html

   http://api.biodiversitydata.nl/v0/specimen/name-search/?_search=Melicertus kerathurus

Search with name resolution for koolmees in any specimen document
  
.. code:: html

   http://api.biodiversitydata.nl/v0/specimen/name-search/?_search=koolmees

Search with name resolution for vroedmeesterpad in any specimen document

.. code:: html

   http://api.biodiversitydata.nl/v0/specimen/name-search/?_search=vroedmeesterpad

Search with name resolution for mees in any specimen document

.. code:: html

   http://api.biodiversitydata.nl/v0/specimen/name-search/?_search=mees

Search with name resolution for paardenbloem in any specimen document
   
.. code:: html

   http://api.biodiversitydata.nl/v0/specimen/name-search/?_search=paardenbloem

Search with name resolution for Parus major in any specimen document

.. code:: html

   http://api.biodiversitydata.nl/v0/specimen/name-search/?_search=Parus major

.. _indexed field specimen name search examples section:

2. Indexed field search
````````````````````````
Search with name resolution for key:value pairs order=Decapoda, family=Dynomenidae and genus=Dynomene in any specimen document

.. code:: html 

   http://api.biodiversitydata.nl/v0/specimen/name-search/?order=Decapoda&family=Dynomenidae&genus=Dynomene

Search with name resolution for key:value pair vernacularName=koolmees in any specimen document
  
.. code:: html

   http://api.biodiversitydata.nl/v0/specimen/name-search/?vernacularName=koolmees

Search with name resolution for key:value pair vernacularName=paardenbloem in any specimen document
   
.. code:: html

   http://api.biodiversitydata.nl/v0/specimen/name-search/?vernacularName=paardenbloem

Search with name resolution for key:value pair vernacularName=bloem in any specimen document

.. code:: html

   http://api.biodiversitydata.nl/v0/specimen/name-search/?vernacularName=bloem

.. _Specimen-collection-download:

3.SPECIMEN COLLECTION SEARCH
============================

Description
-----------
This direct search service returns a DwCA file containing all available SPECIMEN occurrences of a specific Naturalis Collection, Currently this service serves a DwCA file for each member of this group of Naturalis collections. The collections are categorized by the science domain for which they were gathered: animal science or Zoology, plant science or Botany and earth science or Geology. 

The creation of DwCA files is done batchwise once a month. 

.. _list of Naturalis collections:

.. list-table:: 
   :widths: 100 100 100
   :header-rows: 1

   * - Botany
     - Geology
     - Zoology
   * - botany
     - cainozoic_mollusca
     - amphibia_and_reptilia
   * - 
     - micropaleontology
     - aves
   * - 
     - paleontology_invertebrates
     - cnidaria
   * - 
     - 
     - chelicerata_and_myriapoda
   * - 
     - 
     - collembola
   * - 
     - 
     - coleoptera
   * - 
     - 
     - crustacea
   * - 
     - 
     - diptera
   * - 
     - 
     - hymenoptera
   * - 
     - 
     - lepidoptera
   * - 
     - 
     - mammalia
   * - 
     - 
     - mollusca
   * - 
     - 
     - porifera
     
.. _specimen collection request section:

Requests
--------
url
```
The basic request url for specimen collection search is:

.. code:: html
 
   <base url>/specimen/search/dwca/?collection=[collection name], e.g. http:/api.biodiversitydata.nl/v0/specimen/search/dwca/?collection=mammalia

.. _specimen collection response section:

Responses
---------
basic response structure
````````````````````````
All DwCA zip files have a similar internal file structure and comply to multiple data standards.  

DwCA zip file features

.. list-table:: 
   :widths: 30 70 70
   :header-rows: 1

   * - Internal file
     - Description
     - Compliancy
   * - occurrence.txt file
     - | • Core data file with specimen occurrence data
       | • Required file in zip file
       | • csv text file, tab delimiter, use of stable identifier = occurrence id (= sourceSystem.Id) per row
     - | Occurrence file complies to
       | • Mandatory DwC terms standard as stated in the `Annex of this GBIF guideline`_
       | • `DwC terms guideliness`_
   * - eml.xml file
     - | • EML profile
       | • Required file in zip file
     - | EML profile complies to 
       | • `GBIF metadata profile`_. 
       | • Minimum set of five mandatory elements as mentiond in the appendix of this `GBIF guideline`_. 
   * - meta.xml file
     - | • Descriptor metafile
       | • Required file in zip file
     - | Descriptor metafile complies to
       | • `GBIF reference guide to the XML descriptor file`_ 
       | • `DwC text guideliness`_ 
   * - extension file
     - | • Extension files are *not* included in this DwCA zip file
       | • Optional file in zip file
     -     

.. _GBIF reference guide to the XML descriptor file: http://www.gbif.org/resource/80639

.. _Annex of this GBIF guideline: http://www.gbif.org/resource/80636

.. _GBIF metadata profile: http://rs.gbif.org/schema/eml-gbif-profile/1.0.2/eml-gbif-profile.xsd

.. _GBIF guideline: http://www.gbif.org/resource/80641

.. _DwC text guideliness: http://rs.tdwg.org/dwc/terms/guides/text/index.htm

.. _DwC terms guideliness: http://rs.tdwg.org/dwc/terms/

Naturalis has validated the DwCA files by the use of the GBIF tool `DwCA Validator`_.

.. _DwCA Validator: http://tools.gbif.org/dwca-validator/

occurrence.txt file
```````````````````
All collections have a similar occurrence.txt file structure, i.e. similar list of fields. Because each science domain has a (slightly) different preference for relevant DwC occurrence values, Naturalis tries to populate DwC fields in occurrence.txt files as mentioned in the list below. 

.. warning:: ..tries to populate, because the data sources do not always supply sufficient data!

.. list-table:: 
   :widths: 70 50 50 50
   :header-rows: 1

   * - DwC term in occurrence.txt
     - Botany collection
     - Geology collection
     - Zoology collection
   * - basisOfRecord
     - Yes
     - Yes
     - Yes
   * - catalogNumber
     - Yes
     - Yes
     - Yes
   * - className
     - Yes
     - No
     - Yes
   * - collectionCode
     - Yes
     - Yes
     - Yes
   * - continent
     - Yes
     - Yes
     - Yes
   * - country
     - Yes
     - Yes
     - Yes
   * - dateIdentified
     - Yes
     - Yes
     - Yes
   * - decimalLatitude
     - Yes
     - Yes
     - Yes
   * - decimalLongitude
     - Yes
     - Yes
     - Yes
   * - eventDate
     - Yes
     - Yes
     - Yes
   * - family
     - Yes
     - No
     - No
   * - genus
     - Yes
     - Yes
     - Yes
   * - geodeticDatum
     - No
     - Yes
     - Yes
   * - habitat
     - Yes
     - Yes
     - Yes
   * - higherClassification
     - Yes
     - No
     - No
   * - identifiedBy
     - Yes
     - Yes
     - Yes
   * - individualCount
     - No
     - Yes
     - Yes
   * - informationWithHeld
     - Yes
     - Yes
     - Yes
   * - infraspecificEpithet
     - Yes
     - Yes
     - Yes
   * - island
     - No
     - No
     - No
   * - institutionCode
     - Yes
     - Yes
     - Yes
   * - kingdom
     - Yes
     - Yes
     - Yes
   * - lifeStage
     - No
     - Yes
     - Yes
   * - locality
     - Yes
     - Yes
     - Yes
   * - maximumElevationInMeters
     - Yes
     - No
     - No
   * - minimumElevationInMeters
     - Yes
     - No
     - No
   * - nomenClaturalCode
     - Yes
     - Yes
     - Yes
   * - occurrenceID
     - Yes
     - Yes
     - Yes
   * - order
     - Yes
     - No
     - No
   * - phylum
     - Yes
     - No
     - No
   * - preparations
     - No
     - Yes
     - Yes
   * - recordedBy
     - Yes
     - Yes
     - Yes
   * - scientificName
     - Yes
     - Yes
     - Yes
   * - scientificNameAuthorship
     - Yes
     - Yes
     - Yes
   * - sex
     - Yes
     - Yes
     - Yes
   * - specificEpithet
     - Yes
     - Yes
     - Yes
   * - stateProvince
     - Yes
     - Yes
     - Yes
   * - subgenus
     - Yes
     - Yes
     - Yes
   * - taxonRank
     - Yes
     - No
     - No
   * - taxonRemarks
     - Yes
     - No
     - No
   * - typeStatus
     - Yes
     - Yes
     - Yes
   * - verbatimCoordinates
     - Yes
     - Yes
     - Yes
   * - verbatimDepth
     - No
     - Yes
     - Yes
   * - verbatimElevation
     - Yes
     - Yes
     - Yes
   * - verbatimEventDate
     - Yes
     - Yes
     - Yes
   * - verbatimTaxonRank
     - Yes
     - Yes
     - Yes

Details on the DwC terms used can be found in the `BIS TDWG official DwC terms list`_.

.. _BIS TDWG official DwC terms list: http://tdwg.github.io/dwc/terms/

.. _specimen collection examples section:

Examples
--------

Download all available specimen occurrences in Naturalis Mammalia collection (part of Zoology science domain)
  
.. code:: html
  
   http://api.biodiversitydata.nl/v0/specimen/search/dwca/?collection=mammalia

Download all available specimen occurrences in Naturalis Botany collection (Botany domain as a whole)

.. code:: html
  
   http://api.biodiversitydata.nl/v0/specimen/search/dwca/?collection=botany

Download all available specimen occurrences in Naturalis Cainozoic mollusca collection (part of Geology domain)

.. code:: html
  
   http://api.biodiversitydata.nl/v0/specimen/search/dwca/?collection=cainozoic_mollusca
