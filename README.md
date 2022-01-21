# ProjectZomboid Discordbot

ProjectZomboid Serverにホワイトリストを追加するDiscordBOT

# command

/adduser (DMメッセージのみで使用可能）※調整中\
/commands (管理者ロールのみ使用可能）

# Usage


***Docker command***
```
docker run -d --name pz-discordbot \
              -e TOKEN="DISCORDトークンを入力" \
              -e CLIENT_ID="クライアントIDを入力" \
              -e RCON_HOST="RCONホストを入力" \
              -e RCON_PORT="RCONポート番号を入力" \
              -e RCON_PASS="RCONパスワードを入力" \
              -e ADMIN_ROLE_ID="管理者ロールIDを入力"
```

***Docker-compose***
```
version: "3.7"

services:
    pz-discordbot:
      build:
        context: .
        dockerfile: Dockerfile
      environment:
          TOKEN: "DISCORDトークンを入力"
          CLIENT_ID: "クライアントIDを入力"
          RCON_HOST: "RCONホストを入力"
          RCON_PORT: "RCONポートを入力"
          RCON_PASS: "RCONパスワードを入力"
          ADMIN_ROLE_ID: "管理者ロールIDを入力"
```


# Note

製作途中

# Author

* 作成者   kanicub
* E-mail    kaniclub2020@gmail.com

# License
[MIT license](https://en.wikipedia.org/wiki/MIT_License).
