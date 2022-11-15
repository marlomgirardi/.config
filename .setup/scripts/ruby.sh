#!/bin/bash

#####
# Install Ruby
#####

if not_exists ruby; then
  brew install ruby
fi

export GEM_HOME="$HOME/.config/.data/gem"

#####
# Install from Gemfile
#####

gem install colorls
