# How to reproduce

## Create a Heroku account 

First you need a [Heroku](heroku.com) account. 

## Deploy your app on Heroku via Dockerfile

Then, you need to deploy via Dockerfile, explained [here](https://devcenter.heroku.com/articles/container-registry-and-runtime)
Summarized below:

```$ heroku container:login```

Replace MY-APP-NAME by your app name, in this repo for example, the app is called wglmakie-mwe

Important: the name of your app need to be in `JSServe_app.jl`, line 35 in this repo 

```$ heroku create MY-APP-NAME```

```$ heroku container:push web```

```heroku container:release web```

Done! 
