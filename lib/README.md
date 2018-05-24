# Library naming conventions

TODO: We should think about it.

```
lib/vendor
  |_ image-name
       |_ tag
            |_ Dockerfile
```

## Base images

- vendor
- image-name (latest product, e.g. postgres+postgis should be named postgis)
- tags (latest product version, e.g. postgres:10+postgis:2.4.3 should be tagged as 2.4.3)
- Dockerfile and resources

## Production images

- vendor (project, team, etc)
- image-name (what... what data, what service, etc). What is in the image?
- tag (what-for, e.g. siose-2005:splitter, siose-2005:jsonb-test). How is it going to be used?
