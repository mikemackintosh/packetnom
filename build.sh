#!/bin/bash

# Get new gemver
gemver=$(ruby -e "require 'rubygems'; puts Gem::Specification::load('packetnom.gemspec').version")

# Remove old Gem
rm -f *.gem

# Build new gem
gem build packetnom.gemspec

# Push New Gem
gem push packetnom*.gem

# Tag this version, and push
git tag $gemver
git push --tags