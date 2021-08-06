# docker-php-smallest

The Smallest Docker PHP Image `2.32MB`

## TL;DR

```dockerfile
FROM wandersonwhcr/php-smallest

COPY ./index.php ./

CMD ["-S", "0.0.0.0:8000", "index.php"]

EXPOSE 8000
```
