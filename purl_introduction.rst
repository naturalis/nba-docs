-------------------------
Introduction
-------------------------

With the specimen PURL service Naturalis introduces a new type of webservice in the Naturalis' webservice portfolio. 
The PURL service is primarly intended for computers to communicate with other computers.
Each PURL is a kind of Persistent Identifier that relies on HTTP.

The specimen PURL service is a public service.

A specimen PURL example:

.. code:: html

  http://data.biodiversitydata.nl/naturalis/specimen/RMNH.INS.389961

PURL description 1
   PURLs (Persistent Uniform Resource Locators) are Web addresses that act as permanent identifiers in the face of a 
   dynamic and changing Web infrastructure. Instead of resolving directly to Web resources, PURLs provide a level of 
   indirection that allows the underlying Web addresses of resources to change over time without negatively affecting 
   systems that depend on them. This capability provides continuity of references to network resources that may migrate 
   from machine to machine for business, social or technical reasons. 
   
   Source: `wiki`_

PURL description 2
   PURL identifiers are based on URIs and use the HTTP redirect mechanism to avoid broken links.
    a. e.g., http://purl.oclc.org/example/specimen/12921 and http://purl.org/dc/terms/contributor
    b. web-based identifier using standard HTTP and HTTP redirect. Can be resolved through use of a common PURL resolver.
    c. promoted by the OCLC (Online Computer Library Center) [OCLC]
    d. independent generation is enabled by the use of domain names.
    e. may not be opaque due to the use of domain names, context names and sometimes descriptive object identifiers.  
    f. authority, context and object identifier components can be defined using the path portion of the PURL (as shown in the example above).
   
  Source: `A Beginner's Guide to Persistent Identifiers`_
  
With the publication of the specimen PURL service Naturalis takes a first step in it's planned contribution to 
the need of persistent identifiers for Life Sciences. Naturalis has decided to use PURL as a persistent identifier mechanism because of their ease-of-use, relative implementation-ease and strong technical community support. 

Every Naturalis specimen PURL refers to a physical object in the our botanical, geological and zoological collections. Because Naturalis can not (yet) serve a physicial object via the http protocol, Naturalis will instead serve one or more digital representations of the requested physical object, e.g. a specimen document in text/html format.  

The specimen PURL service returns each specific specimen document default as text/html. Each text/html document is default shown in `a detail page of the Naturalis Bioportal`_. 

Through 'http content negotiation'_ three other document content types can - depending on their availability - also be served, i.e. application/json, image/jpeg and video/mp4. Currently about 7,3 million Naturalis' specimens can be directly accessed through this PURL service.  

.. _wiki : https://en.wikipedia.org/wiki/Persistent_uniform_resource_locator

.. _A Beginner's Guide to Persistent Identifiers: http://www.gbif.org/resource/80575

.. _detail page of the Naturalis Bioportal : http://data.biodiversitydata.nl/naturalis/specimen/ZMA.MOLL.228360


The base url for the specimen PURL service is: 

.. code:: html

  http://data.biodiversitydata.nl/

For exploration or testing of the PURL service and/or NBA services we recommend using a command-line tool 
for transferring data like e.g. `curl`_ or in case a rest client browser plugin, e.g. the chrome rest client, in case
you want to work with a browser.
 
.. _curl : http://curl.haxx.se/

