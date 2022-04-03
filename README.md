総会の出席をとるためのアプリです

Ruby on Rails チュートリアル(http://railstutorial.jp/) を改造して作りました

## Docker

### 開発環境

```sh
docker-compose up -d

# migrate
docker exec -it soukai-app-dev /bin/bash -c "bin/rake db:migrate RAILS_ENV=development"

# seeder
docker exec -it soukai-app-dev /bin/bash -c "bin/rake db:seed"
```
