<p align="center">
  <img src="https://i.imgur.com/qBi3j4o.png" style="image-rendering: pixelated;" "alt="logo" width="20%"/>
</p>
<h1 align="center">
  BBQ
  <img src="https://img.shields.io/badge/Ruby-3.1.2-brightgreen" style="image-rendering: pixelated;" "alt="logo" width="8%"/>
  <img src="https://img.shields.io/badge/Rails-7.0.4-blue" style="image-rendering: pixelated;" "alt="logo" width="8%"/>
</h1>

## Introduction

BBQ is an application that helps to organize events. Create your own event and gather people around you or go to someone else's event. Subscribe to the alert and don't miss anything important. Share your photos and impressions in the comments.

## Instructions

Before launching, you need to configure `credentials.yml.enc`. To do this, delete the `config/credentials.yml.enc` file and run the command:

```
$ EDITOR="vim" rails credentials:edit
```

You can use the vim or nano editor

Next, you need to run the following commands:

```bash
$ bundle
$ rails db:create
$ rails db:migrate
$ bin/dev
```

### Additional features

Create `.env` file in the main directory.

[Yandex API Key](https://yandex.ru/dev/maps/?p=realty) is required for the card to work. Put the key in `.env`:

```
API_KEY_YANDEX: <your Yandex API Key here>
```

If you want to be able to log in using [GitHub OAuth](https://docs.github.com/en/developers/apps/building-oauth-apps/authorizing-oauth-apps) and [Google OAuth](https://developers.google.com/identity/protocols/oauth2?hl=ru), you need to connect the application to the appropriate service. Then specify in `.env`:

```
  GIT_ID: #Your GitHub application key
  GIT_SECRET: #Your GitHub secret key
  
  GOOGLE_ID: #Your Google application key
  GOOGLE_SECRET: #Your Google secret key
```

In the production environment, [Amazon S3](https://aws.amazon.com/ru/s3/) is used to store files. To configure it, add to `.env`:

```
yc:
  access_key_id: #Your Amazon S3 access key
  secret_access_key: #Your Amazon S3 secret key
```

### Database in production

In the `production` environment, you must specify the database login and password in the environment variables `DB_USER`, `DB_NAME` and `DATABASE_PASSWORD` or specify explicitly in `.env`

```
production:
  adapter: postgresql
  user: <%= ENV['DB_USER'] %>
  password: <%= ENV['DB_PASSWORD'] %>
  database: <%= ENV['DB_NAME'] %>
```
