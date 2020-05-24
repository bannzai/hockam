DOCKER_SERVICE_RAILS?=rails

.PHONY: clean
clean:
	docker-compose rm

.PHONY: compose
compose:
	docker-compose build --no-cache
	docker-compose run $(DOCKER_SERVICE_RAILS) yarn install
	docker-compose run $(DOCKER_SERVICE_RAILS) bin/rake db:create db:migrate db:seed
	docker-compose up

.PHONY: up
up:
	docker-compose up

.PHONY: up
clean:
	rm -rf tmp/cache/bootsnap-*
