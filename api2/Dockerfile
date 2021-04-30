# Dockerfile development version
FROM ruby:2.7.2

ARG USER_ID
ARG GROUP_ID

RUN addgroup user
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user

RUN apt-get update && apt-get install -y --no-install-recommends nodejs yarn

WORKDIR /usr/src/app

COPY . .

RUN gem install bundler
RUN gem install rails
RUN bundle install
RUN chown -R user:user /usr/src/app

COPY .docker/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-p", "8080", "-b", "0.0.0.0"]
