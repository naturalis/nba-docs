=================================
Searchable fields per NBA service
=================================

This document lists an overview of the search fields per NBA service and per search field the available field aliasses and the handling of search terms (term handling), e.g. Parus or Netherlands, by the NBA.

Term handling is executed for both single terms, e.g. Parus of Netherlands, and compound terms, e.g. Parus major or Great Brittain.

Note!
Term handling on compound terms, e.g. Parus major, is more or less similar to term handling on single terms, e.g. Abies. NBA (an Elastic search implementation) breaks compound terms into parts: individual term components. The term handling on components terms is equal to the term handling on the single terms.

 A Taxon search example
  Request = http://10.42.1.177/v0/taxon/search/?_search=Parus major. The response contains taxon documents with hits on the values Parus and major and sometimes both because of a scientific name with the value Parus major. The amount of hits on a document determines the ranking or score of the taxon document in the response. The taxon Parus major has a high chance of ending up on top of the score list because of it high number of hits, i.e. hits on full scientific name, genus and species.

1. TAXON search
---------------

================================================= =================================================== ====================
Field path                                        NBA aliasses                                        Term handling
================================================= =================================================== ====================
acceptedName.genusOrMonomial                      genus, genusOrMonomial                              exact match
acceptedName.subgenus                             subgenus                                            exact match
acceptedName.specificEpithet                      species, speciesEpithet, specificEpithet            exact match
acceptedName.infraspecificEpithet                 infraspecificEpithet, subspecies, subspeciesEpithet exact match
acceptedName.experts.fullName                     expert                                              exact match
acceptedName.experts.organization.name            expertOrganisation                                  exact match
acceptedName.taxonomicStatus                      taxonomicStatus                                     exaxt match
vernacularNames.name                              commonName, vernacularName                          \*term*\ match
vernacularNames.experts.fullName                  expert                                              exact match
vernacularNames.experts.organization.name         expertOrganisation                                  exact match
synonyms.genusOrMonomial                          genus, genusOrMonomial                              exact match
synonyms.subgenus                                 subgenus                                            exact match
synonyms.specificEpithet                          species, specificEpithet, speciesEpithet            exact match
synonyms.infraspecificEpithet                     infraspecificEpithet, subspecies, subspeciesEpithet exact match
synonyms.expert.fullName                          expert                                              exact match
synonyms.expert.organization.name                 expertOrganisation                                  exact match
synonyms.taxonomicStatus                          taxonomicStatus                                     exaxt match
defaultClassification.kingdom                     kingdom                                             exact match
defaultClassification.phylum                      phylum                                              exact match
defaultClassification.className                   class, className                                    exact match
defaultClassification.order                       order                                               exact match
defaultClassification.family                      family                                              exact match
defaultClassification.genus                       genus, genusOrMonomial                              exact match
defaultClassification.subgenus                    subgenus                                            exaxt match
defaultClassification.specificEpithet             species, specificEpithet, speciesEpithet            exact match
defaultClassification.infraspecificEpithet        infraspecificEpithet, subspecies, subspeciesEpithet exact match
systemClassification.name                         not applicable                                      exact match
experts.fullName                                  expert                                              exact match
================================================= =================================================== ====================

2. SPECIMEN search
------------------

================================================= =================================================== ====================
Field path                                        NBA aliasses                                        Term handling
================================================= =================================================== ====================
unitID                                            registrationNumber, unitID                          exact match
typeStatus                                        typeStatus                                          exact match
phaseOrStage                                      phaseOrStage                                        exact match
sex                                               sex                                                 exact match
collectorsFieldNumber                             collectorsFieldNumber                               exact match
gatheringEvent.localityText                       locality, localityText                              \*term*\  match
gatheringEvent.gatheringAgents.fullName           collector, gatheringAgent                           exact match
gatheringEvent.gatheringAgents.organization       collector, gatheringAgent                           exact match
gatheringEvent.dateTimeBegin                      collectingStartDate                                 exact match
_geoshape (= geo search parameter)                not applicable                                      in geoshape match
================================================= =================================================== ====================

3. SPECIMEN-NAME search
-----------------------

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
defaultClassification.specificEpithet                 species, speciesEpither, specificEpithet     exact match
defaultClassification.infraspecificEpithet            infraspecificEpithet, subpspecies            exact match
systemClassification.name                             not applicable                               exact match
gatheringEvent.gatheringAgents.fullName               collector, gatheringAgent                    exact match
gatheringEvent.dateTimeBegin                          collectingStartDate                          exact match
identifications.scientificName.genusOrMonomial        genus, genusOrMonomial                       \*term*\  match
identifications.scientificName.subgenus               subgenus                                     exact match
identifications.scientificName.specificEpithet        species, speciesEpither, specificEpithet     exact match
identifications.scientificName.infraspecificEpithet   infraspecificEpithet, subpspecies            exact match
identifications.vernacularNames.name                  commonName, vernacularName                   \*term*\  match
_geoshape (= geo search parameter)                    not applicable                               in geoshape match
===================================================== ============================================ ====================

4. MULTIMEDIA search
-----------------------

========================================================== =============================================== =============
Field path                                                 NBA aliasses                                    Term handling
========================================================== =============================================== =============
unitID                                                     registrationNumber, unitID                      exact match
sexes                                                      sex                                             exact match
specimenTypeStatus                                         typeStatus                                      exact match
phasesOrStages                                             phaseOrStage                                    exact match
identifications.vernacularNames.name                       commonName, vernacularName                      \*term*\  match
identifications.defaultClassification.kingdom              kingdom                                         exact match
identifications.defaultClassification.phylum               phylum                                          exact match
identifications.defaultClassification.className            class, className                                exact match
identifications.defaultClassification.order                order                                           exact match
identifications.defaultClassification.family               family                                          exact match
identifications.defaultClassification.genusOrMonomial      genus, genusOrMonomial                          \*term*\  match
identifications.defaultClassification.subgenus             subgenus                                        exact match
identifications.defaultClassification.specificEpithet      species, speciesEpithet, specificEpithet        exact match
identifications.defaultClassification.infraspecificEpithet infraspecificEpithet, subspecies                exact match
identifications.scientificName.genusOrMonomial             genus, genusOrMonomial                          exact match
identifications.scientificName.subgenus                    subgenus                                        exact match
identifications.scientificName.specificEpithet             species, speciesEpithet, specificEpithet        exact match
identifications.scientificName.infraspecificEpithet        infraspecificEpithet, subspecies                exact match
_geoshape (= geo search parameter)                         not applicable                                  in geoshape match
========================================================== =============================================== =============
