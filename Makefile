# makefile

alpine: ./http/answers ./scripts/provision.sh alpine.json Vagrantfile.template
	rm -rf output-alpine
	packer build -only=alpine -on-error=abort alpine.json
	@echo BOX successfully built!
	
docker: ./http/answers ./scripts/provision.sh alpine-docker.json Vagrantfile.template
	rm -rf output-alpine
	packer build -only=alpine -on-error=abort alpine-docker.json
	@echo BOX successfully built!