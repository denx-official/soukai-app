総会の出席をとるためのアプリです

Ruby on Rails チュートリアル(http://railstutorial.jp/) を改造して作りました

## Docker

### 開発環境

```sh
docker-compose up -d

# setup
docker exec -it soukai-rails /bin/bash -c "bin/rake db:setup"

# migrate
docker exec -it soukai-rails /bin/bash -c "bin/rake db:migrate"

# seeder
docker exec -it soukai-rails /bin/bash -c "bin/rake db:seed"
```

### デプロイ

<!-- ```sh
heroku login

heroku container:login
heroku container:push --app denx-soukai-app web
heroku container:release web
``` -->

## 参考

- [【MySQL】MySQL 8 でユーザー作成しGRANTで権限追加する際にエラーが発生 - Qiita](https://qiita.com/namari/items/53c462840b802f10a0cd)
- [MySQLの認証プラグインを変更する方法(caching_sha2_password) - Qiita](https://qiita.com/shungo_m/items/5363c16b698ef6310014)
- [【解決】MySQLでAccess denied for userが出た時に対処法 | やとらぼ](https://yart-lab.net/mysqlaccess-denied-for-user/)
