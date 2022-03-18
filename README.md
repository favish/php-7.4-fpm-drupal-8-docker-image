# PHP-7.4-FPM-Drupal-8-Docker-Image

### Notes
Includes php and several dependencies for Drupal and commonly used drupal modules:
* Redis Support
* GD
* Imagick (image derivatives for gifs with multiframe support)
* Storage backends: mysql and mongo
* multibyte strings (mbstring)
* opcache (speed improvement that avoids recompiling with every request)
* Blackfire probe for profiling (can be used on production with no performance penalty)

### Use
You should add some extra configuration via `.ini` or `.conf` files in `/usr/local/etc/php-fpm.d` for tuning opcache
and/or file upload limits.

### History
This repo was previously included in a [mono repo](https://github.com/favish/docker-images) and the last published
tag with that repo was `php-7.4-fpm_drupal-8_1.1.0`. The CircleCI build process continues to publish versions to the same image
on [Dockerhub](https://hub.docker.com/r/favish/php-7.4-fpm-drupal-8). The first tag published with this repo is `2.0.0`.