---
title: Metadata services
weight: 80
---

Metadata services provide miscellaneous information about the data available via the NBA. For a full list of services, please refer ti the
{{%swagger-ui-link text="API endpoint reference"%}}{{%/swagger-ui-link%}}. Metadata services can be categorised into two classes:

## Controlled vocabularies
To maintain data integrity, some fields in our source systems are constrained by controlled vocabularies. These exist for 
the fields `PhaseOrStage`, `Sex`, `SpecimenTypeStatus` (Specimens), `TaxonomicStatus` (Taxa). The 
endpoint `/medata/getControlledList/{field}` returns the allowed values for this field, e.g. for the type status:

{{%nba-link%}}metadata/getControlledList/SpecimenTypeStatus{{%/nba-link%}}

Allowed formats for date fields can be retrieved with {{%swagger-ui-link text="/metadata/getAllowedDateFormats"%}}#/metadata/getAllowedDateFormats{{%/swagger-ui-link%}}. The service {{%swagger-ui-link text="/metadata/getRestServices"%}}#/metadata/getRestServices{{%/swagger-ui-link%}} gives a list of all available NBA endpoints.

## Type-specific metadata
These services reside under `/{dataType}/metadata` and give information about the field structure of the data type, such as all available 
paths (`getPaths`) or detailed information about data types, allowed operators and whether a field is indexed or not (`getFieldInfo`), for example:

{{%nba-link%}}multimedia/metadata/getPaths{{%/nba-link%}}

{{%nba-link%}}multimedia/metadata/getFieldInfo{{%/nba-link%}}

