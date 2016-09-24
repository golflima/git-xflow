Template Creation Guide
=======================

> *git-xflow* uses templates to generate files or execute commands when making
> patches or reviews. This way, you are able to configure *git-xflow* to fit
> exactly your needs, and, by following this guide, to extend its possibilities.



When templates are used?
------------------------

Templates are used when thse *git-xflow* commands are executed:

* Patches:
  * `git xflow patch make FROM..TO`
  * `git xflow patch tags FROM..TO`
  * `git xflow SUBCOMMAND patch NAME`
* Reviews:
  * `git xflow SuBCOMMAND review NAME`



How to configure used templates?
--------------------------------

There are two ways to configure templates used by *git-xflow*:

* Once for the repository, by typing command: `git xflow init`
