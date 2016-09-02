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
2. Clone or [download](https://github.com/golflima/git-xflow/archive/master.zip) git-xflow, then unzip files ...
3. Put files into a PATH listed folded ([see details for Windows and Linux](https://en.wikipedia.org/wiki/PATH_(variable)))
4. For Linux only, make files executables with:
   * `chmod +x git-xflow`
   * `chmod +x gitflow-common`
5. Test it, type in a terminal : `git xflow`

*NB : File `gitflow-common` is taken from [git-flow](https://raw.githubusercontent.com/nvie/gitflow/develop/gitflow-common) directly,
you don't have to copy it if you use latest version of git-flow and have put file `git-xflow` in the same folder as git-flow files.*

*git-xflow requires Bourne Again Shell (bash).*



Command-line reference
----------------------

Usage : `git xflow [--nogf] <subcommand>`.

### Feature

* `git xflow feature merged <name>`
  * Check branches merged into feature `<name>` on origin.
* `git xflow feature close <name>`
  * Finish and push feature `<name>` to origin.
* `git xflow feature cancel <name>`
  * Delete feature `<name>` from local and origin.
* `git xflow feature log <name>`
  * Display commits history of feature `<name>` from origin.

### Staging

* `git xflow staging merge <name>`
  * Merge feature `<name>` into staging branch.
* `git xflow staging merged`
  * Check branches merged into staging on origin.
* `git xflow staging reset`
  * Reset staging branch to develop.
* `git xflow staging reset <name>`
  * Reset staging branch to feature `<name>`.
* `git xflow staging pull`
  * Pull staging from origin.
* `git xflow staging log`
  * Display commits history of staging from origin.

### Develop

* `git xflow develop merged`
  * Check branches merged into develop on origin.
* `git xflow develop log`
  * Display commits history of develop from origin.

### Release

* `git xflow release merged <name>`
  * Check branches merged into release `<name>` on origin.
* `git xflow release pull <name>`
  * Pull release `<name>` from origin.
* `git xflow release close <name>`
  * Finish and push release `<name>` to origin.
* `git xflow release cancel <name>`
  * Delete release `<name>` from local and origin.
* `git xflow release log <name>`
  * Display commits history of release `<name>` from origin.

### Hotfix

* `git xflow hotfix merged <name>`
  * Check branches merged into hotfix `<name>` on origin.
* `git xflow hotfix publish <name>`
  * Publish hotfix `<name>` to origin.
* `git xflow hotfix pull <name>`
  * Pull hotfix `<name>` from origin.
* `git xflow hotfix close <name>`
  * Finish and push hotfix `<name>` to origin.
* `git xflow hotfix cancel <name>`
  * Delete hotfix `<name>` from local and origin.
* `git xflow hotfix log <name>`
  * Display commits history of hotfix `<name>` from origin.

### Master

* `git xflow master merged`
  * Check branches merged into master on origin.
* `git xflow master pull`
  * Pull master HEAD from origin.
* `git xflow master pull <name>`
  * Pull tag `<name>` from origin.
* `git xflow master log`
  * Display commits history of master from origin.

### Patch

* `git xflow patch make <from> <to>`
  * Build a diff-patch from branch or tag `<from>` to branch or tag `<to>`.
  * The patch will be built inside the working directory and zipped.
  * A log of all modified files is also generated.                "
* `git xflow patch showtags`
  * Display list of tags as used by `git xflow patch makefromtags <to> <from>`.
* `git xflow patch makefromtags`
  * Build a diff-patch from previons tag (n-1) to latest tag (n).
  * The patch will be built inside the working directory and zipped.
  * A log of all modified files is also generated.
* `git xflow patch makefromtags <from> <to>`
  * Build a diff-patch from tag n°`<from>` to tag n°`<to>` (n° relative to latest tag, 1-based index).
  * The patch will be built inside the working directory and zipped.
  * A log of all modified files is also generated.
* `git xflow patch apply <name>`
  * Apply patch `<name>` in current working directory.

### General

* `git xflow help`
  * Show help information.
* `git xflow help <subcommand>`
  * Show help information about `<subcommand>`.
* `git xflow version show`
  * Show version of git-xflow.
* `git xflow version check`
  * Check for updates of git-xflow.
* `git xflow version update`
  * Update git-xflow to latest available version.

### Options

* `git xflow --nogf <subcommand>`
  * `--nogf` tells to git-xflow to *not* forward `<subcommand>` to `git flow <subcommand>` if it is not handled by git-xflow.



Licence terms
-------------

git-xflow is published under the terms of [GNU Lesser General Public License v3](http://www.gnu.org/licenses/lgpl-3.0.html), see the [LICENSE](LICENSE) file.

Although the GNU LGPLv3 does not require you to share any modifications you make to the source code,
you are very much encouraged and invited to contribute back your modifications to the community, preferably in a Github fork, of course.

For a list of all contributors, please see the [AUTHORS](AUTHORS) file.