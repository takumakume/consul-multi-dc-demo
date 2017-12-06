run: setup setup_dc_name setup_wan

setup:
	docker-compose down || true
	docker-compose build && docker-compose up -d
	docker-compose ps

setup_dc_name:
	docker cp consul-server/dc-a.json consul-server-a-1:/consul/config/dc.json
	docker cp consul-server/dc-a.json consul-server-a-2:/consul/config/dc.json
	docker cp consul-server/dc-a.json consul-server-a-3:/consul/config/dc.json
	docker cp consul-server/dc-a.json proxy-server-1:/etc/consul.d/dc.json
	docker cp consul-server/dc-a.json proxy-server-2:/etc/consul.d/dc.json
	docker cp consul-server/dc-a.json proxy-server-3:/etc/consul.d/dc.json
	docker cp consul-server/dc-b.json consul-server-b-1:/consul/config/dc.json
	docker cp consul-server/dc-b.json consul-server-b-2:/consul/config/dc.json
	docker cp consul-server/dc-b.json consul-server-b-3:/consul/config/dc.json
	docker cp consul-server/dc-b.json web-server-1:/etc/consul.d/dc.json
	docker cp consul-server/dc-b.json web-server-2:/etc/consul.d/dc.json
	docker cp consul-server/dc-b.json web-server-3:/etc/consul.d/dc.json
	docker-compose restart

setup_wan:
	docker-compose exec consul-server-b-1 consul join -wan consul-server-a-1
