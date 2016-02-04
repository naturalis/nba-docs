-------------------------------------------
Persistent identifier compliancy
-------------------------------------------
As said, each PURL is a kind of Persistent Identifier that relies on HTTP.
But how does this service comply to the general characteristics of a Persistent Identifier mentioned in 
`A Beginner's Guide to Persistent Identifiers`_ published by GBIF_? 
We've tried to 'score' the service and/or comment on it's feature.

**A PID is globally unique**
Naturalis beliefs the chosen url structure guarantees globally uniqueness for specimens.
Especially the combination of the data owner institution or organisation name, and, a 
unitID which abides to international bio information standards is key in guaranteeing the uniqueness.

**A PID exists indefinitely**
Naturalis will try to assure the permanent character of its PURLs.

**A PID is unambigious applied**
The specimen PURL service serves digital representations of physical specimens in our collection catalogues. 
Multiple content types per physical specimen can be requested. 
Specimen representations are being served based on their availability. 

**A PID is opace**
One of the most important qualities of a good Persistent identifier is opacity. 
That is, the identifier itself should not contain any readable information. 
Underlying argument is that Persistent identifiers are intended for computers to communicate with other computers. 
Obviously the Naturalis PURL service does not comply to this rule. Non-opacity is a rather common feature of a purl service.
In this case Naturalis chose for non-opacity so a researcher searching for relevant biodiversity data 
can quickly understand the nature of the data on offer.

**A PID is permantly assigned to an object**
Naturalis will try to assure the permanent assignment to an object.

**A PID is actionable**
Naturalis PURL specimen service is highly actionable. 
It's actionability is mainly restricted by the availability of the requested specimen representations.

**A PID allows for universal cross linking of information**
Cross linking through PIDs is not yet implemented in the specimen PURL service.

.. _GBIF: http://www.gbif.org/resource/80575
