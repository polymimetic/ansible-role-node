# Ansible Role: Node

[![Build Status](https://travis-ci.org/polymimetic/ansible-role-node.svg?branch=master)](https://travis-ci.org/polymimetic/ansible-role-node)
[![Release](https://img.shields.io/github/release/polymimetic/ansible-role-node.svg?style=flat-square)](https://github.com/polymimetic/ansible-role-node/releases)
[![License: MIT](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg)](https://opensource.org/licenses/MIT)
[![Ansible Galaxy](https://img.shields.io/badge/galaxy-polymimetic.node-blue.svg?style=flat)](https://galaxy.ansible.com/polymimetic/node/)

Installs Node.js on Debian/Ubuntu.

## Requirements

No requirements.

## Dependencies

No dependencies.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

    nodejs_version: "6.x"

The Node.js version to install. "6.x" is the default and works on most supported OSes. Other versions such as "0.12", "4.x", "5.x", "6.x", etc. should work on the latest versions of Debian/Ubuntu.

    nodejs_install_npm_user: "{{ ansible_ssh_user }}"

The user for whom the npm packages will be installed can be set here, this defaults to `ansible_user`.

    npm_config_prefix: "/usr/local/lib/npm"

The global installation directory. This should be writeable by the `nodejs_install_npm_user`.

    npm_config_unsafe_perm: "false"

Set to true to suppress the UID/GID switching when running package scripts. If set explicitly to false, then installing as a non-root user will fail.

    nodejs_npm_global_packages: []

A list of npm packages with a `name` and (optional) `version` to be installed globally. For example:

    nodejs_npm_global_packages:
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
        nodejs_npm_global_packages:
          - node-sass
          - name: jslint
            version: 0.9.6
          - name: yo
      roles:
         - { role: polymimetic.node, x: 42 }

## Credits

This role takes inspiration from the following Ansible roles:

- [geerlingguy.nodejs](https://github.com/geerlingguy/ansible-role-nodejs)

## License

This software package is licensed under the [MIT License](https://opensource.org/licenses/MIT). See the [LICENSE](./LICENSE) file for details.

## Author Information

This role was created in 2017 by [Polymimetic](https://github.com/polymimetic).

* ansible-role-node generated using [ansible-role-skeleton](https://github.com/polymimetic/ansible-role-skeleton)