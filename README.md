# Ansible Role: Node

[![Build Status](https://travis-ci.org/polymimetic/ansible-role-node.svg?branch=master)](https://travis-ci.org/polymimetic/ansible-role-node)
[![Release](https://img.shields.io/github/release/polymimetic/ansible-role-node.svg?style=flat-square)](https://github.com/polymimetic/ansible-role-node/releases)
[![License: MIT](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg)](https://opensource.org/licenses/MIT)
[![Ansible Galaxy](https://img.shields.io/badge/galaxy-polymimetic.node-blue.svg?style=flat)](https://galaxy.ansible.com/polymimetic/node/)

Installs [Node.js](https://nodejs.org) and [npm](https://www.npmjs.com) for GalliumOS.

## Requirements

No requirements.

## Dependencies

No dependencies.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

    node_version: "6.x"

The Node.js version to install. "6.x" is the default and works on most supported OSes. Other versions such as "0.12", "4.x", "5.x", "8.x", etc. should work as well.

    node_dependencies:
      - apt-transport-https
      - build-essential
      - libssl-dev
      - git
      - curl

Array of apt packaage dependencies needed to install Node.js.

    node_install_type: ppa

Node installation type. Using `ppa` will install Node.js via [Nodesource](https://github.com/nodesource/distributions). Using `nvm` will install Node.js via [Node Version Manager](https://github.com/creationix/nvm).

    node_user: "{{ ansible_ssh_user }}"

The user for whom the npm packages will be installed can be set here, this defaults to `ansible_user`.

#### Node Version Manager (NVM) Variables

These Ansible variables are only used when installing Node.js via Node Version Manager.

    nvm_working_path: "/home/{{ node_user }}"

The Node Version Manager working directory. Defaults to the main user's home folder.

    nvm_dest: "{{ nvm_working_path }}/.nvm"

Destination of the NVM main destination directory.

    nvm_version: "v0.33.6"

The version of NVM to install. Node Version Manager version numbers can be found on the [NVM Releases](https://github.com/creationix/nvm/releases) page.

    nvm_default_node_version: "8.9.1"

Set the default node version for NVM to install.

    nvm_node_versions: 
      - "{{nvm_default_node_version}}"

Array of node versions to install via NVM.

#### Node Package Manager (NPM) Variables

These Anasible variables are used when installing and configuring Node.js packages from NPM.

    npm_config_prefix: "/usr/local/lib/npm"

The global installation directory. This should be writeable by the `node_user`.

    npm_config_unsafe_perm: "false"

Set to true to suppress the UID/GID switching when running package scripts. If set explicitly to false, then installing as a non-root user will fail.

    npm_global_packages: []

A list of npm packages with a `name` and (optional) `version` to be installed globally. For example:

    npm_global_packages:
      # Install a specific version of a package.
      - name: jslint
        version: 0.9.3
      # Install the latest stable release of a package.
      - name: node-sass
      # This shorthand syntax also works (same as previous example).
      - node-sass
<!-- code block separator -->

    nodejs_package_json_path: ""

Set a path pointing to a particular `package.json` (e.g. `"/var/www/app/package.json"`). This will install all of the defined packages globally using Ansible's `npm` module.

## Example Playbook

To run the role, include it as follows:

    - hosts: all
      vars:
        npm_global_packages:
          - node-sass
          - name: jslint
            version: 0.9.6
          - name: yo
      roles:
         - { role: polymimetic.node, x: 42 }

## Credits

This role takes inspiration from the following Ansible roles:

- [nodesource.node](https://github.com/nodesource/ansible-nodejs-role)
- [geerlingguy.nodejs](https://github.com/geerlingguy/ansible-role-nodejs)
- [AerisCloud.nodejs](https://github.com/AerisCloud/ansible-nodejs)
- [sansible.nodejs](https://github.com/sansible/nodejs)
- [Stouts.nodejs](https://github.com/Stouts/Stouts.nodejs)
- [tersmitten.nodejs](https://github.com/Oefenweb/ansible-nodejs)
- [leanbit.nvm](https://github.com/leanbit/ansible-nvm)

## License

This software package is licensed under the [MIT License](https://opensource.org/licenses/MIT). See the [LICENSE](./LICENSE) file for details.

## Author Information

This role was created in 2017 by [Polymimetic](https://github.com/polymimetic).

* ansible-role-node generated using [ansible-role-skeleton](https://github.com/polymimetic/ansible-role-skeleton)