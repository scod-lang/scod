#
#   Copyright (C) 2019 SCOD Organization <https://scod-lang.org>
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

TARGET = scod

UPDATE_PATH  = .
UPDATE_PATH += lib/pass
UPDATE_PATH += lib/scod
UPDATE_PATH += app/scodc

UPDATE_FILE  = .clang-format
UPDATE_FILE += .github/workflows/build.yml
UPDATE_FILE += .github/workflows/nightly.yml
UPDATE_FILE += .ycm_extra_conf.py

CONFIG  = lib/stdhl
ifeq ($(wildcard $(CONFIG)/.cmake/.*),)
  CONFIG = .
endif

INCLUDE = $(CONFIG)/.cmake/config.mk
include $(INCLUDE)


clean-deps:
	rm -rf app/*/obj lib/*/obj lib/*/build


doxy: export PROJECT_NUMBER:=$(shell git describe --always --tags --dirty)

.PHONY: doxy
doxy:
	@echo "$(PROJECT_NUMBER)"
	@mkdir -p obj
	@doxygen


# grammar:
# 	@for i in `grep "#+html: {{page>.:grammar:" lib/casm-fe/src/various/Grammar.org | sed "s/#+html: {{page>.:grammar:/doc\/language\/grammar\//g" | sed "s/&noheader&nofooter}}/.org/g"`; do if [ ! -f $$i ]; then echo "Documentation of '$$i' is missing!"; fi; done
# 
# 
# GITHUB_PATH  = $(subst ., $(CONFIG), $(UPDATE_PATH))
# GITHUB_DIR   = .github
# GITHUB_FILE  = CODE_OF_CONDUCT.md
# GITHUB_FILE += CODE_OF_CONDUCT.org
# GITHUB_FILE += CONTRIBUTING_SUBMODULE.org
# GITHUB_FILE += ISSUE_TEMPLATE.org
# GITHUB_FILE += PULL_REQUEST_TEMPLATE.org
# 
# github: $(GITHUB_FILE:%=github-%)
# 
# define github-command
#   $(eval GH_SRC := $(GITHUB_DIR)/$(2))
#   $(eval GH_DST := $(1)/$(GH_SRC))
# #  $(info "-- Generating '$(GH_SRC)' -> '$(GH_DST)'")
#   $(shell cp -vf $(GH_SRC) $(GH_DST))
# endef
# 
# github-%:
# 	$(foreach path,$(GITHUB_PATH),$(call github-command,$(path),$(patsubst github-%,%,$@)))
