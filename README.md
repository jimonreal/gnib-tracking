# GNIB Tracking

----
## Requirements

Before you get started, the Docker environment needs to be installed

----
## Running

1. Run `docker-compose up -d`
2. Access `http://localhost/` in a web browser

----
## Deploy

1. Set-up the follow environment variables:
	
		RANCHER_URL=<Rancher Server URL>
		RANCHER_ACCESS_KEY=<Access Key>
		RANCHER_SECRET_KEY=<Secret Key>

2. Rename the file `production.env.sample` to `production.env` and fill the gaps
3. Run `rancher-compose up -d --pull --force-upgrade`