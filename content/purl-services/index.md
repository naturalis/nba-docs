---
title: PURL services
weight: 90
---

## What is a PURL?
A *Persistent Uniform Resource locator* ([PURL](https://en.wikipedia.org/wiki/Persistent_uniform_resource_locator)) of an 
object is an URL that does not directly resolve to a web resource but to a HTTP link resolver 
which then, in turn, returns the actual web resource of the object. This uncouples the identifier of an object from its actual 
location (which may change), and thus ensures the continuity of object references. A prominent example for 
PURLs is the [Digital Object Identifier (DOI)](https://www.doi.org/) system which is (among other applications) commonly used for 
scholar web content. The DOI of a journal article, e.g. http://dx.doi.org/10.1016/S1535-6108(02)00133-2, acts as both, a permanent digital identifier, 
but it also is resolved to the actual location of the article in the web.

## Naturalis specimen PURLs
With the publication of specimen PURLs Naturalis takes a first step in it’s planned contribution to the need of persistent identifiers for 
Life Sciences. We decided to use PURL as a persistent identifier mechanism because of their ease-of-use, relative implementation-ease and strong 
technical community support. Every Naturalis specimen PURL refers to a physical object in the our botanical, geological and zoological 
collections. If a researcher refers to such an object in a scientific publication via its PURL, it is guaranteed that this reference will 
persist in the future, even if the location of the physical and data resource has changed. Specimen PURLs have the general form

`http://data.biodiversitydata.nl/{institution}/specimen/{unitID}`

where institution is the data owner institution, e.g. *Naturalis*. 

In data served by the NBA, each specimen record stores its PURL in the field `unitGUID`. By default, the PURL returns the 
corresponding site of the specimen in the BioPortal in format `text/html`. For instance, the PURL for an Anarosaurus specimen 

http://data.biodiversitydata.nl/naturalis/specimen/RGM.443858

resolves to 

http://bioportal.naturalis.nl/nba/result?nba_request=specimen%2Fget-specimen%2F%3FunitID%3DRGM.443858

## Content types
Specimens can have associated content such as videos or images. PURL resources that can have different formats are made 
available through *content negotiation*. This means that one and the same PURL can redirect to different locations based on 
the requested content type. The following content types are accessible from a PURL, accessible via the query parameter `__accept`:

* `text/html` is the default content type, e.g.  http://data.biodiversitydata.nl/naturalis/specimen/RGM.443858/?\_\_accept=text/html
* `image/jpeg` redirects to an image resource, if available, e.g. http://data.biodiversitydata.nl/naturalis/specimen/RGM.443858/?__accept=image/jpeg
* `video/mp4` redirects to a video resource, if available, e.g. http://data.biodiversitydata.nl/naturalis/specimen/RMNH.AVES.110091?\_\_accept=video/mp4
* `text/json` gives the JSON representation of the specimen, as served by the NBA, e.g http://data.biodiversitydata.nl/naturalis/specimen/RGM.443858/?\_\_accept=application/json

## Persistent identifier compliancy
With rapidly growing biodiversity data volumes, it becomes very important that collection objects or species occurrences can be 
unambiguously referenced. The Global Biodiversity Information Facility (GBIF) strongly encourages the use of persistent identifiers 
as stated in their [guide on persistent identifiers](https://www.gbif.org/document/80575/a-beginners-guide-to-persistent-identifiers). Below we list the
most important general characteristics herein and how PURLS issued by Naturalis apply to them:

* **A PID is globally unique:** Naturalis' PURL structure aims to guarantee global uniqueness for specimen records, by combining the 
data owner institution or organisation and specimen unitID  .

* **A PID exists indefinitely:** Naturalis aims to assure the permanent character of its PURLs.

* **A PID is unambigiously applied:** The specimen PURL service serves digital representations of physical 
specimens in our collection catalogues. Multiple content types per physical specimen can be requested. 
Specimen representations are being served based on their availability.

* **A PID is opaque:** Opacity suggests that identifiers should not contain any readable information. The reason is to prevent users to make 
assumptions on data content from the identifier. The Naturalis PURL service does not entirely comply to this rule, since the source or owner institute 
is part of the PURL and specimen unitIDs carry at least some information about the specimen object.

* **A PID is permantly assigned to an object:**  Naturalis aims to assure the permanent assignment to an object.

* **A PID is actionable:** Naturalis PURL specimen services are highly actionable as they resolve to data entries in the Bioportal for different content types.
* **A PID allows for universal cross linking of information:**  Cross linking through PIDs is not yet implemented in the specimen PURL service.
