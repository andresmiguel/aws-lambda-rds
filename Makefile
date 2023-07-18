install-dependencies:
	mvn clean install -DskipTests

build: install-dependencies
	sam build --config-file samconfig.toml

deploy:
	sam deploy --config-file samconfig.toml

build-deploy: build deploy
