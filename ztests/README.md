Angler Web Seed -ztest
=====================================

This directory contains tests which written in coffee and run by protractor,
mocha, chai, chai-as-promised and cucumber. Together these tools enable
e2e testing as well as unit testing, which is split between the features and
specs folders. Config holds configurations for the tools.

Folders:

* /features
* /specs

/features
---------
Holds the higher level feature tests that use cucumber in conjunction with mocha.
These tests are run with a call to 'grunt e2e'.

/specs
------
Holds the lower level unit tests using standard mocha syntax and keywords. These
tests are rum with a call to 'grunt unit'.