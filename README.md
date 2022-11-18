# Custom Kong

## Installation
1. Clone this repo
2. Start Project

```bash
1. docker network create kong-net


2. docker run -d --name kong-database \
               --network=kong-net \
               -p 5432:5432 \
               -e "POSTGRES_USER=kong" \
               -e "POSTGRES_DB=kong" \
               -e "POSTGRES_PASSWORD=kong" \
               postgres:9.6


3. docker run --rm \
     --network=kong-net \
     -e "KONG_DATABASE=postgres" \
     -e "KONG_PG_HOST=kong-database" \
     -e "KONG_PG_USER=kong" \
     -e "KONG_PG_PASSWORD=kong" \
     -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
     kong:latest kong migrations bootstrap

4. docker run -d --name kong \
     --network=kong-net \
     -e "KONG_DATABASE=postgres" \
     -e "KONG_PG_HOST=kong-database" \
     -e "KONG_PG_USER=kong" \
     -e "KONG_PG_PASSWORD=kong" \
     -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
     -e "KONG_PROXY_ACCESS_LOG=/dev/stdout" \
     -e "KONG_ADMIN_ACCESS_LOG=/dev/stdout" \
     -e "KONG_PROXY_ERROR_LOG=/dev/stderr" \
     -e "KONG_ADMIN_ERROR_LOG=/dev/stderr" \
     -e "KONG_ADMIN_LISTEN=0.0.0.0:8001, 0.0.0.0:8444 ssl" \
     -p 8000:8000 \
     -p 8443:8443 \
     -p 127.0.0.1:8001:8001 \
     -p 127.0.0.1:8444:8444 \
     kong:latest

4.1 
docker run -d --name kong \
     --network=kong-net \
     -e "KONG_DATABASE=postgres" \
     -e "KONG_PG_HOST=kong-database" \
     -e "KONG_PG_USER=kong" \
     -e "KONG_PG_PASSWORD=kong" \
     -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
     -e "KONG_PROXY_ACCESS_LOG=/dev/stdout" \
     -e "KONG_ADMIN_ACCESS_LOG=/dev/stdout" \
     -e "KONG_PROXY_ERROR_LOG=/dev/stderr" \
     -e "KONG_ADMIN_ERROR_LOG=/dev/stderr" \
     -e "KONG_ADMIN_LISTEN=0.0.0.0:8001, 0.0.0.0:8444 ssl" \
     -p 8000:8000 \
     -p 8443:8443 \
     -p 127.0.0.1:8001:8001 \
     -p 127.0.0.1:8444:8444 \
     kong-custom


5. docker run -d -p 1337:1337 --network=kong-net --name konga -v /var/data/kongadata:/app/kongadata -e "NODE_ENV=development" pantsel/konga

5.1 docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' {kong container id}


6.   
docker run -it -d \
     -p 8080:8080 \
     --network=kong-net \
     --name wiremock-01 \
     -v $PWD/.wiremock/wiremock-01:/home/wiremock/mappings \
     wiremock/wiremock:2.35.0

     docker run -it -d \
     -p 8081:8080 \
     --network=kong-net \
     --name wiremock-02 \
     -v $PWD/.wiremock/wiremock-02:/home/wiremock/mappings \
     wiremock/wiremock:2.35.0


```

docker stop kong-database
docker rm kong-database
docker stop kong
docker rm kong
docker stop konga
docker rm konga


## Kong Plugin Development
1. Create plugin folder at lua-plugins/plugins/lua-my-plugin
3. Register your plugin at lua-plugins/plugins/lua-plugins-0.1.0-1.rockspec

    3.1 Append your plugin to build.modules
    
    ```
    ['kong.plugins.lua-my-plugin.handler'] = 'plugins/lua-my-plugin/handler.lua',
    ['kong.plugins.lua-my-plugin.schema'] = 'plugins/lua-my-plugin/schema.lua'
    ```
    3.2 Append lua dependencies to dependencies
    ```
    dependencies = {
      'lua-resty-rsa',
      'lua-resty-nettle',
      'lua-resty-env',
      'lua-resty-jwt',
      'lua-my-dependency' 
    }
    ```
    Lua dependencies
    https://luarocks.org/


    3.3 Append your plugin name to Dockerfile
    ```
    ENV KONG_PLUGINS=bundled,lua-decrypt,lua-white-list,lua-create-scope,lua-encrypt,lua-validate-scope,lua-registration-grant,lua-decrypt-token,lua-encrypt-token,lua-my-plugin
    ```

    3.4 Append your new ENV to Dockerfile
    ```
    ENV KONG_PLUGINS=bundled,lua-decrypt,lua-white-list,lua-create-scope,lua-encrypt,lua-validate-scope,lua-registration-grant,lua-decrypt-token,lua-encrypt-token,lua-revoke-token
    ```

