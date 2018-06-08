FROM jekyll/jekyll as builder
RUN gem install --no-ri --no-rdoc image_optim image_optim_pack && mkdir -p /var/build && gem environment
COPY ./ /var/build
WORKDIR /var/build
RUN /usr/gem/bin/image_optim assets/images/* && jekyll build


FROM kyma/docker-nginx
COPY --from=builder /var/build/_site /var/www
CMD 'nginx'