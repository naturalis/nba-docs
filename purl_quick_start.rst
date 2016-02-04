-----------
Quick start
-----------

Each specimen PURL follows this general form:

.. code:: html

  http://data.biodiversitydata.nl/{name of data owner organisation or institute}/{object type}/{unitID}

Currently, the PURL specimen service serves solely Naturalis specimen data, therefore
the available {name of data owner organisation or institute name} = naturalis and the available 
{object type} = specimen resulting in the Naturalis specimen PURL general form:

.. code:: html

  http://data.biodiversitydata.nl/naturalis/specimen/{unitID}

Each specimen PURL request returns specimen data default in a text/html formatted document on `a 
Naturalis Bioportal detail page`_. 

Content type: *text/html*, an example

.. code:: html

  http://data.biodiversitydata.nl/naturalis/specimen/ZMA.AVES.39215

Through content negotiation more content types of a specimen can be requested for.

.. list-table:: 
   :widths: 50 80
   :header-rows: 1

   * - Requested content types
     - PURL resolves to ..
   * - application/json
     - a Netherlands Biodiversity API response
   * - image/jpeg
     - a Naturalis Media Library response
   * - video/mp4
     - a Naturalis Media Library response
   * - text/html (default)
     - a Naturalis Bioportal Detail Page response

Content type: *application/json*, an example

.. code:: html
       
      http://data.biodiversitydata.nl/naturalis/specimen/ZMA.AVES.39215?__accept=application/json
       
Content type: *image/jpeg*, an example

.. code:: html

      http://data.biodiversitydata.nl/naturalis/specimen/AMD.118855?__accept=image/jpeg

Content type: *video/mp4*, an example

.. code:: html

      http://data.biodiversitydata.nl/naturalis/specimen/RMNH.AVES.110091?__accept=video/mp4

.. _a Naturalis Bioportal detail page : http://data.biodiversitydata.nl/naturalis/specimen/ZMA.MOLL.228360

