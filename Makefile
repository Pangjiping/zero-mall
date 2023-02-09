dev-dep:
	go install github.com/zeromicro/go-zero/tools/goctl@latest

orch-golang:
	cd ./orch && \
	docker-compose up -d golang

orch-base:
	cd ./orch && \
	docker-compose up -d golang dtm etcd mysql redis

orch-all:
	cd ./orch && \
	docker-compose up -d

user-model:
	cd ./mall/service/user && \
	goctl model mysql ddl -src ./model/user.sql -dir ./model -c

user-api:
	cd ./mall/service/user && \
	goctl api go -api ./api/user.api -dir ./api

user-rpc:
	cd ./mall/service/user/rpc && \
	goctl rpc protoc user.proto --go_out=./types --go-grpc_out=./types --zrpc_out=.

user:
	user-model
	user-api
	user-rpc

start-user-rpc:
	cd ./mall/service/user/rpc && \
	go run user.go -f etc/user.yaml

start-user-api:
	cd ./mall/service/user/api && \
	go run user.go -f etc/user.yaml

start-user:
	start-user-rpc
	start-user-api

.PHONY: dev-dep orch-golang orch-base orch-all user-model user-api user-rpc user start-user-rpc start-user-api start-user