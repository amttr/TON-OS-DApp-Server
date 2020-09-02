# What it lacks

- [docker-compose.yml](./docker-compose.yml) requires Chronograf authentication-related modifications: look at comments and replace "..." in "environment" section;
- when services are up, before doing anything else, execute this:
    ```shell
    $ docker-compose exec influxdb influx --execute "CREATE USER \"telegraf\" WITH PASSWORD 'passw0rd' WITH ALL PRIVILEGES"
    ```
- Telegraf statsd input is activated and accessible on 8125/udp port