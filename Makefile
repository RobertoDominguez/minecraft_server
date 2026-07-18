PROJECT_NAME=minecraft
CONTAINER=minecraft-java

start:
	docker compose up -d

stop:
	docker compose down

restart:
	docker compose restart minecraft

recreate:
	docker compose down
	docker compose up -d --force-recreate

pull:
	docker compose pull
	docker compose up -d

logs:
	docker compose logs -f minecraft

status:
	@docker ps --filter "name=$(CONTAINER)" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

console:
	docker exec -it $(CONTAINER) rcon-cli

attach:
	docker compose attach minecraft

version:
	@docker exec $(CONTAINER) printenv VERSION
	@docker exec $(CONTAINER) printenv TYPE
	@docker exec $(CONTAINER) printenv FORGE_VERSION

players:
	docker exec $(CONTAINER) rcon-cli list

save:
	docker exec $(CONTAINER) rcon-cli save-all

say:
ifndef MESSAGE
	$(error Debes indicar MESSAGE. Ejemplo: make say MESSAGE="Hola jugadores")
endif
	docker exec $(CONTAINER) rcon-cli "say $(MESSAGE)"

op-add:
ifndef USER
	$(error Debes indicar USER. Ejemplo: make op-add USER=agente0333)
endif
	docker exec $(CONTAINER) rcon-cli "op $(USER)"

op-remove:
ifndef USER
	$(error Debes indicar USER. Ejemplo: make op-remove USER=agente0333)
endif
	docker exec $(CONTAINER) rcon-cli "deop $(USER)"

whitelist-on:
	docker exec $(CONTAINER) rcon-cli "whitelist on"

whitelist-off:
	docker exec $(CONTAINER) rcon-cli "whitelist off"

whitelist-add:
ifndef USER
	$(error Debes indicar USER. Ejemplo: make whitelist-add USER=agente0333)
endif
	docker exec $(CONTAINER) rcon-cli "whitelist add $(USER)"

whitelist-remove:
ifndef USER
	$(error Debes indicar USER. Ejemplo: make whitelist-remove USER=agente0333)
endif
	docker exec $(CONTAINER) rcon-cli "whitelist remove $(USER)"

whitelist-list:
	docker exec $(CONTAINER) rcon-cli "whitelist list"

superadmin:
ifndef USER
	$(error Debes indicar USER. Ejemplo: make superadmin USER=agente0333)
endif
	docker exec $(CONTAINER) rcon-cli "op $(USER)"
	docker exec $(CONTAINER) rcon-cli "whitelist add $(USER)"
	docker exec $(CONTAINER) rcon-cli "whitelist on"
	docker exec $(CONTAINER) rcon-cli "whitelist reload"

stop-server:
	docker exec $(CONTAINER) rcon-cli stop

clean:
	docker compose down
	rm -rf data/*