Docker Ansible role
===================

Install and configures a Docker host with local storage and no overlay network.

Role Tags
---------

 * install
 * configure
 * deploy
 * test

Role Variables
--------------

 * docker_version (see vars/main.yml for supported/tested versions)
 * docker_selinux_enabled
 * docker_log_level

Example Playbook
----------------

    - hosts: localhost
      roles:
         - role: docker
           tags: ['install','test']

License
-------

MIT
