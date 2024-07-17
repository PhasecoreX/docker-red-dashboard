# Red-Dashboard
The newest Red-Dashboard ([AAA3A fork](https://github.com/AAA3A-AAA3A/Red-Dashboard)) in a convenient multi-arch container

[![Docker Pulls](https://img.shields.io/docker/pulls/phasecorex/red-dashboard)](https://hub.docker.com/r/phasecorex/red-dashboard)
[![Build Status](https://github.com/PhasecoreX/docker-red-dashboard/workflows/build/badge.svg)](https://github.com/PhasecoreX/docker-red-dashboard/actions?query=workflow%3Abuild)
[![Chat Support](https://img.shields.io/discord/608057344487849989)](https://discord.gg/QzdPp2b)
[![BuyMeACoffee](https://img.shields.io/badge/buy%20me%20a%20coffee-donate-orange)](https://buymeacoff.ee/phasecorex)
[![PayPal](https://img.shields.io/badge/paypal-donate-blue)](https://paypal.me/pcx)

## Quick Start
Follow the install instructions from [the official documentation](https://red-web-dashboard.readthedocs.io/en/latest/index.html), but start from the [Installing Companion Cog](https://red-web-dashboard.readthedocs.io/en/latest/configuration_guides/installing_companion_cog.html) step. Once you have made it to the "Running the Webserver" step, just run this container instead and link it to your [Red-DiscordBot](https://github.com/PhasecoreX/docker-red-discordbot) container:

```
docker run -v /local/folder/for/persistence:/data --network=container:red-discordbot phasecorex/red-dashboard
```

You will have to change the `red-discordbot` portion of the `--network` argument to be whatever the name is of your [Red-DiscordBot](https://github.com/PhasecoreX/docker-red-discordbot) container. Also make sure you're running Red-DiscordBot with the `--rpc` flag enabled.

## Docker-Compose

Here's an example docker-compose.yml with both Red-DiscordBot and Red-Dashboard:

```
services:
  red-discordbot:
    image: phasecorex/red-discordbot:extra-audio
    container_name: red-discordbot
    restart: always
    volumes:
      - /local/folder/for/persistence/red-discordbot:/data
    environment:
      - TZ=America/Detroit
      - PUID=1000
      - EXTRA_ARGS=--rpc

  red-dashboard:
    image: phasecorex/red-dashboard:latest
    container_name: red-dashboard
    restart: always
    network_mode: "service:red-discordbot"
    depends_on:
      - red-discordbot
    volumes:
      - /local/folder/for/persistence/red-dashboard:/data
    environment:
      - TZ=America/Detroit
      - PUID=1000
```

Notice that the Red-DiscordBot container has an added `EXTRA_ARGS=--rpc` environment variable, and the dashboard container has `network_mode: "service:red-discordbot"`.

## Reverse Proxy

Since the dashboard is using the network mode of the Red-DiscordBot container, the dashboard will be accessible from `http://<red-discordbot-container-name>:42356`. Your reverse proxy will have to point at that URL to work, NOT the dashboard container! An example for Caddy in a container in the same network as the Red-DiscordBot container would be:

```
your.domain.com {
    reverse_proxy <red-discordbot-container-name>:42356
}
```

## Non-Containerized Red-DiscordBot
I don't really support it, but I think you would have to run the dashboard container in host networking mode? Not sure. Good luck!
