---
title: Known issues
weight: 100
---

* 11-10-2017: If the field `gatheringEvent.siteCoordinates.geoShape` is used as a filter, the field
  is not in the output. See for example [this query](http://api.biodiversitydata.nl/v2/specimen/query/?unitID=L.3119906&_fields=gatheringEvent.siteCoordinates.geoShape).

* 26-10-2017: Live examples in the 
  {{%swagger-ui-link text="NBA API endpoint reference"%}}{{%/swagger-ui-link%}} 
  for POST methods have
  empty values as default. The user must provide his own QuerySpec
  JSON to make the POST examples work.
  
