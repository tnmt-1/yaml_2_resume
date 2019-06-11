YAMLによる履歴書作成
===

[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)
[![Ruby](https://img.shields.io/badge/ruby-%3E%3D2.3-red.svg)](Ruby)
[![Build Status](https://travis-ci.com/jerrywdlee/yaml_2_resume.svg?branch=master)](https://travis-ci.com/jerrywdlee/yaml_2_resume)
[![Test Coverage](https://api.codeclimate.com/v1/badges/82051a8ba32117145b21/test_coverage)](https://codeclimate.com/github/jerrywdlee/yaml_2_resume/test_coverage)
[![Maintainability](https://api.codeclimate.com/v1/badges/82051a8ba32117145b21/maintainability)](https://codeclimate.com/github/jerrywdlee/yaml_2_resume/maintainability)

[kaityo256氏が開発した `yaml_cv`](https://github.com/kaityo256/yaml_cv)のマイクロサービス版です。  
YAML形式で書かれたデータファイルと、
YAMLもしくはテキストファイル形式で書かれた[スタイル](https://qiita.com/kaityo256/items/e3884d0109223c324baf)
から履歴書PDFファイルを作成します。

[![dockeri.co](https://dockeri.co/image/jerrywdlee/yaml_2_resume)](https://hub.docker.com/r/jerrywdlee/yaml_2_resume)

# Application
**DEMO: https://yaml-2-resume.herokuapp.com/**  

![sample/photo.png](sample/screen_pc.png)  

# インストール＆使用
## ローカルインストール
### 必要なライブラリ等
* Ruby >= v2.3
* bundler >= 2.0
* [ImageMagick](https://imagemagick.org/index.php)
* [IAPexフォント](https://ipafont.ipa.go.jp/node193#jp)

### MacOS
#### 依存パケージのインストール
```sh
$ brew install imagemagick
$ gem install bundler
$ bundle install
```

#### フォントのダウンロード、バージョンは適宜に替えていいです
```sh
$ curl https://oscdl.ipa.go.jp/IPAexfont/IPAexfont00401.zip > fonts.zip
$ unzip -oj fonts.zip -d fonts/ && rm -rf fonts.zip
```

上記コマンドを使わなくても、[ここ](https://ipafont.ipa.go.jp/node193#jp)よりフォントを
ダウンロードして、下記の配置になるよう解凍すればいい。

```
├── fonts
│   ├── ipaexg.ttf
│   └── ipaexm.ttf
└── make_cv.rb
```

#### アプリの起動
##### webアプリとして

```sh
$ ruby app.rb
$ open http://localhost:4567
```

##### また、ローカルでは[kaityo256/yaml_cv](https://github.com/kaityo256/yaml_cv)が提供したコマンドも実行できる。

```sh
$ ruby make_cv.rb -h
Usage: make_cv [options]
    -i, --input [datafile]
    -s, --style [stylefile]
    -o, --output [output]
```

```sh
ruby make_cv.rb -i templates/data.yaml -s templates/style.txt -o output.pdf
```

##### テストの実行
```sh
$ bundle exec rspec
```

## Dockerを使う
### 純Docker(Webアプリとして)
#### ローカルでビルドする

```sh
$ docker build -t my_yaml_2_resume .
$ docker run --rm -p 14567:4567 my_yaml_2_resume
$ open http://localhost:14567
```

#### [Docker Hub](https://cloud.docker.com/repository/docker/jerrywdlee/yaml_2_resume)を利用する

```sh
$ docker pull jerrywdlee/yaml_2_resume:latest
$ docker run --rm -p 14567:4567 jerrywdlee/yaml_2_resume
$ open http://localhost:14567
```

## Docker Composeを使う
### Webアプリ
```sh
$ docker-compose build
$ docker-compose up
$ open http://localhost:14567
```

### CMDモード
`share/`の配下にご自分のデータを置いて、`docker-compose.yml`の`command`フィールドを修正して使う。もちろん、`templates/`配下のサンプルデータも使える。

```diff
version: '3.5'
services:
  yaml_2_resume:
    container_name: yaml_2_resume
    build: .
    ports:
      - 14567:4567
    working_dir: /usr/src/app
    volumes:
      - ./share:/usr/src/app/share
    # web app mode
-    command: ruby app.rb -o 0.0.0.0
    # cmd mode
+    command: ruby make_cv.rb -i share/YOUR_DATA.yaml -s share/YOUR_STYLE.txt -o share/output.pdf
```

```sh
$ docker-compose build
$ docker-compose up
$ open ./share/output.pdf
```

## HerokuでDeploy

```sh
$ heroku create YOUR-APP-NAME
$ heroku stack:set container
$ git push heroku master
```

# [kaityo256/yaml_cv](https://github.com/kaityo256/yaml_cv)との変更点

- `data.yaml`の`photo`フィールドは、URLも使えることになった。
- 提供された画像は向きを補正し、サイズも自動調節することになった。
- コマンドモードを使う際、`data.yaml`と`style.txt`の中に、`erb`文法が書けるようになった。
- `data.yaml`に`@date`で現在の年月日を出していて、[和暦](https://github.com/sugi/wareki)も使えることになった。
  - セキュリティの観点で、WEB版では`erb`文法の利用ができません。
- サンプルデータとスタイルは`templates/`配下に置いた。
- サンプルデータを当たり障りのない文章に再構成した。
- サンプル写真を[StyleGAN](https://github.com/NVlabs/stylegan)で生成された偽の人物像を使用した。
