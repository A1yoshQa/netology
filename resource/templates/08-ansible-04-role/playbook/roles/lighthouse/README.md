Role Name
=========

This role can install Lighthouse and nginx on Ubuntu 22.04

Role Variables
--------------

| vars | description |
| ---- | ----------- |
| lighthouse_dir | /etc/lighthouse | Path to directory with lighthouse |
| lighthouse_port | 80 | Port for lighthouse |
| nginx_user_name | root | Username for nginx |

Example Playbook
----------------

    - hosts: servers
      roles:
         - lighthouse

License
-------

MIT

Author Information
------------------

Alexey Nikiforov
