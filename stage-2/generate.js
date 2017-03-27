#!/usr/bin/env node

const fetch = require("node-fetch");
const cheerio = require("cheerio");
const fs = require("fs-extra-promise");
const path = require("path");
const chmod = require("chmod");

const config = require("./config.json");

const buildScriptFactory = toolName =>
  `#!/bin/bash

SDIR="$( cd "$( dirname "\$\{BASH_SOURCE[0]\}" )" && pwd )"

docker build -t vincentriemer/docker-kali:${toolName} $SDIR
docker push vincentriemer/docker-kali:${toolName}
`;

const dockerFileFactory = toolName =>
  `FROM vincentriemer/docker-kali:base
RUN apt-fast update && \\
  apt-fast -y install ${toolName} && \\
  rm -rf /var/lib/apt/lists/*
`;

const commandExecutableFactory = (packageName, commandName) =>
  `#!/bin/bash

SDIR="$( cd "$( dirname "\$\{BASH_SOURCE[0]\}" )" && pwd )"

docker run -it --rm \\
  -e DISPLAY=$DISPLAY \\
  -v /tmp/.X11-unix:/tmp/.X11-unix \\
  -v $SDIR:/kali \\
  vincentriemer/docker-kali:${packageName} \\
  ${commandName} $@
`;

(async () => {
  for (const packageName in config) {
    if (config.hasOwnProperty(packageName)) {
      // Generate docker image building materials for the package
      await fs.outputFile(
        `./images/${packageName}/Dockerfile`,
        dockerFileFactory(packageName)
      );
      await fs.outputFile(
        `./images/${packageName}/build.sh`,
        buildScriptFactory(packageName)
      );

      // Generate executables for each command in the package
      const commands = config[packageName];
      for (const command of commands) {
        const filePath = `../out/${command}`;
        await fs.outputFile(
          filePath,
          commandExecutableFactory(packageName, command),
          { mode: "0777" }
        );
      }
    }
  }
})();
