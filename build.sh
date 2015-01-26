#!/bin/bash

# Remove old Gem
rm -f *.gem

# Build new gem
gem build packetnom.gemspec

# Push New Gem
gem push packetnom*.gem