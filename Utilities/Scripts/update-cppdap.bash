#!/usr/bin/env bash

set -e
set -x
shopt -s dotglob

readonly name="cppdap"
readonly ownership="cppdap Upstream <kwrobot@kitware.com>"
readonly subtree="Utilities/cmcppdap"
readonly repo="https://github.com/google/cppdap.git"
readonly tag="main"
readonly shortlog=false
readonly paths="
  CMakeLists.txt
  LICENSE
  include
  src
"

extract_source () {
    git_archive

    pushd "${extractdir}/${name}-reduced"
    echo "* -whitespace" > .gitattributes
    echo -e "'cppdap' is a C++11 library implementation of the Debug Adapter Protocol
version 88e8952, Dec 23, 2021\nCopyright Google LLC\n\nThis product includes software developed at Google." > NOTICE
    echo -e "\ninstall(FILES NOTICE DESTINATION \${CMAKE_DOC_DIR}/cmcppdap)" >> CMakeLists.txt
    sed -i 's/cmake_minimum_required(VERSION 2.8)//' CMakeLists.txt
    popd
}

. "${BASH_SOURCE%/*}/update-third-party.bash"
