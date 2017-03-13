create-ssh-keypair:
	cd terraform && mkdir ssh
	cd terraform/ssh && ssh-keygen -t rsa -f cluster.pem -N ""

clean:
	rm -rf terraform/ssh

plan:
	cd terraform && terraform plan

apply:
	cd terraform && terraform apply

make destroy:
	cd terraform && terraform destroy --force