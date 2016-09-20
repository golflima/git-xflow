git-xflow
=========

An extension to [git-flow](http://github.com/nvie/gitflow), which automatize some usual tasks related to repository operations.



Getting started
---------------

As *git xflow* extends *git flow*, it is required to know what *git flow* is about:

* [Vincent Driessen's branching model](http://nvie.com/posts/a-successful-git-branching-model/)
* [Jeff Kreeftmeijer's blog post about git-flow](http://jeffkreeftmeijer.com/2010/why-arent-you-using-git-flow/)
* [Daniel Kummer's git-flow cheatsheet](http://danielkummer.github.io/git-flow-cheatsheet/)

Of course, a knowledge of *git* is also required:

* [Git official documentation](https://git-scm.com/documentation)
* [GitHub git cheat sheet](https://services.github.com/kit/downloads/github-git-cheat-sheet.pdf)

*git xflow* automatizes some reccurent tasks with *git flow*, such as:

* `git xflow feature/release/hotfix close` to finish and push a feature/release/hotfix
* `git xflow staging` to merge the content of unfinished features into a staging (demonstration) branch
* `git xflow hotfix publish/pull` to publish and pull a hotfix
* and many more !

To get help, just type in a terminal : `git xflow`



Install git-xflow
-----------------

*git xflow* runs on Windows, Linux, and Mac OS. In facts, it runs everywhere *git* is able to run.

1. [Install git-flow](https://github.com/nvie/gitflow/wiki/Installation)
2. Clone or [download](https://github.com/golflima/git-xflow/archive/master.zip) git-xflow, then unzip files ...
3. Put files into a PATH listed folded ([see details for Windows and Linux](https://en.wikipedia.org/wiki/PATH_(variable)))
4. For Linux only, make *gix-flow* file executable with:
   * `chmod +x git-xflow`
5. Test it, type in a terminal : `git xflow`

*NB : File `gitflow-common` is taken from [git-flow](https://raw.githubusercontent.com/nvie/gitflow/develop/gitflow-common) directly,
you don't have to copy it if you use latest version of git-flow and have put file `git-xflow` in the same folder as git-flow files.*

*git-xflow requires Bourne Again Shell (bash).*



Command-line reference
----------------------

See [Command-line reference.md][docs/Command-line%20reference.md] in docs folder.


__________________________________________________

Licence terms
-------------

*git-xflow* is published under the terms of [GNU Lesser General Public License v3](http://www.gnu.org/licenses/lgpl-3.0.html), see the [LICENSE](LICENSE) file.

Although the GNU LGPLv3 does not require you to share any modifications you make to the source code,
you are very much encouraged and invited to contribute back your modifications to the community, preferably in a Github fork, of course.

For a list of all contributors, please see the [AUTHORS](AUTHORS) file.



Support
-------

You can support this project with
[![Flattr](https://button.flattr.com/flattr-badge-large.png)](https://flattr.com/submit/auto?fid=0ywe2d&url=https%3A%2F%2Fgithub.com%2Fgolflima%2Fgit-xflow)