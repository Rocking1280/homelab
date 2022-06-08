.PHONY: list-tags list-vars decrypt encrypt

# Let's allow the user to edit ansible vaults in-place instead of flat out decrypting it to reduce risk of pushing it in cleartext to remote repo.
# Even though I've got the git commit hook in place, when the repo name changes for example, and repo is cloned fresh, this poses a problem when forgetting to run `make setup` first and deploying the hook.
# This approach is just far safer than decrypting and encrypting the files themselves below.
edit-vault:
	ansible-vault edit group_vars/all/vault
edit-inventory:
	ansible-vault edit inventory/hosts.ini

# Decrypt all files in this repo
decrypt:
	ansible-vault decrypt group_vars/all/vault inventory/hosts.ini

# Encrypt all files in this repo
encrypt:
	ansible-vault encrypt group_vars/all/vault inventory/hosts.ini

# List variables
list-vars:
	@$(CURDIR)/bin/vars_list.py vars/config.yml group_vars/all/vault.yml $(runargs)

# List the available tags that you can run standalone from the playbook
list-tags:
	@grep 'tags:' playbook_*.yml | grep -v always | awk -F\" '{print $$2}'
