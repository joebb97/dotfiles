# Project Conventions

- Do not add `defaults/` directories to Ansible roles unless explicitly asked. Most roles in this project are small and keep role-specific constants in `tasks/main.yml` when needed.
- Use short Ansible module and plugin names, such as `copy` and `first_found`, instead of fully qualified `ansible.builtin.*` names.
