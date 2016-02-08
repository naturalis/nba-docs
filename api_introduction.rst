------------
Introduction
------------

The Netherlands Biodiversity API, a.k.a. NBA, is a public API which can be accessed directly. It is primarly intended for computers to communicate with other computers.

The base url for each service is: 

.. code:: html

  http://api.biodiversitydata.nl/v0
  
For more information about the API version you are working with view the :doc:`versioning </api_versioning>` document.

The Netherlands Biodiversity API endpoints follow the general form:

.. code:: html

  http://api.biodiversitydata.nl/{api_version}{endpoint}{optional parameters}

In nearly all cases an API request returns data as a JSON-formatted document. 

For exploration or testing of the NBA services and/or new specimen PURL service we recommend using a command-line tool for transferring data like e.g. `curl`_ or in case a rest client browser plugin, e.g. the chrome rest client, in case you want to work with a browser.

.. _curl : http://curl.haxx.se/

