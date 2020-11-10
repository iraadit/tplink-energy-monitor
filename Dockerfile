# ---- Base Image ----
FROM node:alpine AS base
WORKDIR /opt/tplink-monitor

COPY package.json .


# --- Dependency image ---
# install node prod modules etc.
FROM base AS dependencies
WORKDIR /opt/tplink-monitor
RUN npm set progress=false && npm config set depth 0
RUN npm install --only=production
RUN cp -R node_modules prod_node_modules
RUN npm install
RUN npm install typescript -g
COPY tsconfig.json .
COPY src src
RUN tsc
RUN cd src/client && npm run build
RUN mv src/client/build build/client

# ---- Test ----
#FROM dependencies as test
#COPY .eslintrc.json .
#RUN npm run code:lint

# ---- Release ----
FROM base as release

COPY --from=dependencies /opt/tplink-monitor/prod_node_modules ./node_modules
COPY --from=dependencies /opt/tplink-monitor/build .

EXPOSE 3000
CMD ["npm", "start"]
