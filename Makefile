include backend/Makefile
include cspell/Makefile
include frontend/Makefile
include schema/Makefile

build:
	@docker compose build

check-all: \
	check-backend \
	check-frontend \
	check-spelling

check-backend: \
	pre-commit

check-test-all: \
	check-all \
	test-all

check-test-backend: \
	pre-commit \
	test-backend

check-test-frontend: \
	check-frontend \
	test-frontend

pre-commit:
	@pre-commit run -a

run:
	@docker compose -f docker/docker-compose-local.yaml build
	@docker compose -f docker/docker-compose-local.yaml up --remove-orphans

test-all: \
	test-nest-app \
	test-schema

test-nest-app: \
	test-backend \
	test-frontend

update-dependencies: \
	update-nest-app-dependencies \
	update-schema-dependencies

update-nest-app-dependencies: \
	update-backend-dependencies \
	update-frontend-dependencies
# kubernates-set-up: \
# Makefile
BACKEND_CONFIG_VARS := \
    DJANGO_ALGOLIA_APPLICATION_REGION \
    DJANGO_ALLOWED_HOSTS \
    DJANGO_CONFIGURATION \
    DJANGO_PUBLIC_IP_ADDRESS

BACKEND_SECRET_VARS := \
    DJANGO_ALGOLIA_APPLICATION_ID \
    DJANGO_ALGOLIA_WRITE_API_KEY \
    DJANGO_SECRET_KEY \
    DJANGO_DB_PASSWORD \
    DJANGO_SLACK_BOT_TOKEN \
    GITHUB_TOKEN

FRONTEND_CONFIG_VARS := \
	VITE_API_URL \
	VITE_ENVIRONMENT \
	VITE_GRAPHQL_URL \
	VITE_GTM_AUTH \
	VITE_GTM_ID \
	VITE_GTM_PREVIEW \
	VITE_IDX_URL \
	VITE_RELEASE_VERSION \
	VITE_SENTRY_DSN

helm-install:
	helm install next ./helm \
		--values=helm/values.yaml \
		--values=helm/values.local \
		$(foreach var,$(BACKEND_CONFIG_VARS),--set backend.config.$(var)=${$(var)}) \
		$(foreach var,$(BACKEND_SECRET_VARS),--set backend.secrets.$(var)=${$(var)}) \
		$(foreach var,$(FRONTEND_CONFIG_VARS),--set frontend.config.$(var)=${$(var)})