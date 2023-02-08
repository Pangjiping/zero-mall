orch-golang:
	cd ./orch && \
	docker-compose up -d golang

orch-base:
	cd ./orch && \
	docker-compose up -d golang dtm etcd mysql redis

orch-all:
	cd ./orch && \
	docker-compose up -d

.PHONY: orch-golang orch-base orch-all