#!/bin/bash

#
# builds a production meteor bundle directory
#
set -e

cd $APP_SOURCE_DIR

# Install app deps
printf "\n[-] Running npm install...\n\n"
meteor npm install

# build the bundle
printf "\n[-] Building Meteor application...\n\n"
mkdir -p $APP_BUNDLE_DIR
chown -R node $APP_BUNDLE_DIR
meteor build --unsafe-perm --directory $APP_BUNDLE_DIR

# run npm install in bundle
printf "\n[-] Running npm install in the server bundle...\n\n"
cd $APP_BUNDLE_DIR/bundle/programs/server/
meteor npm install --production

# put the entrypoint script in WORKDIR
mv $BUILD_SCRIPTS_DIR/entrypoint.sh $APP_BUNDLE_DIR/bundle/entrypoint.sh
