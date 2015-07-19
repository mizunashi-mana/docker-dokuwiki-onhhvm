DOKU_APP_NAME='mydokuwiki-app'
DOKU_DATA_NAME='mydokuwiki-data'

all: build

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   1. make build        - build the dokuwiki image"
	@echo "   2. make quickstart   - start dokuwiki"
	@echo "   3. make stop         - stop dokuwiki"
	@echo "   4. make logs         - view logs"
	@echo "   5. make purge        - stop and remove the container"

build:
	@docker build --tag=${USER}/dokuwiki .

quickstart:
	@echo "Starting dokuwiki container..."
	@docker run --name=${DOKU_APP_NAME} -d \
		mizunashi/dokuwiki:latest
	@docker run --name=${DOKU_DATA_NAME} -d \
		--volumes-from=${DOKU_APP_NAME} \
		busybox
	@echo "Please be patient. This could take a while..."
	@echo "access http://localhost/install.php"
	@echo "Type 'make logs' for the logs"

stop:
	@echo "Stopping dokuwiki app..."
	@docker stop ${DOKU_APP_NAME} >/dev/null
	@echo "Stopping dokuwiki data..."
	@docker stop ${DOKU_DATA_NAME} >/dev/null

purge: stop
	@echo "Removing stopped containers..."
	@docker rm -v ${DOKU_APP_NAME} >/dev/null
	@docker rm -v ${DOKU_DATA_NAME} >/dev/null

logs:
	@docker logs -f ${DOKU_APP_NAME}
