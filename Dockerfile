FROM ruby:2.5-slim as builder
RUN apt-get update \
    && apt-get install -y \ 
        build-essential \
    && gem install --no-ri --no-rdoc image_optim image_optim_pack jekyll \
    && mkdir -p /var/build
    
COPY ./ /var/build
WORKDIR /var/build
RUN image_optim assets/images/* && jekyll build


FROM kyma/docker-nginx
COPY --from=builder /var/build/_site /var/www
CMD 'nginx'