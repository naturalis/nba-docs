---
title: Known issues
weight: 100
---

* 15-12-2017: The implementation for nested queries has proven to be
  incorrect. Because of this, queries aimed at nested objects, like
  identifications or gatheringPersons, ignore the correlation between
  the inner fields of those objects. This means that searching with
  with more than one condition within nested objects, will sometimes
  produce an inaccurate result (generally, more documents than might
  be expected). Also see the
  [release notes](http://api.biodiversitydata.nl/v2/release-notes).
* 26-10-2017: Live examples in the 
  {{%swagger-ui-link text="NBA API endpoint reference"%}}{{%/swagger-ui-link%}} 
  for POST methods have
  empty values as default. The user must provide his own QuerySpec
  JSON to make the POST examples work.
  
