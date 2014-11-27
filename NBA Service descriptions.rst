Introduction
============
Naturalis offers web services for free text and indexed field search in multiple taxonomy and specimen occurrence data sources. Searches can be done on either taxons, specimen occurrences and multimedia linked to either a taxon or a specimen occurrence. The searchable data is stored text documents in Elastic search document store. 

The following information has been made available per service type.

================================== ========= ======== =========== =========
Taxonomic data services
================================== ========= ======== =========== =========
Taxon search                       requests_ fields_  responses_  examples_
================================== ========= ======== =========== =========

================================== ======== ========== ========== ========
Specimen occurrence data services
================================== ======== ========== ========== ========
Specimen search                    requests fields     responses  examples
---------------------------------- -------- ---------- ---------- --------
Specimen name-search               requests fields     responses  examples
================================== ======== ========== ========== ========

================================== ======== ========== ========== ========
Multimedia data services
================================== ======== ========== ========== ========
Multimedia search                  requests fields     responses  examples
================================== ======== ========== ========== ========

Kees :ref:'Link title<label-Jan1>'

.. _fields: http://www.naturalis.nl/

Access
======
The access to all Naturalis data services is open. 

.. _label-Jan1:

Taxonomic data services
=======================

1.TAXON SEARCH
--------------
 
*Description*
 Free text or indexed field search through taxonomic data from two data sources, i.e. 1. Nederlands Soortenregister, and 2. Catalogue of Life. It searches a specific predefined set of indexed taxon document fields and returns taxonomic data from basically species and subspecies. All searchable fields in taxon documents are listed here (refer to fields information per service document). 

 Base url: http://10.42.1.177:8080/v0

.. _requests:

*Requests*
  *url*
   The basic request url for free text search is:
   <base url>/taxon/search/?_search=[term], e.g. http://10.42.1.177:8080/v0/taxon/search/?_search=Abies
  
   The basic request url for indexed field search is:
   <base url>/taxon/search/?indexedField1=[term]&indexedField2[term], e.g. http://10.42.1.177:8080/v0/taxon/search/?genusOrMonomial=Parus
  
  *indexed field parameters*
   A taxon document incorporates an extensive set of taxonomic fields. A subset of these set are searchable fields. These fields are listed here_.
   .._fields: http://www.naturalis.nl/

   - document field name
   - aliases and multi mapped fields
   - whole path
   
  *general meta parameters*
   For both free text and indexed field search requests optional extra request parameters – so called meta parameters - can be added. These parameters instruct the NBA on how to execute a query.

   Paging parameters

   ===========   =========================================================================================================
   Name          Description
   ===========   =========================================================================================================
   _maxResults   - _maxResults instructs NBA to return maximum amount of search results per page 
                 - example: <base url>/taxon/search/?..&_maxResults=60, shows maximum amount of 60 documents in responses
                 - default setting: _maxResults=10
   _offset       - _offset instructs NBA to start filling first response from search result no = offset value + 1
                 - example: <base url>/taxon/search/?..&_offset=100. In first response search result no 101 is first document in response 
                 - default setting: _offset=0
   ===========   =========================================================================================================
  
   Sorting parameters
   
   ==============   ======================================================================================================
   Name             Description
   ==============   ======================================================================================================
   _sort            - _sort instructs NBA to return responses sorted on a single specified indexed field included in Taxon documents.
                    - example: <base url>/taxon/search/?..&_sort=indexedFieldName, e.g. …&_sort=genusOrMonomial. 
                    - default setting: _sort = _score
                   	- remarks: _sort parameter can be used on these sortable fields
   _sortDirection   - _sortDirection instructs NBA on sorting direction, i.e. either descending or ascending
                    - example: <base url>/taxon/search/?..&_sortDirection=ASC or &_sortDirection=DESC 
                    - default setting: _sortDirection=ASC
   ==============   ======================================================================================================
      
  *specific meta parameters for indexed field search*
   For indexed fields search specific search meta parameters are available. 
   
   ===========   =========================================================================================================
   Name          Description
   ===========   =========================================================================================================
   _andOr        - _andOr instructs NBA to use logical operator AND (conjunction) for multiple indexed field search
                 - example: <base url>/taxon/search/?..&_andOr=AND
                 - default setting: _andOr=AND
   ===========   =========================================================================================================

.. _responses:
  
*Responses*
  
 *basic response structure*
  The xsd structure of a taxon response can be viewed here. Reengineer xsd structure from xml with xml spy. 
  A list of all taxon related fields in a taxon response can be viewed here. 

 *term handling*
  
 
 *serving rest links*
 
 *multilanguage*

 - ABCD EFG
 - JSON

.. _examples:

*Examples*

 1. Free text search

  Search for value Parus in any taxon                          
   http://10.42.1.177:8080/v0/taxon/search/?_search=Parus
  
  Search for value paardenbloem in any taxon                   
   http://10.42.1.177:8080/v0/taxon/search/?_search=paardenbloem
  
  Search for value PAARDENBLOEM in any taxon                   
   http://10.42.1.177:8080/v0/taxon/search/?_search=PAARDENBLOEM
  
  Search for value BLOEM in any taxon                          
   http://10.42.1.177:8080/v0/taxon/search/?_search=Bloem
  
  Search for value BLOEM in any taxon | 20 documents in result | sort = ascending
   http://10.42.1.177:8080/v0/taxon/search/?_search=Bloem&_maxResults=20&_sort=_score&_sortDirection=DESC

  Search for value BLOEM in any taxon | start from document 21
   http://10.42.1.177:8080/v0/taxon/search/?_search=Bloem&_offset=20

  Search for value BLOEM in any taxon | start from document 21
   http://10.42.1.177:8080/v0/taxon/search/?_search=Bloem&_offset=20

 2. Indexed field search
 
  Search for key:value pair genus=Parus in any taxon                          
   http://10.42.1.177:8080/v0/taxon/search/?genus=Parus

  Search for key:value pair genus=Parus and species=major in any taxon (default=AND)                         
   http://10.42.1.177:8080/v0/taxon/search/?genus=Parus&species=major

  Search for key:value pair genus=Parus or species=major in any taxon                           
   http://10.42.1.177:8080/v0/taxon/search/?genus=Parus&species=major&_andOr=OR
  
  Search for key:value pair paardenbloem in any taxon                   
   http://10.42.1.177:8080/v0/taxon/search/?vernacularNames.name=paardenbloem
  
  Search for key:value pair PAARDENBLOEM in any taxon                   
   http://10.42.1.177:8080/v0/taxon/search/?vernacularNames.name=PAARDENBLOEM
  
  Search for key:value pair BLOEM in any taxon                          
   http://10.42.1.177:8080/v0/taxon/search/?vernacularNames.name=Bloem
  
  Search for key:value pair BLOEM in any taxon | 20 documents in result | sort = ascending
   http://10.42.1.177:8080/v0/taxon/search/?vernacularNames.name=Bloem&_maxResults=20&_sort=_score&_sortDirection=DESC

  Search for value BLOEM pair in any taxon | start from document 21
   http://10.42.1.177:8080/v0/taxon/search/?vernacularNames.name=Bloem&_offset=20

  Search for value BLOEM pair in any taxon | start from document 21
   http://10.42.1.177:8080/v0/taxon/search/?vernacularNames.name=Bloem&_offset=20

Specimen data services
======================

1.SPECIMEN SEARCH
-----------------

*Description*
 Free text or indexed field search through specimen occurrence data harvested from multiple data sources. It searches a predefined set of specimen document fields and returns taxonomic, geospatial and temporal  information from specimen. 
 
*Requests*
  *url*
   The basic request url for free text search is:
   <base url>/specimen/search/?_search=[term], e.g. <base url>/specimen/search/?_search=Parus
      
   The basic request url for indexed field search is:
   <base url>/specimen/search/?indexedField1=[term]&indexedField2=[term], e.g. <base url>/specimen/search/?typeStatus=holotype or <base url>/specimen/search/?typeStatus=holotype&sex=male 
     
  *geospatial search option*
   Geospatial search 
 
   Geospatial search can be combined with either free text or indexed field search. It can also be used on its own.
 
  *additional integrated search option*
   
   Name resolution is
   Class resolution is
   Scientific name mapping is
    
  *indexed field parameters*
   For indexed field search indexed field parameters
  
   - document field name
   - aliases and multi mapped fields
   - whole path
    
  *general meta parameters*
   For both free text and indexed field search requests optional extra request parameters – so called meta parameters - can be added. These parameters instruct the NBA on how to execute a query. 
 
   Paging parameters
     
   ===========   =========================================================================================================
   Name          Description
   ===========   =========================================================================================================
   _maxResults   - _maxResults instructs NBA to return maximum amount of search results per page 
                 - example: <base url>/specimen/search/?..&_maxResults=60, shows maximum amount of 60 documents in responses
                 - default setting: _maxResults=10
   _offset       - _offset instructs NBA to start filling first response from search result no = offset value + 1
	             - example: <base url>/specimen/search/?..&_offset=100. In first response search result no 101 is first document in response 
			     - default setting: _offset=0
   ===========   =========================================================================================================
 
   Sorting parameters

   ==============   ======================================================================================================
   Name             Description
   ==============   ======================================================================================================
   _sort            - _sort instructs NBA to return responses sorted on a single specified indexed field included in Specimen documents.
	                - example: <base url>/specimen/search/?..&_sort=indexedFieldName, e.g. …&_sort=genusOrMonomial. 
	                - default setting: _sort = _score
				    - remarks: _sort parameter can be used on these sortable fields
   _sortDirection   - _sortDirection instructs NBA on sorting direction, i.e. either descending or ascending
	                - example: <base url>/specimen/search/?..&_sortDirection=ASC or &_sortDirection=DESC 
		            - default setting: _sortDirection=ASC
   ==============   ======================================================================================================
	  
  *specific meta parameters for indexed field search*
   For indexed fields search specific search meta parameters are available. 
   
   ===========   =========================================================================================================
   Name          Description
   ===========   =========================================================================================================
   _andOr		 - _andOr instructs NBA to use logical operator AND (conjunction) for multiple indexed field search
                 - example: <base url>/specimen/search/?..&_andOr=AND
                 - default setting: _andOr=AND
   ===========   =========================================================================================================
    
*Responses*

 - Basic structure
 - Term handling
 - Rest links
 - Multi-language
 - ABCD EFG
 - JSON

*Examples*

 1. Free text search

  Search for RMNH.MAM.50017 in CRS in any specimen
   http://10.42.1.177:8080/v0/specimen/search/?_search=RMNH.MAM.50017
  
  Search for Melicertus kerathurus in any specimen
   http://10.42.1.177:8080/v0/specimen/search/?_search=Melicertus kerathurus
  
  Search for koolmees in any specimen
   http://10.42.1.177:8080/v0/specimen/search/?_search=koolmees

  Search for mees in any specimen
   http://10.42.1.177:8080/v0/specimen/search/?_search=mees

  Search for Parus major in any specimen
   http://10.42.1.177:8080/v0/specimen/search/?_search=Parus major
  
 2. Indexed field search
 
  Search for key:value pair unitID=RMNH.MAM.50017 in CRS in any specimen
   http://10.42.1.177:8080/v0/specimen/search/?unitID=RMNH.MAM.50017
  
  Search for key:value pair sex=male in any specimen
   http://10.42.1.177:8080/v0/specimen/search/?sex=male

  Search for key:value pair collectorsFieldNumber=add a fieldnumber Brahms in any specimen
   http://10.42.1.177:8080/v0/specimen/search/?collectorsFieldNumber=[Brahms fieldnumber]

  Search for key:value pair locality=Mafraq in Jordan
http://10.42.1.177:8080/v0/specimen/search/?locality=Mafraq&_geoShape=%7B%22type%22%3A%22MultiPolygon%22%2C%22coordinates%22%3A%5B%5B%5B%5B39.046329%2C32.308494%5D%2C%5B39.235775%2C32.352858%5D%2C%5B39.256342%2C32.342678%5D%2C%5B39.271122%2C32.311956%5D%2C%5B39.291999%2C32.244519%5D%2C%5B39.266471%2C32.212867%5D%2C%5B39.146168%2C32.125844%5D%2C%5B39.146375%2C32.118144%5D%2C%5B39.136246%2C32.115353%5D%2C%5B39.116816%2C32.102899%5D%2C%5B38.998064%2C32.006936%5D%2C%5B38.96344%2C31.994482%5D%2C%5B38.96344%2C31.994327%5D%2C%5B38.963337%2C31.994379%5D%2C%5B38.849752%2C31.966319%5D%2C%5B38.624856%2C31.91087%5D%2C%5B38.400167%2C31.855369%5D%2C%5B38.175375%2C31.799921%5D%2C%5B37.986522%2C31.753358%5D%2C%5B37.950479%2C31.744472%5D%2C%5B37.761412%2C31.69612%5D%2C%5B37.702742%2C31.681116%5D%2C%5B37.455005%2C31.617709%5D%2C%5B37.207269%2C31.554354%5D%2C%5B36.997912%2C31.500814%5D%2C%5B36.959532%2C31.490999%5D%2C%5B37.089653%2C31.370076%5D%2C%5B37.219774%2C31.249101%5D%2C%5B37.221722%2C31.247292%5D%2C%5B37.349895%2C31.12823%5D%2C%5B37.480017%2C31.007256%5D%2C%5B37.483117%2C31.004103%5D%2C%5B37.486321%2C31.0009%5D%2C%5B37.489422%2C30.997696%5D%2C%5B37.492626%2C30.994492%5D%2C%5B37.602283%2C30.883232%5D%2C%5B37.712044%2C30.772025%5D%2C%5B37.821908%2C30.660869%5D%2C%5B37.931565%2C30.549661%5D%2C%5B37.981071%2C30.499483%5D%2C%5B37.981381%2C30.498811%5D%2C%5B37.980968%2C30.498398%5D%2C%5B37.980038%2C30.498088%5D%2C%5B37.97332%2C30.494522%5D%2C%5B37.900146%2C30.459072%5D%2C%5B37.779327%2C30.400419%5D%2C%5B37.670703%2C30.347606%5D%2C%5B37.647552%2C30.330863%5D%2C%5B37.634529%2C30.312776%5D%2C%5B37.605177%2C30.250713%5D%2C%5B37.56921%2C30.174955%5D%2C%5B37.536137%2C30.105295%5D%2C%5B37.491696%2C30.011193%5D%2C%5B37.470198%2C29.994553%5D%2C%5B37.352376%2C29.973314%5D%2C%5B37.218534%2C29.949129%5D%2C%5B37.075804%2C29.923291%5D%2C%5B36.931936%2C29.897246%5D%2C%5B36.84295%2C29.881226%5D%2C%5B36.756237%2C29.865517%5D%2C%5B36.728745%2C29.853528%5D%2C%5B36.70487%2C29.831152%5D%2C%5B36.649576%2C29.7494%5D%2C%5B36.603584%2C29.681471%5D%2C%5B36.541263%2C29.589409%5D%2C%5B36.477081%2C29.494609%5D%2C%5B36.399979%2C29.438902%5D%2C%5B36.283707%2C29.35485%5D%2C%5B36.177977%2C29.278369%5D%2C%5B36.069457%2C29.200028%5D%2C%5B36.043825%2C29.190881%5D%2C%5B36.016437%2C29.189951%5D%2C%5B35.912464%2C29.205686%5D%2C%5B35.797225%2C29.223075%5D%2C%5B35.740251%2C29.231731%5D%2C%5B35.622042%2C29.249689%5D%2C%5B35.473628%2C29.272065%5D%2C%5B35.334618%2C29.293148%5D%2C%5B35.179072%2C29.316661%5D%2C%5B35.060319%2C29.334696%5D%2C%5B34.949385%2C29.351686%5D%2C%5B34.949392%2C29.351711%5D%2C%5B34.962413%2C29.359768%5D%2C%5B34.969005%2C29.450832%5D%2C%5B34.976085%2C29.477037%5D%2C%5B34.997813%2C29.517971%5D%2C%5B34.996837%2C29.533881%5D%2C%5B34.976085%2C29.552151%5D%2C%5B34.962413%2C29.552151%5D%2C%5B34.961599%2C29.555406%5D%2C%5B34.961599%2C29.558092%5D%2C%5B34.960216%2C29.559516%5D%2C%5B34.95558%2C29.558987%5D%2C%5B34.95986%2C29.586206%5D%2C%5B34.966992%2C29.608116%5D%2C%5B34.980324%2C29.627004%5D%2C%5B34.989833%2C29.651964%5D%2C%5B34.995104%2C29.708162%5D%2C%5B35.002545%2C29.733096%5D%2C%5B35.048951%2C29.842314%5D%2C%5B35.053188%2C29.862623%5D%2C%5B35.054118%2C29.923394%5D%2C%5B35.061456%2C29.957346%5D%2C%5B35.065384%2C29.965976%5D%2C%5B35.070345%2C29.973727%5D%2C%5B35.074065%2C29.982564%5D%2C%5B35.074686%2C29.994604%5D%2C%5B35.086261%2C30.034034%5D%2C%5B35.129049%2C30.089741%5D%2C%5B35.145276%2C30.123382%5D%2C%5B35.145276%2C30.154905%5D%2C%5B35.124812%2C30.21609%5D%2C%5B35.125225%2C30.244667%5D%2C%5B35.132356%2C30.261875%5D%2C%5B35.141762%2C30.313965%5D%2C%5B35.147756%2C30.32647%5D%2C%5B35.154474%2C30.336754%5D%2C%5B35.159952%2C30.347503%5D%2C%5B35.162122%2C30.361404%5D%2C%5B35.159332%2C30.375615%5D%2C%5B35.144965%2C30.395872%5D%2C%5B35.140005%2C30.406155%5D%2C%5B35.140005%2C30.430185%5D%2C%5B35.157368%2C30.470854%5D%2C%5B35.162122%2C30.494677%5D%2C%5B35.205324%2C30.617099%5D%2C%5B35.263821%2C30.71978%5D%2C%5B35.263882%2C30.719967%5D%2C%5B35.271573%2C30.743706%5D%2C%5B35.27612%2C30.768976%5D%2C%5B35.279531%2C30.780241%5D%2C%5B35.286145%2C30.792333%5D%2C%5B35.293897%2C30.800188%5D%2C%5B35.310847%2C30.813314%5D%2C%5B35.316635%2C30.822823%5D%2C%5B35.320045%2C30.84494%5D%2C%5B35.319528%2C30.867316%5D%2C%5B35.322216%2C30.88995%5D%2C%5B35.334928%2C30.912585%5D%2C%5B35.34711%2C30.92271%5D%2C%5B35.374099%2C30.945141%5D%2C%5B35.385261%2C30.963279%5D%2C%5B35.385158%2C30.994647%5D%2C%5B35.391565%2C31.023947%5D%2C%5B35.438488%2C31.103736%5D%2C%5B35.443242%2C31.132209%5D%2C%5B35.436214%2C31.159546%5D%2C%5B35.421331%2C31.184506%5D%2C%5B35.410686%2C31.204608%5D%2C%5B35.401177%2C31.230291%5D%2C%5B35.3957%2C31.25768%5D%2C%5B35.408205%2C31.282019%5D%2C%5B35.422261%2C31.303%5D%2C%5B35.423915%2C31.324601%5D%2C%5B35.416473%2C31.331835%5D%2C%5B35.435077%2C31.360619%5D%2C%5B35.452854%2C31.400823%5D%2C%5B35.456884%2C31.423509%5D%2C%5B35.457128%2C31.433524%5D%2C%5B35.458538%2C31.491619%5D%2C%5B35.458125%2C31.491929%5D%2C%5B35.458745%2C31.491567%5D%2C%5B35.459158%2C31.491877%5D%2C%5B35.459055%2C31.492808%5D%2C%5B35.458745%2C31.494409%5D%2C%5B35.464222%2C31.568565%5D%2C%5B35.480139%2C31.641119%5D%2C%5B35.502479%2C31.68536%5D%2C%5B35.527578%2C31.735067%5D%2C%5B35.55941%2C31.765349%5D%2C%5B35.538326%2C31.819299%5D%2C%5B35.538326%2C31.826741%5D%2C%5B35.549075%2C31.839195%5D%2C%5B35.524684%2C31.919241%5D%2C%5B35.527474%2C31.927355%5D%2C%5B35.533676%2C31.9303%5D%2C%5B35.5406%2C31.932006%5D%2C%5B35.545148%2C31.936605%5D%2C%5B35.545871%2C31.944563%5D%2C%5B35.53998%2C31.955622%5D%2C%5B35.538326%2C31.963942%5D%2C%5B35.537706%2C31.977584%5D%2C%5B35.535536%2C31.988229%5D%2C%5B35.524684%2C32.011691%5D%2C%5B35.522824%2C32.057838%5D%2C%5B35.528301%2C32.075098%5D%2C%5B35.545148%2C32.086828%5D%2C%5B35.534606%2C32.09923%5D%2C%5B35.535226%2C32.110806%5D%2C%5B35.551969%2C32.135197%5D%2C%5B35.546698%2C32.141605%5D%2C%5B35.546698%2C32.147031%5D%2C%5B35.551246%2C32.151527%5D%2C%5B35.55941%2C32.155093%5D%2C%5B35.55941%2C32.162534%5D%2C%5B35.555173%2C32.174394%5D%2C%5B35.559562%2C32.190371%5D%2C%5B35.572536%2C32.237594%5D%2C%5B35.55941%2C32.237594%5D%2C%5B35.561064%2C32.243149%5D%2C%5B35.563751%2C32.246818%5D%2C%5B35.567575%2C32.249506%5D%2C%5B35.572536%2C32.251908%5D%2C%5B35.564578%2C32.263587%5D%2C%5B35.560857%2C32.28263%5D%2C%5B35.561167%2C32.301699%5D%2C%5B35.565612%2C32.313352%5D%2C%5B35.556517%2C32.328209%5D%2C%5B35.557343%2C32.358207%5D%2C%5B35.551969%2C32.367948%5D%2C%5B35.551969%2C32.374821%5D%2C%5B35.55941%2C32.374821%5D%2C%5B35.55941%2C32.367948%5D%2C%5B35.565612%2C32.367948%5D%2C%5B35.563958%2C32.377043%5D%2C%5B35.560961%2C32.384717%5D%2C%5B35.556827%2C32.390918%5D%2C%5B35.551969%2C32.395285%5D%2C%5B35.549592%2C32.39854%5D%2C%5B35.545148%2C32.409573%5D%2C%5B35.554863%2C32.411175%5D%2C%5B35.5591%2C32.413966%5D%2C%5B35.55817%2C32.417997%5D%2C%5B35.551969%2C32.423242%5D%2C%5B35.551969%2C32.429443%5D%2C%5B35.55941%2C32.429443%5D%2C%5B35.55786%2C32.43412%5D%2C%5B35.556207%2C32.434791%5D%2C%5B35.554139%2C32.434455%5D%2C%5B35.551969%2C32.436212%5D%2C%5B35.565612%2C32.443706%5D%2C%5B35.55941%2C32.450527%5D%2C%5B35.566232%2C32.453111%5D%2C%5B35.572536%2C32.456728%5D%2C%5B35.572536%2C32.464195%5D%2C%5B35.568092%2C32.46497%5D%2C%5B35.565405%2C32.466314%5D%2C%5B35.563131%2C32.468174%5D%2C%5B35.55941%2C32.470396%5D%2C%5B35.561271%2C32.477089%5D%2C%5B35.564991%2C32.48391%5D%2C%5B35.570986%2C32.489207%5D%2C%5B35.579978%2C32.49148%5D%2C%5B35.579978%2C32.497733%5D%2C%5B35.570573%2C32.506027%5D%2C%5B35.568505%2C32.510265%5D%2C%5B35.561374%2C32.519179%5D%2C%5B35.55724%2C32.519334%5D%2C%5B35.551969%2C32.518817%5D%2C%5B35.551969%2C32.525587%5D%2C%5B35.565612%2C32.525587%5D%2C%5B35.562821%2C32.532021%5D%2C%5B35.55941%2C32.55295%5D%2C%5B35.565612%2C32.546102%5D%2C%5B35.570159%2C32.556825%5D%2C%5B35.572536%2C32.560391%5D%2C%5B35.57388%2C32.556748%5D%2C%5B35.574397%2C32.554396%5D%2C%5B35.575844%2C32.554965%5D%2C%5B35.579978%2C32.560391%5D%2C%5B35.574397%2C32.572767%5D%2C%5B35.571296%2C32.598554%5D%2C%5B35.565612%2C32.607546%5D%2C%5B35.565612%2C32.615013%5D%2C%5B35.572536%2C32.615013%5D%2C%5B35.572536%2C32.62124%5D%2C%5B35.564061%2C32.625477%5D%2C%5B35.560031%2C32.632686%5D%2C%5B35.560547%2C32.640903%5D%2C%5B35.562718%2C32.64421%5D%2C%5B35.569849%2C32.646768%5D%2C%5B35.578737%2C32.653434%5D%2C%5B35.593827%2C32.670358%5D%2C%5B35.612224%2C32.681546%5D%2C%5B35.612334%2C32.681535%5D%2C%5B35.635995%2C32.679143%5D%2C%5B35.652015%2C32.686171%5D%2C%5B35.685191%2C32.711234%5D%2C%5B35.740175%2C32.740535%5D%2C%5B35.757435%2C32.744282%5D%2C%5B35.75759%2C32.744347%5D%2C%5B35.763842%2C32.746969%5D%2C%5B35.769734%2C32.748054%5D%2C%5B35.774901%2C32.747279%5D%2C%5B35.779139%2C32.744514%5D%2C%5B35.779139%2C32.744462%5D%2C%5B35.779035%2C32.744359%5D%2C%5B35.779035%2C32.744282%5D%2C%5B35.788234%2C32.734411%5D%2C%5B35.895721%2C32.713276%5D%2C%5B35.905229%2C32.708573%5D%2C%5B35.922489%2C32.693768%5D%2C%5B35.92745%2C32.692373%5D%2C%5B35.940369%2C32.692502%5D%2C%5B35.944193%2C32.690771%5D%2C%5B35.945743%2C32.684104%5D%2C%5B35.9444%2C32.677619%5D%2C%5B35.941196%2C32.673536%5D%2C%5B35.937475%2C32.674002%5D%2C%5B35.94657%2C32.664441%5D%2C%5B35.955355%2C32.657439%5D%2C%5B35.965794%2C32.654365%5D%2C%5B35.980263%2C32.656612%5D%2C%5B36.003621%2C32.655088%5D%2C%5B36.008272%2C32.643719%5D%2C%5B36.005275%2C32.626692%5D%2C%5B36.005998%2C32.607907%5D%2C%5B36.015403%2C32.591164%5D%2C%5B36.060465%2C32.533261%5D%2C%5B36.066046%2C32.521608%5D%2C%5B36.066253%2C32.517319%5D%2C%5B36.06987%2C32.516595%5D%2C%5B36.081906%2C32.516265%5D%2C%5B36.096225%2C32.515872%5D%2C%5B36.133226%2C32.520109%5D%2C%5B36.13953%2C32.519541%5D%2C%5B36.149865%2C32.51613%5D%2C%5B36.15586%2C32.5152%5D%2C%5B36.160821%2C32.517215%5D%2C%5B36.17219%2C32.525923%5D%2C%5B36.177357%2C32.527318%5D%2C%5B36.188209%2C32.52228%5D%2C%5B36.220765%2C32.494581%5D%2C%5B36.285258%2C32.456935%5D%2C%5B36.373108%2C32.386422%5D%2C%5B36.387887%2C32.379317%5D%2C%5B36.407627%2C32.374227%5D%2C%5B36.463955%2C32.369395%5D%2C%5B36.480181%2C32.360791%5D%2C%5B36.516684%2C32.357014%5D%2C%5B36.653504%2C32.342859%5D%2C%5B36.689574%2C32.319656%5D%2C%5B36.706937%2C32.328338%5D%2C%5B36.728641%2C32.327795%5D%2C%5B36.792513%2C32.313533%5D%2C%5B36.806569%2C32.313042%5D%2C%5B36.819385%2C32.316788%5D%2C%5B36.980099%2C32.410038%5D%2C%5B37.133165%2C32.494478%5D%2C%5B37.133165%2C32.494529%5D%2C%5B37.133371%2C32.494529%5D%2C%5B37.133371%2C32.494581%5D%2C%5B37.244062%2C32.554396%5D%2C%5B37.415214%2C32.64713%5D%2C%5B37.494606%2C32.690056%5D%2C%5B37.586677%2C32.739837%5D%2C%5B37.758036%2C32.832519%5D%2C%5B37.929395%2C32.92533%5D%2C%5B38.056726%2C32.994292%5D%2C%5B38.056726%2C32.994344%5D%2C%5B38.230875%2C33.086302%5D%2C%5B38.315742%2C33.13118%5D%2C%5B38.529565%2C33.244251%5D%2C%5B38.774511%2C33.371685%5D%2C%5B38.82102%2C33.229032%5D%2C%5B38.862568%2C33.10072%5D%2C%5B38.897191%2C32.994344%5D%2C%5B38.94277%2C32.852337%5D%2C%5B38.990002%2C32.705576%5D%2C%5B39.057181%2C32.496596%5D%2C%5B38.979977%2C32.476055%5D%2C%5B38.978633%2C32.475693%5D%2C%5B38.97822%2C32.47497%5D%2C%5B38.978633%2C32.47373%5D%2C%5B38.979977%2C32.472102%5D%2C%5B39.028759%2C32.328338%5D%2C%5B39.036201%2C32.313352%5D%2C%5B39.046329%2C32.308494%5D%5D%5D%5D%7D&_maxResults=20&_sort=_score&_sortDirection=DESC

2.SPECIMEN-NAME SEARCH
----------------------

*Description*
 Free text or indexed field search through specimen occurrence data from multiple data sources. It searches a predefined set of  specimen object fields and returns taxonomic, geospatial and temporal information from specimen.
   
*Requests*
  *url*
   The basic request url for free text search is:
   <base url>/specimen/name-search/?_search=[term], e.g. <base url>/specimen/name-search/?_search=Parus&

   The basic request url for indexed field search is:
   <base url>/specimen/name-search/?indexedField1=[term]&indexedField2, e.g. <base url>/specimen/name-search/?typeStatus=holotype or typeStatus=holotype&sex=male

  *geospatial search*
   Geospatial search is…

   Geospatial search can be combined with either free text or indexed field search. It can also be used on its own. 
   
  *additional integrated search capabilities*
   Name resolution is 
   Class resolution is
   Scientific name mapping is

  *general meta parameters*
   For both free text and indexed field search requests optional extra request parameters – so called meta parameters - can be added. These parameters instruct the NBA on how to execute a query.

   Paging parameters

   ===========   =========================================================================================================
   Name          Description
   ===========   =========================================================================================================
   _maxResults   - _maxResults instructs NBA to return maximum amount of search results per page 
                 - example: <base url>/specimen/name-search/?..&_maxResults=60, shows maximum amount of 60 documents in responses
                 - default setting: _maxResults=10
   _offset       - _offset instructs NBA to start filling first response from search result no = offset value + 1
                 - example: <base url>/specimen/name-search/?..&_offset=100. In first response search result no 101 is first document in response 
                 - default setting: _offset=0
   ===========   =========================================================================================================
  
   Sorting parameters
   
   ==============   ======================================================================================================
   Name             Description
   ==============   ======================================================================================================
   _sort            - _sort instructs NBA to return responses sorted on a single specified indexed field included in Specimen documents.
                    - example: <base url>/specimen/name-search/?..&_sort=indexedFieldName, e.g. …&_sort=genusOrMonomial. 
                    - default setting: _sort = _score
                   	- remarks: _sort parameter can be used on these sortable fields
   _sortDirection   - _sortDirection instructs NBA on sorting direction, i.e. either descending or ascending
                    - example: <base url>/specimen/name-search/?..&_sortDirection=ASC or &_sortDirection=DESC 
                    - default setting: _sortDirection=ASC
   ==============   ======================================================================================================
      
  *specific meta parameters for indexed field search*
   For indexed fields search specific search meta parameters are available. 
   
   ===========   =========================================================================================================
   Name          Description
   ===========   =========================================================================================================
   _andOr		 - _andOr instructs NBA to use logical operator AND (conjunction) for multiple indexed field search
                 - example: <base url>/specimen/name-search/?..&_andOr=AND
                 - default setting: _andOr=AND
   ===========   =========================================================================================================

*Responses*

 - Basic structure
 - Term handling
 - Rest links
 - Multi-language
 - ABCD EFG
 - JSON

*Examples*

 1. Free text search

  Search with name resolution for RMNH.MAM.50017 in CRS in any specimen
   http://10.42.1.177:8080/v0/specimen/name-search/?_search=RMNH.MAM.50017
  
  Search with name resolution for Melicertus kerathurus in any specimen
   http://10.42.1.177:8080/v0/specimen/search/?_search=Melicertus kerathurus
  
  Search with name resolution for koolmees in any specimen
   http://10.42.1.177:8080/v0/specimen/name-search/?_search=koolmees

  Search with name resolution for vroedmeesterpad in any specimen
   http://10.42.1.177:8080/v0/specimen/name-search/?_search=vroedmeesterpad

  Search with name resolution for mees in any specimen
   http://10.42.1.177:8080/v0/specimen/name-search/?_search=mees

  Search with name resolution for paardenbloem in any specimen
   http://10.42.1.177:8080/v0/specimen/name-search/?_search=paardenbloem

  Search with name resolution for Parus major in any specimen
   http://10.42.1.177:8080/v0/specimen/name-search/?_search=Parus major
  
 2. Indexed field search
 
  Search with name resolution for key:value pair Melicertus kerathurus in any specimen
   http://10.42.1.177:8080/v0/specimen/name-search/?genus=Melicertus&species=kerathurus
  
  Search with name resolution for key:value pair vernacularName=koolmees in any specimen
   http://10.42.1.177:8080/v0/specimen/name-search/?vernacularName=koolmees

  Search with name resolution for key:value pair vernacularName=paardenbloem in any specimen
   http://10.42.1.177:8080/v0/specimen/name-search/?vernacularName=paardenbloem

  Search with name resolution for key:value pair vernacularName=bloem in any specimen
   http://10.42.1.177:8080/v0/specimen/name-search/?vernacularName=bloem

  Search with name resolution for key:value pair genus=Triticum in Jordan
http://10.42.1.177:8080/v0/specimen/name-search/?genus=Triticum&_geoShape=%7B%22type%22%3A%22MultiPolygon%22%2C%22coordinates%22%3A%5B%5B%5B%5B39.046329%2C32.308494%5D%2C%5B39.235775%2C32.352858%5D%2C%5B39.256342%2C32.342678%5D%2C%5B39.271122%2C32.311956%5D%2C%5B39.291999%2C32.244519%5D%2C%5B39.266471%2C32.212867%5D%2C%5B39.146168%2C32.125844%5D%2C%5B39.146375%2C32.118144%5D%2C%5B39.136246%2C32.115353%5D%2C%5B39.116816%2C32.102899%5D%2C%5B38.998064%2C32.006936%5D%2C%5B38.96344%2C31.994482%5D%2C%5B38.96344%2C31.994327%5D%2C%5B38.963337%2C31.994379%5D%2C%5B38.849752%2C31.966319%5D%2C%5B38.624856%2C31.91087%5D%2C%5B38.400167%2C31.855369%5D%2C%5B38.175375%2C31.799921%5D%2C%5B37.986522%2C31.753358%5D%2C%5B37.950479%2C31.744472%5D%2C%5B37.761412%2C31.69612%5D%2C%5B37.702742%2C31.681116%5D%2C%5B37.455005%2C31.617709%5D%2C%5B37.207269%2C31.554354%5D%2C%5B36.997912%2C31.500814%5D%2C%5B36.959532%2C31.490999%5D%2C%5B37.089653%2C31.370076%5D%2C%5B37.219774%2C31.249101%5D%2C%5B37.221722%2C31.247292%5D%2C%5B37.349895%2C31.12823%5D%2C%5B37.480017%2C31.007256%5D%2C%5B37.483117%2C31.004103%5D%2C%5B37.486321%2C31.0009%5D%2C%5B37.489422%2C30.997696%5D%2C%5B37.492626%2C30.994492%5D%2C%5B37.602283%2C30.883232%5D%2C%5B37.712044%2C30.772025%5D%2C%5B37.821908%2C30.660869%5D%2C%5B37.931565%2C30.549661%5D%2C%5B37.981071%2C30.499483%5D%2C%5B37.981381%2C30.498811%5D%2C%5B37.980968%2C30.498398%5D%2C%5B37.980038%2C30.498088%5D%2C%5B37.97332%2C30.494522%5D%2C%5B37.900146%2C30.459072%5D%2C%5B37.779327%2C30.400419%5D%2C%5B37.670703%2C30.347606%5D%2C%5B37.647552%2C30.330863%5D%2C%5B37.634529%2C30.312776%5D%2C%5B37.605177%2C30.250713%5D%2C%5B37.56921%2C30.174955%5D%2C%5B37.536137%2C30.105295%5D%2C%5B37.491696%2C30.011193%5D%2C%5B37.470198%2C29.994553%5D%2C%5B37.352376%2C29.973314%5D%2C%5B37.218534%2C29.949129%5D%2C%5B37.075804%2C29.923291%5D%2C%5B36.931936%2C29.897246%5D%2C%5B36.84295%2C29.881226%5D%2C%5B36.756237%2C29.865517%5D%2C%5B36.728745%2C29.853528%5D%2C%5B36.70487%2C29.831152%5D%2C%5B36.649576%2C29.7494%5D%2C%5B36.603584%2C29.681471%5D%2C%5B36.541263%2C29.589409%5D%2C%5B36.477081%2C29.494609%5D%2C%5B36.399979%2C29.438902%5D%2C%5B36.283707%2C29.35485%5D%2C%5B36.177977%2C29.278369%5D%2C%5B36.069457%2C29.200028%5D%2C%5B36.043825%2C29.190881%5D%2C%5B36.016437%2C29.189951%5D%2C%5B35.912464%2C29.205686%5D%2C%5B35.797225%2C29.223075%5D%2C%5B35.740251%2C29.231731%5D%2C%5B35.622042%2C29.249689%5D%2C%5B35.473628%2C29.272065%5D%2C%5B35.334618%2C29.293148%5D%2C%5B35.179072%2C29.316661%5D%2C%5B35.060319%2C29.334696%5D%2C%5B34.949385%2C29.351686%5D%2C%5B34.949392%2C29.351711%5D%2C%5B34.962413%2C29.359768%5D%2C%5B34.969005%2C29.450832%5D%2C%5B34.976085%2C29.477037%5D%2C%5B34.997813%2C29.517971%5D%2C%5B34.996837%2C29.533881%5D%2C%5B34.976085%2C29.552151%5D%2C%5B34.962413%2C29.552151%5D%2C%5B34.961599%2C29.555406%5D%2C%5B34.961599%2C29.558092%5D%2C%5B34.960216%2C29.559516%5D%2C%5B34.95558%2C29.558987%5D%2C%5B34.95986%2C29.586206%5D%2C%5B34.966992%2C29.608116%5D%2C%5B34.980324%2C29.627004%5D%2C%5B34.989833%2C29.651964%5D%2C%5B34.995104%2C29.708162%5D%2C%5B35.002545%2C29.733096%5D%2C%5B35.048951%2C29.842314%5D%2C%5B35.053188%2C29.862623%5D%2C%5B35.054118%2C29.923394%5D%2C%5B35.061456%2C29.957346%5D%2C%5B35.065384%2C29.965976%5D%2C%5B35.070345%2C29.973727%5D%2C%5B35.074065%2C29.982564%5D%2C%5B35.074686%2C29.994604%5D%2C%5B35.086261%2C30.034034%5D%2C%5B35.129049%2C30.089741%5D%2C%5B35.145276%2C30.123382%5D%2C%5B35.145276%2C30.154905%5D%2C%5B35.124812%2C30.21609%5D%2C%5B35.125225%2C30.244667%5D%2C%5B35.132356%2C30.261875%5D%2C%5B35.141762%2C30.313965%5D%2C%5B35.147756%2C30.32647%5D%2C%5B35.154474%2C30.336754%5D%2C%5B35.159952%2C30.347503%5D%2C%5B35.162122%2C30.361404%5D%2C%5B35.159332%2C30.375615%5D%2C%5B35.144965%2C30.395872%5D%2C%5B35.140005%2C30.406155%5D%2C%5B35.140005%2C30.430185%5D%2C%5B35.157368%2C30.470854%5D%2C%5B35.162122%2C30.494677%5D%2C%5B35.205324%2C30.617099%5D%2C%5B35.263821%2C30.71978%5D%2C%5B35.263882%2C30.719967%5D%2C%5B35.271573%2C30.743706%5D%2C%5B35.27612%2C30.768976%5D%2C%5B35.279531%2C30.780241%5D%2C%5B35.286145%2C30.792333%5D%2C%5B35.293897%2C30.800188%5D%2C%5B35.310847%2C30.813314%5D%2C%5B35.316635%2C30.822823%5D%2C%5B35.320045%2C30.84494%5D%2C%5B35.319528%2C30.867316%5D%2C%5B35.322216%2C30.88995%5D%2C%5B35.334928%2C30.912585%5D%2C%5B35.34711%2C30.92271%5D%2C%5B35.374099%2C30.945141%5D%2C%5B35.385261%2C30.963279%5D%2C%5B35.385158%2C30.994647%5D%2C%5B35.391565%2C31.023947%5D%2C%5B35.438488%2C31.103736%5D%2C%5B35.443242%2C31.132209%5D%2C%5B35.436214%2C31.159546%5D%2C%5B35.421331%2C31.184506%5D%2C%5B35.410686%2C31.204608%5D%2C%5B35.401177%2C31.230291%5D%2C%5B35.3957%2C31.25768%5D%2C%5B35.408205%2C31.282019%5D%2C%5B35.422261%2C31.303%5D%2C%5B35.423915%2C31.324601%5D%2C%5B35.416473%2C31.331835%5D%2C%5B35.435077%2C31.360619%5D%2C%5B35.452854%2C31.400823%5D%2C%5B35.456884%2C31.423509%5D%2C%5B35.457128%2C31.433524%5D%2C%5B35.458538%2C31.491619%5D%2C%5B35.458125%2C31.491929%5D%2C%5B35.458745%2C31.491567%5D%2C%5B35.459158%2C31.491877%5D%2C%5B35.459055%2C31.492808%5D%2C%5B35.458745%2C31.494409%5D%2C%5B35.464222%2C31.568565%5D%2C%5B35.480139%2C31.641119%5D%2C%5B35.502479%2C31.68536%5D%2C%5B35.527578%2C31.735067%5D%2C%5B35.55941%2C31.765349%5D%2C%5B35.538326%2C31.819299%5D%2C%5B35.538326%2C31.826741%5D%2C%5B35.549075%2C31.839195%5D%2C%5B35.524684%2C31.919241%5D%2C%5B35.527474%2C31.927355%5D%2C%5B35.533676%2C31.9303%5D%2C%5B35.5406%2C31.932006%5D%2C%5B35.545148%2C31.936605%5D%2C%5B35.545871%2C31.944563%5D%2C%5B35.53998%2C31.955622%5D%2C%5B35.538326%2C31.963942%5D%2C%5B35.537706%2C31.977584%5D%2C%5B35.535536%2C31.988229%5D%2C%5B35.524684%2C32.011691%5D%2C%5B35.522824%2C32.057838%5D%2C%5B35.528301%2C32.075098%5D%2C%5B35.545148%2C32.086828%5D%2C%5B35.534606%2C32.09923%5D%2C%5B35.535226%2C32.110806%5D%2C%5B35.551969%2C32.135197%5D%2C%5B35.546698%2C32.141605%5D%2C%5B35.546698%2C32.147031%5D%2C%5B35.551246%2C32.151527%5D%2C%5B35.55941%2C32.155093%5D%2C%5B35.55941%2C32.162534%5D%2C%5B35.555173%2C32.174394%5D%2C%5B35.559562%2C32.190371%5D%2C%5B35.572536%2C32.237594%5D%2C%5B35.55941%2C32.237594%5D%2C%5B35.561064%2C32.243149%5D%2C%5B35.563751%2C32.246818%5D%2C%5B35.567575%2C32.249506%5D%2C%5B35.572536%2C32.251908%5D%2C%5B35.564578%2C32.263587%5D%2C%5B35.560857%2C32.28263%5D%2C%5B35.561167%2C32.301699%5D%2C%5B35.565612%2C32.313352%5D%2C%5B35.556517%2C32.328209%5D%2C%5B35.557343%2C32.358207%5D%2C%5B35.551969%2C32.367948%5D%2C%5B35.551969%2C32.374821%5D%2C%5B35.55941%2C32.374821%5D%2C%5B35.55941%2C32.367948%5D%2C%5B35.565612%2C32.367948%5D%2C%5B35.563958%2C32.377043%5D%2C%5B35.560961%2C32.384717%5D%2C%5B35.556827%2C32.390918%5D%2C%5B35.551969%2C32.395285%5D%2C%5B35.549592%2C32.39854%5D%2C%5B35.545148%2C32.409573%5D%2C%5B35.554863%2C32.411175%5D%2C%5B35.5591%2C32.413966%5D%2C%5B35.55817%2C32.417997%5D%2C%5B35.551969%2C32.423242%5D%2C%5B35.551969%2C32.429443%5D%2C%5B35.55941%2C32.429443%5D%2C%5B35.55786%2C32.43412%5D%2C%5B35.556207%2C32.434791%5D%2C%5B35.554139%2C32.434455%5D%2C%5B35.551969%2C32.436212%5D%2C%5B35.565612%2C32.443706%5D%2C%5B35.55941%2C32.450527%5D%2C%5B35.566232%2C32.453111%5D%2C%5B35.572536%2C32.456728%5D%2C%5B35.572536%2C32.464195%5D%2C%5B35.568092%2C32.46497%5D%2C%5B35.565405%2C32.466314%5D%2C%5B35.563131%2C32.468174%5D%2C%5B35.55941%2C32.470396%5D%2C%5B35.561271%2C32.477089%5D%2C%5B35.564991%2C32.48391%5D%2C%5B35.570986%2C32.489207%5D%2C%5B35.579978%2C32.49148%5D%2C%5B35.579978%2C32.497733%5D%2C%5B35.570573%2C32.506027%5D%2C%5B35.568505%2C32.510265%5D%2C%5B35.561374%2C32.519179%5D%2C%5B35.55724%2C32.519334%5D%2C%5B35.551969%2C32.518817%5D%2C%5B35.551969%2C32.525587%5D%2C%5B35.565612%2C32.525587%5D%2C%5B35.562821%2C32.532021%5D%2C%5B35.55941%2C32.55295%5D%2C%5B35.565612%2C32.546102%5D%2C%5B35.570159%2C32.556825%5D%2C%5B35.572536%2C32.560391%5D%2C%5B35.57388%2C32.556748%5D%2C%5B35.574397%2C32.554396%5D%2C%5B35.575844%2C32.554965%5D%2C%5B35.579978%2C32.560391%5D%2C%5B35.574397%2C32.572767%5D%2C%5B35.571296%2C32.598554%5D%2C%5B35.565612%2C32.607546%5D%2C%5B35.565612%2C32.615013%5D%2C%5B35.572536%2C32.615013%5D%2C%5B35.572536%2C32.62124%5D%2C%5B35.564061%2C32.625477%5D%2C%5B35.560031%2C32.632686%5D%2C%5B35.560547%2C32.640903%5D%2C%5B35.562718%2C32.64421%5D%2C%5B35.569849%2C32.646768%5D%2C%5B35.578737%2C32.653434%5D%2C%5B35.593827%2C32.670358%5D%2C%5B35.612224%2C32.681546%5D%2C%5B35.612334%2C32.681535%5D%2C%5B35.635995%2C32.679143%5D%2C%5B35.652015%2C32.686171%5D%2C%5B35.685191%2C32.711234%5D%2C%5B35.740175%2C32.740535%5D%2C%5B35.757435%2C32.744282%5D%2C%5B35.75759%2C32.744347%5D%2C%5B35.763842%2C32.746969%5D%2C%5B35.769734%2C32.748054%5D%2C%5B35.774901%2C32.747279%5D%2C%5B35.779139%2C32.744514%5D%2C%5B35.779139%2C32.744462%5D%2C%5B35.779035%2C32.744359%5D%2C%5B35.779035%2C32.744282%5D%2C%5B35.788234%2C32.734411%5D%2C%5B35.895721%2C32.713276%5D%2C%5B35.905229%2C32.708573%5D%2C%5B35.922489%2C32.693768%5D%2C%5B35.92745%2C32.692373%5D%2C%5B35.940369%2C32.692502%5D%2C%5B35.944193%2C32.690771%5D%2C%5B35.945743%2C32.684104%5D%2C%5B35.9444%2C32.677619%5D%2C%5B35.941196%2C32.673536%5D%2C%5B35.937475%2C32.674002%5D%2C%5B35.94657%2C32.664441%5D%2C%5B35.955355%2C32.657439%5D%2C%5B35.965794%2C32.654365%5D%2C%5B35.980263%2C32.656612%5D%2C%5B36.003621%2C32.655088%5D%2C%5B36.008272%2C32.643719%5D%2C%5B36.005275%2C32.626692%5D%2C%5B36.005998%2C32.607907%5D%2C%5B36.015403%2C32.591164%5D%2C%5B36.060465%2C32.533261%5D%2C%5B36.066046%2C32.521608%5D%2C%5B36.066253%2C32.517319%5D%2C%5B36.06987%2C32.516595%5D%2C%5B36.081906%2C32.516265%5D%2C%5B36.096225%2C32.515872%5D%2C%5B36.133226%2C32.520109%5D%2C%5B36.13953%2C32.519541%5D%2C%5B36.149865%2C32.51613%5D%2C%5B36.15586%2C32.5152%5D%2C%5B36.160821%2C32.517215%5D%2C%5B36.17219%2C32.525923%5D%2C%5B36.177357%2C32.527318%5D%2C%5B36.188209%2C32.52228%5D%2C%5B36.220765%2C32.494581%5D%2C%5B36.285258%2C32.456935%5D%2C%5B36.373108%2C32.386422%5D%2C%5B36.387887%2C32.379317%5D%2C%5B36.407627%2C32.374227%5D%2C%5B36.463955%2C32.369395%5D%2C%5B36.480181%2C32.360791%5D%2C%5B36.516684%2C32.357014%5D%2C%5B36.653504%2C32.342859%5D%2C%5B36.689574%2C32.319656%5D%2C%5B36.706937%2C32.328338%5D%2C%5B36.728641%2C32.327795%5D%2C%5B36.792513%2C32.313533%5D%2C%5B36.806569%2C32.313042%5D%2C%5B36.819385%2C32.316788%5D%2C%5B36.980099%2C32.410038%5D%2C%5B37.133165%2C32.494478%5D%2C%5B37.133165%2C32.494529%5D%2C%5B37.133371%2C32.494529%5D%2C%5B37.133371%2C32.494581%5D%2C%5B37.244062%2C32.554396%5D%2C%5B37.415214%2C32.64713%5D%2C%5B37.494606%2C32.690056%5D%2C%5B37.586677%2C32.739837%5D%2C%5B37.758036%2C32.832519%5D%2C%5B37.929395%2C32.92533%5D%2C%5B38.056726%2C32.994292%5D%2C%5B38.056726%2C32.994344%5D%2C%5B38.230875%2C33.086302%5D%2C%5B38.315742%2C33.13118%5D%2C%5B38.529565%2C33.244251%5D%2C%5B38.774511%2C33.371685%5D%2C%5B38.82102%2C33.229032%5D%2C%5B38.862568%2C33.10072%5D%2C%5B38.897191%2C32.994344%5D%2C%5B38.94277%2C32.852337%5D%2C%5B38.990002%2C32.705576%5D%2C%5B39.057181%2C32.496596%5D%2C%5B38.979977%2C32.476055%5D%2C%5B38.978633%2C32.475693%5D%2C%5B38.97822%2C32.47497%5D%2C%5B38.978633%2C32.47373%5D%2C%5B38.979977%2C32.472102%5D%2C%5B39.028759%2C32.328338%5D%2C%5B39.036201%2C32.313352%5D%2C%5B39.046329%2C32.308494%5D%5D%5D%5D%7D&_maxResults=20&_sort=_score&_sortDirection=DESC

Multimedia data services
========================

1.MULTIMEDIA SEARCH
--------------
 
*Description*
 Free text or indexed field search through specimen occurrence ánd taxonomic data from multiple data sources. It searches a specific predefined set of multimedia fields and returns taxonomic, geospatial and temporal information from multimedia and …for taxons.

*Requests*
  *url*
   The basic request url for free text search is:
   <base url>/multimedia/search/?_search=[term], e.g. <base url>/taxon/search/?_search=Abies
  
   The basic request url for indexed field search is:
   <base url>/multimedia/search/?indexedField1=[term]&indexedField2[term], e.g. <base url>/taxon/search/?genusOrMonomial=Parus or genusOrMonomial=Parus&species=major
  
  *indexed field parameters*
   For indexed field search indexed field parameters
  
   - document field name
   - aliases and multi mapped fields
   - whole path
   
  *general meta parameters*
   For both free text and indexed field search requests optional extra request parameters – so called meta parameters - can be added. These parameters instruct the NBA on how to execute a query.

   Paging parameters

   ===========   =========================================================================================================
   Name          Description
   ===========   =========================================================================================================
   _maxResults   - _maxResults instructs NBA to return maximum amount of search results per page 
                 - example: <base url>/taxon/search/?..&_maxResults=60, shows maximum amount of 60 documents in responses
                 - default setting: _maxResults=10
   _offset       - _offset instructs NBA to start filling first response from search result no = offset value + 1
                 - example: <base url>/taxon/search/?..&_offset=100. In first response search result no 101 is first document in response 
                 - default setting: _offset=0
   ===========   =========================================================================================================
  
   Sorting parameters
   
   ==============   ======================================================================================================
   Name             Description
   ==============   ======================================================================================================
   _sort            - _sort instructs NBA to return responses sorted on a single specified indexed field included in Taxon documents.
                    - example: <base url>/taxon/search/?..&_sort=indexedFieldName, e.g. …&_sort=genusOrMonomial. 
                    - default setting: _sort = _score
                   	- remarks: _sort parameter can be used on these sortable fields
   _sortDirection   - _sortDirection instructs NBA on sorting direction, i.e. either descending or ascending
                    - example: <base url>/taxon/search/?..&_sortDirection=ASC or &_sortDirection=DESC 
                    - default setting: _sortDirection=ASC
   ==============   ======================================================================================================
      
  *specific meta parameters for indexed field search*
   For indexed fields search specific search meta parameters are available. 
   
   ===========   =========================================================================================================
   Name          Description
   ===========   =========================================================================================================
   _andOr		 - _andOr instructs NBA to use logical operator AND (conjunction) for multiple indexed field search
                 - example: <base url>/taxon/search/?..&_andOr=AND
                 - default setting: _andOr=AND
   ===========   =========================================================================================================
  
*Responses*
 
 - Basic structure
 - Term handling
 - Rest links
 - Multi-language
 - ABCD EFG
 - JSON

*Examples*

 1. Free test search

  Search for RMNH.MAM.50017 in CRS in any specimen and taxon
   http://10.42.1.177:8080/v0/multimedia/search/?_search=
  
  Search for koolmees in any specimen and taxon
   http://10.42.1.177:8080/v0/multimedia/search/?_search=koolmees

  Search for mees in any specimen and taxon
   http://10.42.1.177:8080/v0/multimedia/search/?_search=mees

  Search for Parus major in any specimen and taxon
   http://10.42.1.177:8080/v0/multimedia/search/?_search=Parus major

  Search for Melicertus kerathurus in any specimen and taxon
   http://10.42.1.177:8080/v0/multimedia/search/?_search=Abies abies
  
 2. Indexed field search
 
  Search for key:value pair unitID=AHCYFCKPYRK:1560587210 in CRS in any specimen and taxon
   http://10.42.1.177:8080/v0/multimedia/search/?unitID=AHCYFCKPYRK:1560587210
  
  Search for key:value pair vernacularName=paardenbloem in any specimen and taxon
   http://10.42.1.177:8080/v0/multimedia/search/?vernacularName=paardenbloem

  Search for key:value pair genus=Parus and species=major in any specimen and taxon
   http://10.42.1.177:8080/v0/multimedia/search/?genus=Parus&species=major

















































  
  
  
  
  
  

  
   
