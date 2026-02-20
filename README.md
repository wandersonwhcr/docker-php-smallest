# docker-php-smallest

The Smallest Docker PHP Image

* PHP `8.0.9`: `2.32MB`
* PHP `8.5.3`: `4.33MB`

## TL;DR

```dockerfile
FROM wandersonwhcr/php-smallest

COPY ./index.php ./

CMD ["-S", "0.0.0.0:8000", "index.php"]

EXPOSE 8000
```
