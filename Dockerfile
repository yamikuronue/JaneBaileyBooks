FROM jekyll/jekyll as builder
RUN apk update && apk add image_optim && mkdir -p /var/build
COPY ./ /var/build
WORKDIR /var/build
RUN image_optim assets/images/* && jekyll build


FROM kyma/docker-nginx
COPY --from=builder /var/build/_site /var/www
CMD 'nginx'