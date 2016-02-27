Web-seed assets/sass directory readme
=====================================

This directory contains the sass source that will be compiled and added to the 
app/assets/css directory using compass. 

Folders:

* /base
* /common
* /config
* /vendors (optional)
* /vendors-extensions (optional)

/base
-----
Contains the scss that sets up the project. Boilerplate code, normalization as
well as typography (font-face imports).

/common
-------
Contains scss that is common across multiple folders, that can be put here for
simplicity. This is usually going to be mixins, functions, and placeholders. 
Contains partials for all three.

/vendors
--------
Contains scss from third parties, such as bootstrap.css. Should not be in the 
form of a partial.

/vendors_extensions
-------------------
Contains scss partials that override or manipulate values in vendor scss files.