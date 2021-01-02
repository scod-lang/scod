#
#   Copyright (C) 2019-2021 SCOD Organization <https://scod-lang.org>
#   All rights reserved.
#
#   Developed by: Philipp Paulweber
#                 Emmanuel Pescosta
#                 <https://github.com/scod-lang/scod>
#
#   This file is part of scod.
#
#   scod is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   scod is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with scod. If not, see <http://www.gnu.org/licenses/>.
#

set( PROJECT scod )

cmake_minimum_required( VERSION ${CMAKE_VERSION} )

project( ${PROJECT} )
set( CMAKE_VERSION 3.2 )
set( CMAKE_MODULE_PATH ${${PROJECT}_SOURCE_DIR}/.cmake )
include( ${CMAKE_CONFIG_PATH}/LibPackage.cmake )

package_git( ${PROJECT} )
package_git_submodule( libstdhl   master REQUIRED obj   lib/stdhl   )
package_git_submodule( libgtest   master REQUIRED build lib/gtest   )
package_git_submodule( libhayai   master REQUIRED build lib/hayai   )
package_git_submodule( libpass    master REQUIRED obj   lib/pass    )
package_git_submodule( libscod    master REQUIRED obj   lib/scod    )
package_git_submodule( scodc      master REQUIRED obj   app/scodc   )
package_git_deps(
  libgtest>libstdhl
  libhayai>libstdhl
  libstdhl>libpass
  libpass>libscod
  libscod>scodc
  )

include( CPack )
include( FeatureSummary )

#
#
# project
#

add_custom_target( ${PROJECT}
  DEPENDS
    ${PROJECT}-deps
)

#
#
# test
#

add_custom_target( ${PROJECT}-check
  COMMAND
    ${CMAKE_COMMAND} -E copy
    ${CMAKE_SOURCE_DIR}/src/${PROJECT}-test
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT}-check
  WORKING_DIRECTORY
    ${PROJECT_SOURCE_DIR}
)

#
#
# benchmark
#

add_custom_target( ${PROJECT}-run
  COMMAND
    ${CMAKE_COMMAND} -E copy
    ${CMAKE_SOURCE_DIR}/src/${PROJECT}-benchmark
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT}-run
  WORKING_DIRECTORY
    ${PROJECT_SOURCE_DIR}
)

#
#
# install
#

install(
  TARGETS
  EXPORT   ${PROJECT}Targets
  LIBRARY  DESTINATION lib
  ARCHIVE  DESTINATION lib
  RUNTIME  DESTINATION bin
  INCLUDES DESTINATION include
)

#
#
# bundle
#

install(
  DIRECTORY
    app/scodc/obj/install/
  DESTINATION
    "."
    )

#
#
# cmake
#

# install(
#   FILES
#     .cmake/Find${PROJECT}.cmake
#   DESTINATION
#     "share/cmake/Module/${PROJECT}"
#   )

#
#
# build features and checks
#

feature_summary( WHAT
  PACKAGES_NOT_FOUND
  DISABLED_FEATURES
)
