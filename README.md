総会の出席をとるためのアプリです

Ruby on Rails チュートリアル(http://railstutorial.jp/) を改造して作りました

# Docker

## Setup

```sh
# イメージをビルド
sudo docker build -f ./Dockerfile -t soukai .

# コンテナ作成
sudo docker create --name soukai-app -p 3000:3000 -it soukai
```

## Start & Stop

```sh
# コンテナ起動
sudo docker start -a soukai-app

# 停止
sudo docker stop soukai-app
```
