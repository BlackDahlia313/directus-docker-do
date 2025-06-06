# syntax=docker/dockerfile:1.4

## Black Dahlia was here

###################################################################################################
## Create Your Directus Production Image

FROM directus/directus
USER root
RUN corepack enable \
  && corepack prepare pnpm@9.5 --activate \
  # Currently required, we'll probably address this in the base image in future release
  && chown node:node /directus

EXPOSE 8055

USER node
RUN pnpm install directus-extension-field-actions && pnpm install directus-extension-flow-manager && pnpm config set auto-install-peers true
CMD : \
	&& node /directus/cli.js bootstrap \
	&& node /directus/cli.js start \
	;
