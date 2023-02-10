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

start-user-rpc:
	cd ./mall/service/user/rpc && \
	go run user.go -f etc/user.yaml

start-user-api:
	cd ./mall/service/user/api && \
	go run user.go -f etc/user.yaml

product-model:
	cd ./mall/service/product && \
	goctl model mysql ddl -src ./model/product.sql -dir ./model -c

product-api:
	cd ./mall/service/product && \
	goctl api go -api ./api/product.api -dir ./api

product-rpc:
	cd ./mall/service/product/rpc && \
	goctl rpc protoc product.proto --go_out=./types --go-grpc_out=./types --zrpc_out=.

start-product-rpc:
	cd ./mall/service/product/rpc && \
	go run product.go -f etc/product.yaml

start-product-api:
	cd ./mall/service/product/api && \
	go run product.go -f etc/product.yaml

.PHONY: dev-dep orch-golang orch-base orch-all user-model user-api user-rpc user start-user-rpc start-user-api start-user