Introduction
============

This document gives an overview of the available search field per service

1. TAXON search
---------------

================================================= =================================================== ====================
Field name                                        NBA aliasses                                        Term handling
================================================= =================================================== ====================
acceptedName.genusOrMonomial                      genus, genusOrMonomial                              *term* match
acceptedName.subgenus                             subgenus                                            exact match
acceptedName.specificEpithet                      species, speciesEpithet, specificEpithet            exact match
acceptedName.infraspecificEpithet                 infraspecificEpithet, subspecies, subspeciesEpithet exact match
acceptedName.experts.fullName                     expert                                              exact match
acceptedName.experts.organization.name            expertOrganisation                                  exact match
acceptedName.taxonomicStatus                      taxonomicStatus                                     exaxt match
vernacularNames.name                              commonName, vernacularName                          *term* match
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
Field name                                        NBA aliasses                                        Term handling
================================================= =================================================== ====================
unitID                                            registrationNumber, unitID                          exact match                                      
typeStatus                                        typeStatus                                          exact match
phaseOrStage                                      phaseOrStage                                        exact match
sex                                               sex                                                 exact match
collectorsFieldNumber                             collectorsFieldNumber                               exact match
gatheringEvent.localityText                       locality, localityText                              *term* match 
gatheringEvent.gatheringAgents.fullName           collector, gatheringAgent                           exact match 
gatheringEvent.gatheringAgents.organization       collector, gatheringAgent                           exact match
gatheringEvent.dateTimeBegin                      collectingStartDate                                 exact match
_geoshape (= geo search parameter)                not applicable                                      in geoshape match
================================================= =================================================== ====================

3. SPECIMEN-NAME search
-----------------------

===================================================== ============================================ ====================
Field name                                            NBA aliasses                                 Term handling
===================================================== ============================================ ====================
defaultClassification.kingdom                         kingdom                                      exact match                         
defaultClassification.phylum                          phylum                                       exact match
defaultClassification.className                       class, className                             exact match
defaultClassification.order                           order                                        exact match
defaultClassification.family                          family                                       exact match
defaultClassification.genus                           genus, genusOrMonomial                       *term* match
defaultClassification.subgenus                        subgenus                                     exact match 
defaultClassification.specificEpithet                 species, speciesEpither, specificEpithet     exact match
defaultClassification.infraspecificEpithet            infraspecificEpithet, subpspecies            exact match
systemClassification.name                             not applicable                               exact match
gatheringEvent.gatheringAgents.fullName               collector, gatheringAgent                    exact match
gatheringEvent.dateTimeBegin                          collectingStartDate                          exact match
identifications.scientificName.genusOrMonomial        genus, genusOrMonomial                       *term* match
identifications.scientificName.subgenus               subgenus                                     exact match
identifications.scientificName.specificEpithet        species, speciesEpither, specificEpithet     exact match
identifications.scientificName.infraspecificEpithet   infraspecificEpithet, subpspecies            exact match
identifications.vernacularNames.name                  commonName, vernacularName                   *term* match
_geoshape (= geo search parameter)                    not applicable                               in geoshape match
===================================================== ============================================ ====================

4. MULTIMEDIA SEARCH
-----------------------

========================================================== =============================================== =============
Field name                                                 NBA aliasses                                    Term handling
========================================================== =============================================== =============
unitID                                                     registrationNumber, unitID                      exact match
sexes                                                      sex                                             exact match
specimenTypeStatus                                         typeStatus                                      exact match
phasesOrStages                                             phaseOrStage                                    exact match
identifications.vernacularNames.name                       commonName, vernacularName                      *term* match
identifications.defaultClassification.kingdom              kingdom                                         exact match
identifications.defaultClassification.phylum               phylum                                          exact match
identifications.defaultClassification.className            class, className                                exact match
identifications.defaultClassification.order                order                                           exact match
identifications.defaultClassification.family               family                                          exact match
identifications.defaultClassification.genusOrMonomial      genus, genusOrMonomial                          *term* match
identifications.defaultClassification.subgenus             subgenus                                        exact match
identifications.defaultClassification.specificEpithet      species, speciesEpithet, specificEpithet        exact match
identifications.defaultClassification.infraspecificEpithet infraspecificEpithet, subspecies                exact match
identifications.scientificName.genusOrMonomial             genus, genusOrMonomial                          *term* match 
identifications.scientificName.subgenus                    subgenus                                        exact match
identifications.scientificName.specificEpithet             species, speciesEpithet, specificEpithet        exact match
identifications.scientificName.infraspecificEpithet        infraspecificEpithet, subspecies                exact match
_geoshape (= geo search parameter)                         not applicable                                  in geoshape match
========================================================== =============================================== =============
