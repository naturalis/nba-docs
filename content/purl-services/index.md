---
weight: 50
title: PURL services
---

# PURL services

## What is a PURL?
A *Persistent Uniform Resource locator* (PURL) of an object is an URL that does not directly resolve to a web resource but to a link resolver 
which then, in turn, returns the actual web resource of the object. This uncouples the identifier of an object from its actual 
location (which may change), and thus ensures the continuity of object references.

## Specimen PURLs
With the publication of specimen PURLs Naturalis takes a first step in it’s planned contribution to the need of persistent identifiers for 
Life Sciences. We decided to use PURL as a persistent identifier mechanism because of their ease-of-use, relative implementation-ease and strong 
technical community support. Every Naturalis specimen PURL refers to a physical object in the our botanical, geological and zoological 
collections. If a researcher refers to such an object in a scientific publication via its PURL, it is guaranteed that this reference will 
persist in the future, even if the location of the physical and data resource has changed. Specimen PURLs have the general form

http://data.biodiversitydata.nl/naturalis/specimen/{unitID}

Each specimen document stores its PURL in the field `unitGUID`. By default, the PURL returns the corresponding site of the specimen in the BioPortal 
in format `text/html`. For instance, the PURL for an Anarosaurus specimen 

http://data.biodiversitydata.nl/naturalis/specimen/RGM.443858

resolves to 

http://bioportal.naturalis.nl/nba/result?nba_request=specimen%2Fget-specimen%2F%3FunitID%3DRGM.443858

## Content types
Specimen records can have associated content such as videos or images. PURL resources that can have different formats are made 
available through *content negotiation*. This means that one and the same PURL can redirect to different locations based on 
the requested content type. The following content types are accessible from a PURL, accessible via the query parameter `__accept`:

* `text/html` is the default content type, for example: http://data.biodiversitydata.nl/naturalis/specimen/RGM.443858/?\_\_accept=text/html
* `image/jpeg` redirects to an image resource, if available, for example: http://data.biodiversitydata.nl/naturalis/specimen/RGM.443858/?__accept=image/jpeg
* `video/mp4` redirects to a video resource, if available, for example: http://data.biodiversitydata.nl/naturalis/specimen/RMNH.AVES.110091?\_\_accept=video/mp4
* `text/json` gives the JSON representation of the specimen, as served by the NBA, for example: http://data.biodiversitydata.nl/naturalis/specimen/RGM.443858/?__accept=application/json
