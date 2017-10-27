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
The base URL for multimedia-specific services is {{%nba-link-text%}}multimedia{{%/nba-link-text%}}

## Data Source Systems
Most multimedia data are retrieved from our in-house registration systems for botanical (BRAHMS) or zoological/geological (CRS) specimens, 
and most are plant photos. A small fraction items is retrieved from the [Dutch Species Register](http://www.nederlandsesoorten.nl/). As for 
the other data types, the source system can be retrieved by querying the fields `sourceSystem.code` and `sourceSystem.name`. 

## Available services

### Query
Querying for multimedia data can be done using the {{%swagger-ui-link text="/multimedia/query/ endpoint"%}}#/multimedia/queryHttpGet_1{{%/swagger-ui-link%}},
which accepts human-readable query strings and JSON encoded [QuerySpec](/advanced-queries/#queryspec) parameters.

### Data access
Several access methods offer the convenient retrieval of multimedia records matching a certain identifier.
The services {{%swagger-ui-link text="/multimedia/find/"%}}#/multimedia/find_2{{%/swagger-ui-link%}} and
{{%swagger-ui-link text="/multimedia/findByIds/"%}}#/multimedia/findByIds_2{{%/swagger-ui-link%}} retrieve taxa
according to their `id` fields (see [here](#multids)).

### Metadata{#md}
Metadata services provide miscellaneous information about multimedia records.
This includes detailed information about all {{%swagger-ui-link text="fields"%}}#/multimedia/getFieldInfo_1{{%/swagger-ui-link%}}
and {{%swagger-ui-link text="paths"%}}#/multimedia/getPaths_1{{%/swagger-ui-link%}}. A description of all
multimedia metadata services can be found {{%swagger-ui-link text="here"%}}#/multimedia{{%/swagger-ui-link%}}.

## Identifiers{#multids}
The field `sourceSystemId` of a geo area is the identifier as it is in the source database. The `surceSystemId`, in turn, 
consists of the specimen `unitID` for which media was recorded, and an internal identifier(for example `RMNH.AVES.140023_2`).  A unique identifier consisting of `{sourceSystemId}@{sourceSystem.code}` is stored in the field `id`, e.g. `RMNH.AVES.140023_2@CRS`.

## Link to specimen and taxa
Each multimedia record is linked either to the id of a specimen or a taxon via the fields `associatedSpecimenReference` 
and `associatedTaxonReference`, respectively. In order to provide a faster search for specific specimen/taxon attributes within multimedia 
content, their identifications block is included in a multimedia record. For example, one can search for 
the pygmy cormorant, given its species name *Phalacrocorax pygmeus*:

{{%nba-link%}}multimedia/query/?identifications.defaultClassification.genus=Phalacrocorax&identifications.defaultClassification.specificEpithet=pygmeus{{%/nba-link%}}

## Downloading multimedia content
Each multimedia record has one or more download URLs retrievable via the field(s) `serviceAccessPoints.accessURI`. Below we query for 
the image location of the pygmy cormorant: 

[{{%nba-link-text%}}multimedia/query/?identifications.defaultClassification.genus=Phalacrocorax&identifications.
defaultClassification.specificEpithet=pygmeus&_fields=serviceAccessPoints.accessUri{{%/nba-link-text%}}]({{%nba-link-text%}}multimedia/query/?identifications.defaultClassification.genus=Phalacrocorax&identifications.defaultClassification.specificEpithet=pygmeus&_fields=serviceAccessPoints.accessUri{{%/nba-link-text%}})

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

{{%nba-link%}}multimedia/query/?identifications.defaultClassification.genus=Phalacrocorax&collectionType=Arts{{%/nba-link%}}

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

