.PHONY: up down rebuild logs

up:
	docker-compose up --build

down:
	docker-compose down

rebuild:
	docker-compose down
	docker-compose build
	docker-compose up -d

logs:
	docker-compose logs -f n8n
