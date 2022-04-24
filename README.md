総会の出席をとるためのアプリです

Ruby on Rails チュートリアル(http://railstutorial.jp/) を改造して作りました

## Docker

### 開発環境

```sh
docker-compose up -d

# migrate
docker exec -it soukai-app /bin/bash -c "bin/rake db:migrate"

# seeder
docker exec -it soukai-app /bin/bash -c "bin/rake db:seed"
```

### デプロイ

```sh
heroku login

heroku container:login
heroku container:push --app denx-soukai-app web
heroku container:release web
```
