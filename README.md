Trusterd Dockerfile
===================

Dockerfile for [Trusterd HTTP/2 Web Server](http://trusterd.github.io/)

## USAGE


### build Docker image

```bash
$ git clone 
$ cd trusterd
$ docker build -t local/trusterd .
$ docker run -d -p 8080:80 local/trusterd
$ docker run -ti dajobe/nghttpx nghttp http://172.17.42.1:8080/index.html
```

### Docker run options

- mount trusterd log directory to local

```bash
$ docker run -d -p 8080:80 -v /Users/<Username>/logs:/trusterd-logs local/trusterd
```
 
## MAINTAINER

- takipone<takipone@gmail.com>

