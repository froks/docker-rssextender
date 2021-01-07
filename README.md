# docker-rssextender

This Dockerfile installs RSS extender with the following features:
- Based on [Docker-Alpine](https://github.com/gliderlabs/docker-alpine) and [s6](http://skarnet.org/software/s6/) as the supervisor
- Using PHP 7
- Small and lightweight image size (< 100 MB)
- Rolling release support: Updates RSS Extender automatically every day

This docker image allows you to run [RSS Extender](https://github.com/lformella/rss-extender), and will 
auto-update it every 24h

The image is based on the work of x86dev's image of docker-ttrss (https://github.com/x86dev/docker-ttrss)
