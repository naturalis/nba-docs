============================================================
Searchable fields and specific search values per NBA service
============================================================

-------------------
Document management
-------------------

.. list-table:: 
   :widths: 10 25
   :header-rows: 0
   
   * - Author
     - Naturalis ICT sector, Software Development department
   * - Version
     - c1.3.
   * - Publication date
     - 30-10-2015
   * - Content
     - description of searchable fields per NBA service in NBA API version 0.14.4.

------------
Introduction
------------
This document lists an overview of the search fields per NBA service and per search field the available field aliasses and the handling of search terms (term handling), e.g. Parus or Netherlands, by the NBA.

Term handling is executed for both single terms, e.g. Parus of Netherlands, and compound terms, e.g. Parus major or Great Brittain.

Note!
Term handling on compound terms, e.g. Parus major, is more or less similar to term handling on single terms, e.g. Abies. NBA (an Elastic search implementation) breaks compound terms into parts: individual term components. The term handling on components terms is equal to the term handling on the single terms.

A Taxon search example
Request 
 
.. code:: html
 
  http://api.biodiversitydata.nl/v0/taxon/search/?_search=Parus major. 
 
The response contains taxon documents with hits on the values Parus and major and sometimes both because of a scientific name with the value Parus major. The amount of hits on a document determines the ranking or score of the taxon document in the response. The taxon Parus major has a high chance of ending up on top of the score list because of it high number of hits, i.e. hits on full scientific name, genus and species.

---------------
1. TAXON search
---------------

Searchable fields
=================

================================================= =================================================== ====================
Field path                                        NBA aliasses                                        Term handling
================================================= =================================================== ====================
sourceSystem.name                                 sourceSystem		                                  exact match	
acceptedName.genusOrMonomial                      genus, genusOrMonomial                              exact match
acceptedName.subgenus                             subgenus                                            exact match
acceptedName.specificEpithet                      species, specificEpithet                            exact match
acceptedName.infraspecificEpithet                 infraspecificEpithet, subspecies                    exact match
acceptedName.taxonomicStatus                      taxonomicStatus                                     exaxt match
defaultClassification.kingdom                     kingdom                                             exact match
defaultClassification.phylum                      phylum                                              exact match
defaultClassification.className                   class, className                                    exact match
defaultClassification.order                       order                                               exact match
defaultClassification.family                      family                                              exact match
defaultClassification.genus                       genus, genusOrMonomial                              exact match
defaultClassification.subgenus                    subgenus                                            exaxt match
defaultClassification.specificEpithet             species, specificEpithet                            exact match
defaultClassification.infraspecificEpithet        infraspecificEpithet, subspecies                    exact match
experts.fullName                                  expert                                              exact match
experts.organization.name                         expertOrganisation                                  exact match
synonyms.genusOrMonomial                          genus, genusOrMonomial                              exact match
synonyms.subgenus                                 subgenus                                            exact match
synonyms.specificEpithet                          species, specificEpithet                            exact match
synonyms.infraspecificEpithet                     infraspecificEpithet, subspecies                    exact match
synonyms.experts.fullName                         expert                                              exact match
synonyms.experts.organization.name                expertOrganisation                                  exact match
synonyms.taxonomicStatus                          taxonomicStatus                                     exaxt match
systemClassification.name                         not applicable                                      exact match
vernacularNames.name                              commonName, vernacularName                          \*term*\ match
vernacularNames.experts.fullName                  expert                                              exact match
vernacularNames.experts.organization.name         expertOrganisation                                  exact match
================================================= =================================================== ====================

Search values per field
=======================

================================================= ========================================================================= 
Field path                                        Search values
================================================= ========================================================================= 
sourceSystem.name                                 Naturalis - Nederlands Soortenregister, Species 2000 - Catalogue of Life
defaultClassification.kingdom                     Animalia, Archea, Bacteria, Chromista, Fungi, Plantae, Protozoa, Viruses                                                  
================================================= =========================================================================
 
------------------
2. SPECIMEN search
------------------

Searchable fields
=================

================================================= =================================================== ====================
Field path                                        NBA aliasses                                        Term handling
================================================= =================================================== ====================
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
================================================= =================================================== ====================

Search values per field
=======================

================================================= ===========================================================================
Field path                                        Search values
================================================= =========================================================================== 
sourceSystem.name                                 Naturalis - Zoology and Geology catalogues, Naturalis - Botany catalogues
typeStatus                                        allotype, epitype, holotype, isoepitype, isolectortype, isoneotype,
                                                  isosyntype, isotype, lectotype, neotype, paralectotype, paratype,
												  syntype, topotype
phaseOrStage                                      adult, egg, embryo, immature, juvenile, larva, nymph, subadult
sex                                               female, hermaphrodite, male, mixed
collectionType                                    Amphibia and Reptilia, Arts, Aves, Brachiopoda, Bryozoa, Botany, 
                                                  Cainozoic Mollusca, Chelicerata and Myriapoda, Cnidaria, Coleoptera, 
												  Collembola, Crustacea, Diptera, Echinodermata, Entomology, Foraminifera, 
												  Hemiptera, Hymenoptera, Invertebrates, Lepidoptera, Mammalia, 
												  Micropaleontology, Mineralogy, Mineralogy and Petrology, Mollusca,
												  Odonata, Orthopteroidea, Paleobotany, Paleontology, Paleontology 
												  Invertebrates, Petrology, Pisces, Porifera, Protozoa, 
												  Remaining insects, Tunicata, Vermes, miscellaneous
================================================= ===========================================================================

-----------------------
3. SPECIMEN-NAME search
-----------------------

Searchable fields
=================

===================================================== ============================================ ====================
Field path                                            NBA aliasses                                 Term handling
===================================================== ============================================ ====================
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
===================================================== ============================================ ====================

Search values per field
=======================

================================================= ========================================================================= 
Field path                                        Search values
================================================= ========================================================================= 
defaultClassification.kingdom                     Animalia, Archea, Bacteria, Chromista, Fungi, Plantae, Protozoa, Viruses                                                  
================================================= =========================================================================

--------------------
4. MULTIMEDIA search
--------------------

Searchable fields
=================

========================================================== =============================================== =============
Field path                                                 NBA aliasses                                    Term handling
========================================================== =============================================== =============
unitID                                                     registrationNumber, unitID                      exact match
sourceSystem.name                                          sourceSystem		                               exact match	
sexes                                                      sex                                             exact match
specimenTypeStatus                                         typeStatus                                      exact match
phasesOrStages                                             phaseOrStage                                    exact match
collectionType                                             not applicable                                  exact match								
identifications.vernacularNames.name                       commonName, vernacularName                      \*term*\  match
identifications.defaultClassification.kingdom              kingdom                                         exact match
identifications.defaultClassification.phylum               phylum                                          exact match
identifications.defaultClassification.className            class, className                                exact match
identifications.defaultClassification.order                order                                           exact match
identifications.defaultClassification.family               family                                          exact match
identifications.defaultClassification.genusOrMonomial      genus, genusOrMonomial                          \*term*\  match
identifications.defaultClassification.subgenus             subgenus                                        exact match
identifications.defaultClassification.specificEpithet      species, specificEpithet                        exact match
identifications.defaultClassification.infraspecificEpithet infraspecificEpithet, subspecies                exact match
identifications.scientificName.genusOrMonomial             genus, genusOrMonomial                          exact match
identifications.scientificName.subgenus                    subgenus                                        exact match
identifications.scientificName.specificEpithet             species, specificEpithet                        exact match
identifications.scientificName.infraspecificEpithet        infraspecificEpithet, subspecies                exact match
_geoshape (= geo search parameter)                         not applicable                                  in geoshape match
========================================================== =============================================== =============

Search values per field
=======================

================================================= ==========================================================================
Field path                                        Search values
================================================= ========================================================================== 
sourceSystem.name                                 Naturalis - Zoology and Geology catalogues, Naturalis - Botany catalogues,
                                                  Naturalis - Nederlands Soortenregister
typeStatus                                        allotype, epitype, holotype, isoepitype, isolectortype, isoneotype,
                                                  isosyntype, isotype, lectotype, neotype, paralectotype, paratype,								  syntype, topotype
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
