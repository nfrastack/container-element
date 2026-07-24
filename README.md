# nfrastack/container-element

## About

This repository will build a container for [Element Web](https://www.element.io), to connect to a Matrix Homeserver.
There are custom patches applied to resolve some issues that have appeared in the recent 1.12.x series affecting usage when using Window Managers and multiple screens.

## Maintainer

* [Nfrastack](https://www.nfrastack.com)

## Table of Contents

* [About](#about)
* [Maintainer](#maintainer)
* [Table of Contents](#table-of-contents)
* [Installation](#installation)
  * [Prebuilt Images](#prebuilt-images)
  * [Quick Start](#quick-start)
  * [Persistent Storage](#persistent-storage)
* [Configuration](#configuration)
  * [Environment Variables](#environment-variables)
* [Maintenance](#maintenance)
  * [Shell Access](#shell-access)
* [Support & Maintenance](#support--maintenance)
* [License](#license)
* [References](#references)

## Installation

### Prebuilt Images

Feature limited builds of the image are available on the [Github Container Registry](https://github.com/nfrastack/container-element/pkgs/container/container-element) and [Docker Hub](https://hub.docker.com/r/nfrastack/element).

To unlock advanced features, one must provide a code to be able to change specific environment variables from defaults. Support the development to gain access to a code.

To get access to the image use your container orchestrator to pull from the following locations:

```
ghcr.io/nfrastack/container-element:(image_tag)
docker.io/nfrastack/element:(image_tag)
```

Image tag syntax is:

`<image>:<optional tag>`

Example:

`ghcr.io/nfrastack/container-element:latest` or

`ghcr.io/nfrastack/container-element:1.0`

* `latest` will be the most recent commit
* An optional `tag` may exist that matches the [CHANGELOG](CHANGELOG.md) - These are the safest

Have a look at the container registries and see what tags are available.

#### Multi-Architecture Support

Images are built for `amd64` by default, with optional support for `arm64` and other architectures.

### Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [compose.yml](examples/compose.yml) that can be modified for your use.

* Map [persistent storage](#persistent-storage) for access to configuration and data files for backup.
* Set various [environment variables](#environment-variables) to understand the capabilities of this image.

### Persistent Storage

The following directories/files should be mapped for persistent storage in order to utilize the container effectively.

| Folder    | Description         |
| --------- | ------------------- |
| `/config` | Configuration Files |

### Environment Variables

#### Base Images used

This image relies on a customized base image in order to work.
Be sure to view the following repositories to understand all the customizable options:

| Image                                                   | Description     |
| ------------------------------------------------------- | --------------- |
| [OS Base](https://github.com/nfrastack/container-base/) | Base Image      |
| [Nginx](https://github.com/nfrastack/container-nginx/)  | Webserver Image |

Below is the complete list of available options that can be used to customize your installation.

* Variables showing an 'x' under the `Advanced` column can only be set if the containers advanced functionality is enabled.

#### General Settings

| Variable      | Description                                           | Default       | Advanced |
| ------------- | ----------------------------------------------------- | ------------- | -------- |
| `CONFIG_FILE` | Config File                                           | `config.json` |          |
| `CONFIG_PATH` | Config Path                                           | `/config/`    |          |
| `SETUP_MODE`  | Generate configuration based on environment variables | `AUTO`        |          |

#### Application Options

| Variable                             | Description | Default                                                                     | Advanced |
| ------------------------------------ | ----------- | --------------------------------------------------------------------------- | -------- |
| `BRAND`                              |             | `Element`                                                                   |          |
| `BUG_REPORT_URL`                     |             | `https://element.io/bugreports/submit`                                      |          |
| `CALL_BRAND`                         |             | `Element Call`                                                              |          |
| `CALL_EXCLUSIVE`                     |             | `false`                                                                     |          |
| `CALL_URL`                           |             | `https://call.element.io`                                                   |          |
| `CALL_USER_LIMIT`                    |             | `99`                                                                        |          |
| `DEFAULT_COUNTRY_CODE`               |             | `US`                                                                        |          |
| `DEFAULT_DEVICE_DISPLAY_NAME`        |             | `tiredofit`                                                                 |          |
| `DEFAULT_ENABLE_BREADCRUMBS`         |             | `TRUE`                                                                      |          |
| `DEFAULT_ROOM_FEDERATE`              |             | `TRUE`                                                                      |          |
| `DEFAULT_SHOW_POLLS_BUTTON`          |             | `FALSE`                                                                     |          |
| `DEFAULT_SHOW_STICKERS_BUTTON`       |             | `FALSE`                                                                     |          |
| `DEFAULT_SHOW_WELCOME_CHECKLIST`     |             | `TRUE`                                                                      |          |
| `DEFAULT_THEME`                      |             | `light`                                                                     |          |
| `ENABLE_3PID_LOGIN`                  |             | `FALSE`                                                                     |          |
| `ENABLE_3PID_SERVICES`               |             | `TRUE`                                                                      |          |
| `ENABLE_ADVANCED_ENCRYPTION`         |             | `TRUE`                                                                      |          |
| `ENABLE_ADVANCED_SETTINGS`           |             | `TRUE`                                                                      |          |
| `ENABLE_CUSTOM_HOME_SERVER_URL`      |             | `TRUE`                                                                      |          |
| `ENABLE_DEACTIVATE_ACCOUNT`          |             | `TRUE`                                                                      |          |
| `ENABLE_FEEDBACK`                    |             | `TRUE`                                                                      |          |
| `ENABLE_FLAIR`                       |             | `TRUE`                                                                      |          |
| `ENABLE_GUESTS`                      |             | `FALSE`                                                                     |          |
| `ENABLE_IDENTITY_SERVICES`           |             | `TRUE`                                                                      |          |
| `ENABLE_LOGIN_LANGUAGE_SELECTION`    |             | `FALSE`                                                                     |          |
| `ENABLE_REGISTRATION`                |             | `TRUE`                                                                      |          |
| `ENABLE_RELATIVE_DATES`              |             | `TRUE`                                                                      |          |
| `ENABLE_ROOM_HISTORY_SETTINGS`       |             | `TRUE`                                                                      |          |
| `ENABLE_SHARE_QR`                    |             | `TRUE`                                                                      |          |
| `ENABLE_SHARE_SOCIAL`                |             | `TRUE`                                                                      |          |
| `ENABLE_UNVERIFIED_SESSION_REMINDER` |             | `TRUE`                                                                      |          |
| `ENABLE_URL_PREVIEW`                 |             | `TRUE`                                                                      |          |
| `ENABLE_VOIP`                        |             | `TRUE`                                                                      |          |
| `ENABLE_WIDGETS`                     |             | `TRUE`                                                                      |          |
| `HOME_SERVER_URL`                    |             | `https://matrix-client.matrix.org`                                          |          |
| `IDENTITY_SERVER_URL`                |             | `https://vector.im`                                                         |          |
| `INTEGRATIONS_REST_URL`              |             | `https://scalar.vector.im/api`                                              |          |
| `INTEGRATIONS_UI_URL`                |             | `https://scalar.vector.im/`                                                 |          |
| `JITSI_DOMAIN`                       |             | `meet.element.io`                                                           |          |
| `JITSI_SKIP_WELCOME_SCREEN`          |             | `TRUE`                                                                      |          |
| `LOGOUT_REDIRECT_URL`                |             | `null`                                                                      |          |
| `MAP_STYLE_URL`                      |             | `https://api.maptiler.com/maps/streets/style.json?key=fU3vlMsMn4Jb6dnEIFsx` |          |
| `SETTINGS_SHOW_LABS`                 |             | `TRUE`                                                                      |          |
| `SSO_AUTO_LOGIN`                     |             | `FALSE`                                                                     |          |
| `VOIP_OBEY_ASSERTED_IDENTITY`        |             | `FALSE`                                                                     |          |

#### Multi-Domain Options

When `DOMAIN*_HOST` variables are set, the container serves a different `config.json` per virtual host using nginx `map` and `location` snippets. Each domain gets a copy of the base `config.json` with only the per-domain values patched, preserving custom fields like `branding`, `embedded_pages`, etc.

| Variable                         | Description                                         | Advanced |
| -------------------------------- | --------------------------------------------------- | -------- |
| `DOMAIN01_HOST`                  | Hostname for this domain (e.g. `talk.tiredofit.ca`) | x        |
| `DOMAIN01_URL`                   | Homeserver base URL                                 | x        |
| `DOMAIN01_BRAND`                 | Brand name                                          | x        |
| `DOMAIN01_SERVER_NAME`           | Homeserver server name                              | x        |
| `DOMAIN01_PERMALINK_PREFIX`      | Permalink prefix (default: `https://$HOST`)         | x        |
| `DOMAIN01_BRANDING_WELCOME_BG`   | Welcome background image URL                        | x        |
| `DOMAIN01_BRANDING_LOGO`         | Auth header logo URL                                | x        |
| `DOMAIN01_WELCOME_URL`           | Embedded welcome page URL                           | x        |
| `DOMAIN01_HOME_URL`              | Embedded home page URL                              | x        |

Repeat with `DOMAIN02_*`, `DOMAIN03_*` for additional domains (max 3) unless using advanced image.

* * *

## Maintenance

### Shell Access

For debugging and maintenance, `bash` and `sh` are available in the container.

## Support & Maintenance

* For community help, tips, and community discussions, visit the [Discussions board](/discussions).
* For personalized support or a support agreement, see [Nfrastack Support](https://nfrastack.com/).
* To report bugs, submit a [Bug Report](issues/new). Usage questions will be closed as not-a-bug.
* Feature requests are welcome, but not guaranteed. For prioritized development, consider a support agreement.
* Updates are best-effort, with priority given to active production use and support agreements.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
