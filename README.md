git-xflow
=========

An extension to [git-flow](http://github.com/nvie/gitflow), which automatize some usual tasks related to repository operations.



Getting started
---------------

As `git xflow` extends `git flow`, it is required to know what `git flow` is about:

* [Vincent Driessen's branching model](http://nvie.com/posts/a-successful-git-branching-model/)
* [Jeff Kreeftmeijer's blog post about git-flow](http://jeffkreeftmeijer.com/2010/why-arent-you-using-git-flow/)
* [Daniel Kummer's git-flow cheatsheet](http://danielkummer.github.io/git-flow-cheatsheet/)

Of course, a knowledge of `git` is also required:

* [Git official documentation](https://git-scm.com/documentation)
* [GitHub git cheat sheet](https://services.github.com/kit/downloads/github-git-cheat-sheet.pdf)

`git xflow` automatizes some reccurent tasks with `git flow`, such as:

* `git xflow feature/release/hotfix close` to finish and push a feature/release/hotfix
* `git xflow staging` to merge the content of unfinished features into a staging (demonstration) branch
* `git xflow hotfix publish/pull` to publish and pull a hotfix
* and many more !

To get help, just type in a terminal : `git xflow`


Install git-xflow
-----------------

1. [Install git-flow](https://github.com/nvie/gitflow/wiki/Installation)
2. Clone or [download](https://github.com/golflima/git-xflow/archive/master.zip) `git-xflow`, then unzip files ...
3. Put files into a PATH listed folded ([see details for Windows and Linux](https://en.wikipedia.org/wiki/PATH_(variable)))
4. For Linux only, make files executables with:
   * `chmod +x git-xflow`
   * `chmod +x gitflow-common`
5. Test it, type in a terminal : `git xflow`



Licence terms
-------------

`git-xflow` is GNU Lesser General Public License v3 (GNU LGPL v3), see the [LICENSE](LICENSE) file.

Although the BSD License does not require you to share any modifications you make to the source code,
you are very much encouraged and invited to contribute back your modifications to the community, preferably in a Github fork, of course.