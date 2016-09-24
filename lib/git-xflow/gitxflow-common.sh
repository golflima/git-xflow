# 
# git-xflow -- An extension to git-flow, which automatize
# some usual tasks related to repository operations.
#
# Feel free to contribute to this project at:
#    https://github.com/golflima/git-xflow
# git-flow : http://github.com/nvie/gitflow
#
# Copyright 2016 Jérémy Walther (jeremy.walther@golflima.net).
#
# This file is part of git-xflow.
#
# git-xflow is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# git-xflow is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
# 
# You should have received a copy of the GNU Lesser General Public License
# along with git-xflow. If not, see <http://www.gnu.org/licenses/>



############## Constants ##############

# Colors
NC=$'\033[0m'
BLACK=$'\033[0;30m';        DARK_GRAY=$'\033[1;30m'
RED=$'\033[0;31m';          LIGHT_RED=$'\033[1;31m'
GREEN=$'\033[0;32m';        LIGHT_GREEN=$'\033[1;32m'
BROWN=$'\033[0;33m';        YELLOW=$'\033[1;33m'
BLUE=$'\033[0;34m';         LIGHT_BLUE=$'\033[1;34m'
PURPLE=$'\033[0;35m';       LIGHT_PURPLE=$'\033[1;35m'
CYAN=$'\033[0;36m';         LIGHT_CYAN=$'\033[1;36m'
LIGHT_GRAY=$'\033[0;37m';   WHITE=$'\033[1;37m'

# Fixes for old version of 'sed' (Mac OS X ...)
TAB=$'\t';                  LF=$'\n' 


############## General functions ##############

# Displays trace information message $@ in dark gray
trace() { echo -e "${DARK_GRAY}$@${NC}"; }
debug() { has_flag "debug" && trace "$1"; }

# Displays information message $@ in light blue
info() { echo -e "${LIGHT_BLUE}$@${NC}"; }

# Displays success message $@ in green
success() { echo -e "${GREEN}$@${NC}"; }

# Displays warning message $@ in brown/orange (overriden from gitflow-common)
warn() { echo -e "${BROWN}$@${NC}" >&2; }

# Ends the execution, and displays $@ in bold red (overriden from gitflow-common)
die() { warn "${LIGHT_RED}$@"; exit 1; }

# Ends the execution, and displays a last message ($@ if set, 'Done.' otherwise)
end() { [[ -z "$@" ]] && echo -e "${GREEN}Done.${NC}" || echo -e "${GREEN}$@${NC}"; exit 0; }

# Displays question message $@ in light purple
question() { echo -en "${LIGHT_PURPLE}$@${NC}"; }

# Ends the execution if given argument $1 is empty and displays usage of subcommand $2, or global usage if $2 is empty
require_argument() { [[ -z "$(eval "echo \$$1")" ]] && usage $2 && echo && die "Missing <$1> argument !"; }

# Ends the execution if given command $1 returns an error and displays debug information. Usage: 'assertok "command" $LINENO'
assertok() { ! $1 && warn "${LIGHT_RED}fatal: git-xflow v${GITXFLOW_VERSION}, line $2, following command failed (err: $?):" && die "$1"; }

remove_color() {
    NC=; BLACK=; DARK_GRAY=; RED=; LIGHT_RED=; GREEN=; LIGHT_GREEN=;
    BROWN=; YELLOW=; BLUE=; LIGHT_BLUE=; PURPLE=; LIGHT_PURPLE=;
    CYAN=; LIGHT_CYAN=; LIGHT_GRAY=; WHITE=;
}

# Convenience functions for checking shFlags flags
get_flag() { local flag; flag="FLAGS_$1"; echo -n "$(eval "echo -n \${${flag}}")"; }
set_flag() { local flag; flag="FLAGS_$1"; eval "\${${flag}}=\"$2\""; }
empty_flag() { [[ -z "$(get_flag "$1")" ]]; }
has_flag() { [[ "$(get_flag "$1")" = "${FLAGS_TRUE}" ]]; }
hasnt_flag() { [[ "$(get_flag "$1")" != "${FLAGS_TRUE}" ]]; }

# Loads settings that can be overridden using git config
gitxflow_load_settings() {
    readonly REPOSITORY_NAME="$(basename $(git remote -v | grep fetch | cut -f2 | cut -d\  -f1) | cut -d. -f1)"
	readonly GITXFLOW_TEMPLATE_REVIEW="$(git config --get-all gitxflow.template.review)"
    readonly GITXFLOW_TEMPLATE_PATCH="$(git config --get-all gitxflow.template.patch)"
    readonly STAGING_BRANCH="$(git config --get gitxflow.branch.staging)"
    readonly FEATURE_PREFIX="$(git config --get gitflow.prefix.feature)"
    readonly RELEASE_PREFIX="$(git config --get gitflow.prefix.release)"
    readonly HOTFIX_PREFIX="$(git config --get gitflow.prefix.hotfix)"
}

gitxflow_is_initialized() {
    [[ "${STAGING_BRANCH}" != "" ]]
}

# Save default settings that can be overridden using git config
gitxflow_save_default_settings() {
    git config --remove-section gitxflow.branch
    assertok "git config --add gitxflow.branch.staging staging"
    git config --remove-section gitxflow.template
    assertok "git config --add gitxflow.template.review templates/revie/html"
    assertok "git config --add gitxflow.template.patch templates/patch/log"
    assertok "git config --add gitxflow.template.patch templates/patch/zip"
    assertok "git config --add gitxflow.template.patch templates/patch/sh"
    assertok "git config --add gitxflow.template.patch templates/patch/cmd"
    assertok "git config --add gitxflow.template.patch templates/patch/tar"
    assertok "git config --add gitxflow.template.patch templates/patch/targz"
}

# Parse and evaluate a given template. Usage: 'parse_template <template_name> <generated_file_name> <generated_file_suffix>'
parse_template() {
    [[ -z "$1" ]] && die "Missing templates path."
    [[ -z "$2" ]] && die "Missing template name."
    [[ -z "$3" ]] && die "Missing default generated file name."
    local template_path template_name generated_file_name generated_file_suffix template_file lhs value rhs parsed_template
    template_path="$1"
    template_name="$2"
    generated_file_name="$3"
    generated_file_suffix="$4"
    template_file="${GITXFLOW_DIR}/templates/${template_path}/${template_name}"
    if [[ -f "${template_name}" ]]; then
        template_file="${template_name}"
    elif [[ -f "${DOT_GIT_DIR}/git-xflow/templates/${template_path}/${template_name}" ]]; then
        template_file="${DOT_GIT_DIR}/git-xflow/templates/${template_path}/${template_name}"
    elif [[ -f "${DOT_GIT_DIR}/../${template_name}" ]]; then
        template_file="${DOT_GIT_DIR}/../${template_name}"
    fi
    if [[ ! -f "${template_file}" ]]; then
        warn "Template '${template_name}': file not found."
        return 1;
    fi
    parsed_template="$(<"${template_file}")"
    # Handle comment tags: '<%# comment #%>'
    while [[ "${parsed_template}" =~ (<%#([^#]*)#%>) ]]; do
        lhs="${BASH_REMATCH[1]}"
        parsed_template="${parsed_template//"${lhs}"/}"
    done
    # Handle variable tags: '<%= variablename %>'
    while [[ "${parsed_template}" =~ (<%=[[:blank:]]*[[:cntrl:]]*[[:blank:]]*([^%[:blank:][:cntrl:]]*)[[:blank:][:cntrl:]]*%>) ]]; do
        lhs="${BASH_REMATCH[1]}"
        value="${BASH_REMATCH[2]}"
        rhs="$(eval echo -n "\"\${$value}\"")"
        if [[ $? != 0 ]]; then
            warn "Template '${template_name}': error when evaluating variable tag: '${lhs}'."
            return 10;
        fi
        parsed_template="${parsed_template//"${lhs}"/"${rhs}"}"
    done
    # Handle not echoed command tags: '<%@ command %>'
    while [[ "${parsed_template}" =~ (<%@([^%]*)%>) ]]; do
        lhs="${BASH_REMATCH[1]}"
        value="${BASH_REMATCH[2]}"
        eval "${value}"
        if [[ $? != 0 ]]; then
            warn "Template '${template_name}': error when evaluating not echoed command tag: '${lhs}'."
            return 11;
        fi
        parsed_template="${parsed_template//"${lhs}"/}"
    done
    # Handle echoed command tags: '<%$ command %>'
    while [[ "${parsed_template}" =~ (<%\$([^%]*)%>) ]]; do
        lhs="${BASH_REMATCH[1]}"
        value="${BASH_REMATCH[2]}"
        rhs="$(eval "${value}")"
        if [[ $? != 0 ]]; then
            warn "Template '${template_name}': error when evaluating echoed command tag: '${lhs}'."
            return 12;
        fi
        parsed_template="${parsed_template//"${lhs}"/"${rhs}"}"
    done
    # Handle to-file command tags: '<%: command %>'
    while [[ "${parsed_template}" =~ (<%:([^%]*)%>) ]]; do
        lhs="${BASH_REMATCH[1]}"
        value="${BASH_REMATCH[2]}"
        eval "${value}" > "${generated_file_name}${generated_file_suffix}"
        if [[ $? = 0 ]]; then
            info "Template '${template_name}': File '${generated_file_name}${generated_file_suffix}' generated."
            return 0;
        else
            warn "Template '${template_name}': error when evaluating to-file command tag: '${lhs}'."
            return 13;
        fi
    done
    if [[ ! -z "${generated_file_name}${generated_file_suffix}" ]]; then
        echo -n "${parsed_template}" > "${generated_file_name}${generated_file_suffix}"
        info "Template '${template_name}': File '${generated_file_name}${generated_file_suffix}' generated."
    else
        info "Template '${template_name}': executed."
    fi
    return 0;
}

# Disable flags_help() function of shFlags
flags_help() { return 0; }

# Colorize a given markdown text
colorize_markdown() {
    [[ -z "$1" ]] && return 1;
    local colorized_markdown lhs rhs
    # Handle lists, emphasized elements, inline code,
    # argument name in capital letters, and citation blocks
    colorized_markdown="$(echo -n "$1" | sed \
        -e 's/^\*[[:blank:]]*\(.*\)$/    \1/g' \
        -e 's/\*\([^\*]*\)\*/'"${GREEN}"'\1'"${NC}"'/g' \
        -e 's/`\([^`]*\)`/'"${LIGHT_BLUE}"'\1'"${NC}"'/g' \
        -e 's/\([[:upper:]]\{2,\}\)/'"${BROWN}"'\1'"${NC}"'/g' \
        -e 's/^>[[:blank:]]*\(.*\)$/'"${DARK_GRAY}"'\1'"${NC}"'/g' \
        )"
    echo -en "${colorized_markdown}"
    return 0;
}

# Display usage information
usage() {
    local help_file help_content
    help_file="${GITXFLOW_DIR}/docs/Command-line Reference.md"
    [[ -f "${help_file}" ]] || die "Cannot locate help file: '${help_file}'."
    help_content="$(<"${help_file}")"
    [[ "${help_content}" =~ .?##[[:blank:]]*git[[:blank:]]*xflow[[:blank:]]*$1[[:blank:]]*$2[[:cntrl:]]*([^#]*)## ]] || \
    [[ "${help_content}" =~ .?##[[:blank:]]*git[[:blank:]]*xflow[[:blank:]]*$1[[:cntrl:]]*([^#]*)## ]] || \
    [[ "${help_content}" =~ .?##[[:blank:]]*git[[:blank:]]*xflow[[:cntrl:]]*([^#]*)## ]] || return 1;
    help_content="${BASH_REMATCH[1]}"
    echo -e "$(colorize_markdown "${help_header}\n${help_content}")"
}

# Display legal terms
notice() {
    info "git-xflow, v${GITXFLOW_VERSION}, Copyright (C) 2016, Jérémy WALTHER."
    trace "This program comes with ABSOLUTELY NO WARRANTY; for details type 'git xflow -l'."
    trace "This is free software, and you are welcome to redistribute it"
    trace "under certain conditions; type 'git xflow -l' for details."
    echo
    info "For help, type 'git xflow -h'."
    info "For more information, please visit: <https://github.com/golflima/git-xflow>."
}