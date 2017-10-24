---
title: Multimedia data services
weight: 70
---

Digitisation of the specimens in our collection includes a detailed photographic documentation. So far, there are more than 
5 million photos stored in the Naturalis MediaLib. NBA’s multimedia data services provide an interface to the *MediaLib* for 
the public. Since each multimedia record has to be associated with a specimen or taxon which in turn has to have an identification, 
this dataset has great potential to be used in automatic image recognition applications. Furthermore, the MediaLib features 
videos and also artistic drawings of animals and plants. 

## Base URL
The base URL for multimedia-specific services is http://145.136.240.125:31932/v2/multimedia

## Data Source Systems
Most multimedia data are retrieved from our in-house registration systems for botanical (BRAHMS) or zoological/geological (CRS) specimens, 
and most are plant photos. A small fraction items is retrieved from the [Dutch Species Registry](http://www.nederlandsesoorten.nl/). As for 
the other data types, the source system can be retrieved by querying the fields `sourceSystem.code` and `sourceSystem.name`. 

## Link to specimen and taxa
Each multimedia record is linked either to the id of a specimen or a taxon via the fields `associatedSpecimenReference` 
and `associatedTaxonReference`, respectively. In order to provide a faster search for specific specimen/taxon attributes within multimedia 
content, their identifications block is included in a multimedia record. For example, one can search for 
the pygmy cormorant, given its species name *Phalacrocorax pygmeus*:

http://145.136.240.125:30076/v2/multimedia/query/?identifications.defaultClassification.genus=Phalacrocorax&identifications.defaultClassification.specificEpithet=pygmeus

## Downloading multimedia content
Each multimedia record has one or more download URLs retrievable via the field(s) `serviceAccessPoints.accessURI`. Below we query for 
the image location of the pygmy cormorant: 

[http://145.136.240.125:30076/v2/multimedia/query/?identifications.defaultClassification.genus=Phalacrocorax&identifications.defaultClassification.specificEpithet=pygmeus
&_fields=serviceAccessPoints.accessUri](http://145.136.240.125:30076/v2/multimedia/query/?identifications.defaultClassification.genus=Phalacrocorax&identifications.defaultClassification.specificEpithet=pygmeus&_fields=serviceAccessPoints.accessUri)

<figure>
<div style="text-align: center;">
	<p><img src="http://medialib.naturalis.nl/file/id/ZMA.AVES.38187/format/large" align="center"
		alt="pigmy-cormorant" width=300>
		<figcaption>Museum specimen of the Pygmy cormorant (Phalacrocorax pygmeus)</figcaption>
	</div>
</figure>


## Artistic images
Next to photos and videos of specimens, the NBA also gives access to about 2500 artistic scientific drawings and lithographs. 
These documents are categorised in the collection Arts and can be retrieved via the field collectionType. To obtain all drawings 
picturing species of genus Phalacrocorax, one can query within the Arts collection:

http://145.136.240.125:30076/v2/multimedia/query/?identifications.defaultClassification.genus=Phalacrocorax&collectionType=Arts

Among the results we find for instance this nice drawing of *Phalacrocorax aristotoles*:
 
<figure>
<div style="text-align: center;">
	<p><img src="http://medialib.naturalis.nl/file/id/image-134788/format/large" align="center" width=500
    alt="shag-drawing">
  <figcaption>Drawing of the European shag (Phalacrocorax aristotoles)</figcaption>
</div>
</figure>

## Licensing
Each multimedia item is published under a copyright license. Licenses can be accessed by the fields licenseType 
and license. Most of them are published under one of the [Creative Commons licenses](https://creativecommons.org/).

