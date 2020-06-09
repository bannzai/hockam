DOCKER_SERVICE_RAILS?=rails

.PHONY: clean
clean:
	docker-compose rm
	rm -rf tmp/cache/bootsnap-*

.PHONY: compose
compose:
	docker-compose build --no-cache
	docker-compose run $(DOCKER_SERVICE_RAILS) yarn install
	docker-compose run $(DOCKER_SERVICE_RAILS) bin/rake db:create db:seed
	docker-compose run $(DOCKER_SERVICE_RAILS) bundle exec ridgepole -c config/database.yml -E development --apply -f db/Schemafile
	docker-compose up

.PHONY: db
db:
	bundle exec ridgepole -c config/database.yml -E development --apply -f db/Schemafile

.PHONY: up
up:
	docker-compose up
