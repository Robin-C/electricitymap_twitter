To run, you must have an .env file in base directory like this:

```
AUTH_ELECTRICITYMAP=xyz
TWEETER_BEARER_TOKEN=xyz
TWEETER_CONSUMMER_KEY=xyz
TWEETER_CONSUMMER_SECRET=xyz
TWEETER_ACCESS_TOKEN=xyz
TWEETER_ACCESS_TOKEN_SECRET=xyz
```

If you do not have credentials, dm on [twitter](https://twitter.com/adz122) and I'll help you get set up.

To run: `docker-compose up`

As of right now, the container runs every 6 hours with crontab on a private server.