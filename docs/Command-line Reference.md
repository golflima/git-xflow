# git-xflow command-line reference



## git xflow

Usage: `git xflow SUBCOMMAND ACTION [NAME] [OPTION]`

Available SUBCOMMANDs are:

* `feature`         : Manage feature branches.
* `staging`         : Manage *staging* branch.
* `develop`         : Manage *develop* branch.
* `release`         : Manage release branches.
* `hotfix`          : Manage hotfix branches.
* `tag`             : Manage tags.
* `master`          : Manage *master* branch.
* `review`          : Perform reviews.
* `patch`           : Build and apply patches.
* `help`            : Show help information.
* `version`         : Show version information and check for updates.

Available global OPTIONs are:

* `-g` `--no-forward` : Disable forward of unrecognized commands to gitflow.
* `-c` `--no-color`   : Disable colored output.
* `-v` `--verbose`    : Show more information.
* `-l` `--license`    : Show license.
* `-h` `--help`       : Show help.

Available OPTIONs to force arguments of git-xflow:

* `-s SUBCOMMAND` `--subcommand SUBCOMMAND` : Set value of SUBCOMMAND argument.
* `-a ACTION`     `--action ACTION`         : Set value of ACTION argument.
* `-n NAME`       `--name NAME`             : Set value of NAME argument.

Available command-specific OPTIONs:

* `-t TEMPLATE` `--template TEMPLATE` : Use TEMPLATE to render command (review, patch).
* `-o OUTPUT`   `--output OUTPUT`     : Use OUTPUT as basename for generated files (review, patch).

Type '`git xflow [`SUBCOMMAND`] [`ACTION`] [`NAME`] -h`' for details.
More information at : https://github.com/golflima/git-xflow



## git xflow feature

Usage: `git xflow feature ACTION`

Available ACTIONs are:

* `merged NAME`     : Check branches merged into feature NAME on *origin*.
* `close NAME`      : Finish and push feature NAME to *origin*.
* `cancel NAME`     : Delete feature NAME from local and *origin*.
* `log NAME`        : Display commits history of feature NAME from *origin*.
* `review NAME`     : Review changes between feature NAME and *develop*.
* `patch NAME`      : Build a diff-patch from *develop* to feature NAME.



## git xflow staging

Usage: `git xflow staging ACTION`

Available ACTIONs are:

* `merge NAME`      : Merge feature NAME into *staging* branch.
* `merged`          : Check branches merged into *staging* on *origin*.
* `reset`           : Reset *staging* branch to develop.
* `reset NAME`      : Reset *staging* branch to feature NAME.
* `pull`            : Pull *staging* from *origin*.
* `log`             : Display commits history of *staging* from *origin*.
* `review`          : Review changes between *staging* and *develop*.
* `patch`           : Build a diff-patch from *develop* to *staging*.



## git xflow develop

Usage: `git xflow develop ACTION`

Available ACTIONs are:

* `merged`          : Check branches merged into *develop* on *origin*.
* `log`             : Display commits history of *develop* from *origin*.
* `review`          : Review changes between *develop* and *master*.
* `patch`           : Build a diff-patch from *master* to *develop*.



## git xflow release

Usage: `git xflow release ACTION`

Available ACTIONs are:

* `merged NAME`     : Check branches merged into release NAME on *origin*.
* `pull NAME`       : Pull release NAME from *origin*.
* `close NAME`      : Finish and push release NAME to *origin*.
* `cancel NAME`     : Delete release NAME from local and *origin*.
* `log NAME`        : Display commits history of release NAME from *origin*.
* `review NAME`     : Review changes between release NAME and *master*.
* `patch NAME`      : Build a diff-patch from *master* to release NAME.



## git xflow hotfix

Usage: `git xflow hotfix ACTION`

Available ACTIONs are:

* `merged NAME`     : Check branches merged into hotfix NAME on *origin*.
* `publish NAME`    : Publish hotfix NAME to *origin*.
* `pull NAME`       : Pull hotfix NAME from *origin*.
* `close NAME`      : Finish and push hotfix NAME to *origin*.
* `cancel NAME`     : Delete hotfix NAME from local and *origin*.
* `log NAME`        : Display commits history of hotfix NAME from *origin*.
* `review NAME`     : Review changes between hotfix NAME and *master*.
* `patch NAME`      : Build a diff-patch from *master* to hotfix NAME.



## git xflow tag

Usage: `git xflow tag ACTION`

Available ACTIONs are:

* `list`            : Display the ordered list of tags as used by *git-xflow*.
* `review`          : Review changes between previons tag (n-1) and latest tag (n).
* `review FROM..TO` : Review changes between tag n°FROM and tag n°TO (see `git xflow tag list` for n°).
* `patch`           : Build a diff-patch from previons tag (n-1) to latest tag (n).
* `patch FROM..TO`  : Build a diff-patch from tag n°FROM to tag n°TO (see `git xflow tag list` for n°).


## git xflow master

Usage: `git xflow master ACTION`

Available ACTIONs are:

* `merged`          : Check branches merged into *master* on *origin*.
* `pull`            : Pull *master* from *origin*.
* `pull NAME`       : Pull tag NAME from *origin*.
* `log`             : Display commits history of *master* from *origin*.



## git xflow review

Usage: `git xflow review ACTION`

Available ACTIONs are:

* `do FROM..TO`     : Review changes between branch/tag/commit FROM and TO.



## git xflow patch

Usage: `git xflow patch ACTION`

Available ACTIONs are:

* `make FROM..TO`   : Build a diff-patch from branch or tag FROM to branch or tag TO.
* `apply NAME`      : Apply patch NAME in current working directory.



## git xflow version

Usage: `git xflow version ACTION`

Available ACTIONs are:

* `show`            : Show version of git-xflow.
* `check`           : Check for updates of git-xflow.
* `update`          : Update git-xflow to latest available version.



## More information

More information at : [https://github.com/golflima/git-xflow](https://github.com/golflima/git-xflow)