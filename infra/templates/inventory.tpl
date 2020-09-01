---
tonos:
  hosts:
    ton-node:
      ansible_connection: ssh
      ansible_host: ${tonos_ip}
      ansible_user: ${tonos_user}
      git_ssh_id_path: ${git_ssh_id_path}
      git_server_repos:
      - tonos-config
