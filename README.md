#rpi-sirius

Docker image for [genmon/sirius](https://github.com/genmon/sirius), the bare bones back-end server doing basic messaging for Little Printer.

The image is intended for deployment on a Raspberry Pi, ARM hardware.

It will `git clone` the latest and greatest of *genmon/sirius* code base, install any dependencies and start the server, exposing port `5000`.

## Run the sirius Python server on Raspberry Pi

Prerequisites on Raspberry Pi:

- Docker, e.g. [Hypriot Docker Image or Debian Packages for Raspberry Pi](http://blog.hypriot.com/downloads/)
- Credentials for a [Twitter](https://apps.twitter.com/). 

Run the image from the public, pre-build image on Docker Hub [matthiasg/rpi-sirius](https://hub.docker.com/r/matthiasg/rpi-sirius/):

```
$ docker run -d --restart=always -p 5000:5000 \
    -e "TWITTER_CONSUMER_KEY=[YOUR_TWITTER_CONSUMER_KEY]" \
    -e "TWITTER_CONSUMER_SECRET=[YOUR_TWITTER_CONSUMER_SECRET]" \
    matthiasg/rpi-sirius
```

## Build and run the sirius Python server with Docker on Raspberry Pi

Prerequisites on Raspberry Pi:

- Git, e.g. on Raspbian `sudo apt-get install git`
- Docker, e.g. [Hypriot Docker Image or Debian Packages for Raspberry Pi](http://blog.hypriot.com/downloads/)

Build the image:

    $ git clone https://github.com/openwebcraft/rpi-sirius.git
    $ cd rpi-sirius 
    $ docker build -t rpi-sirius .
    
Start a container from the image:

    $ docker run -d --restart=always -p 5000:5000 -e "TWITTER_CONSUMER_KEY=[YOUR_TWITTER_CONSUMER_KEY]" -e "TWITTER_CONSUMER_SECRET=[YOUR_TWITTER_CONSUMER_SECRET]" rpi-sirius

## Build and publish image to Docker Hub on Raspberry Pi

    $ docker build -t matthiasg/rpi-sirius .

    $ docker tag [IMAGEID] matthiasg/rpi-sirius:latest
    
    $ docker login --username=[DOCKER_HUB_USERNAME] --email=[DOCKER_HUB_EMAIL]
    
    $ docker push matthiasg/rpi-sirius