総会の出席をとるためのアプリです

Ruby on Rails チュートリアル(http://railstutorial.jp/) を改造して作りました

## Docker

### 開発環境

```sh
sudo docker-compose up -d

# seeder (初回のみ)
sudo docker exec -it soukai-app-dev /bin/bash -c "bin/rake db:seed"
```
