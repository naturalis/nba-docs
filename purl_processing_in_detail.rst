-------------------------
PURL processing in detail
-------------------------
All purl requests are subjected to two basic checks.

1. specimen unitID presence check, if no, purl service serves 404 (Not Found)
2. content type presence check, i.e.

a. purl service forwards to Bioportal (303 See Other) - text/html is available for all specimens
		
   if accept header value(s) is either
    - absent, e,g, empty, or
    - solely text/html, or
    - text/html followed by other content types, e.g. text/html,application/json,image/jpeg, or
    - other content types followed by text/html, e.g. image/jpeg,video/mp4,text/html, if all the other content types
       are not available.
		
		
b. purl service forwards to NBA (303 See Other) -  application/json is available for all specimens
	
   if accept header value(s) is either
    - solely application/json, or,
    - application/json followed by other content types, e.g. application/json,text/hrml,image/jpeg etc, or
    - other content types followed by application/json, e.g. image/jpeg,video/mp4,application/json, if all the other
      content types, or are not available.
	
c. purl service forwards to Naturalis Medialib (303 See Other) 
	
   if 
    - one of the multimedia content types is available, i.e. image/jpeg or video/mp4, and
    - text/html and application/json are not requested in the accept header.
		
   or,
    - purl service forwards to 406 (Not Acceptable) if not one of the multimedia content types is available
