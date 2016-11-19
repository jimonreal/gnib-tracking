# GNIB Tracking

GNIB Tracking is a project that follow the INIS Appointment Booking System for Imigration Registration of Dublin and notify their users when new appointments are available. It runs over Docker and can be published easily by Rancher.

## Installation

Before you get started, the Docker environment needs to be installed.

### Launching

    docker-compose up -d

The UI are available on `http://localhost/`

## Publishing

Before you get published, the Rancher environment needs to be installed.

### Deploy

1. Set-up the `RANCHER_URL`, `RANCHER_ACCESS_KEY` and `RANCHER_SECRET_KEY` variables
2. Rename the file `production.env.sample` to `production.env` and fill the gaps
3. Run `rancher-compose up -d --pull --force-upgrade`