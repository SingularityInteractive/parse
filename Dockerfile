FROM iron/base:edge

RUN echo '@edge http://nl.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories
# RUN echo '@community http://nl.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories

RUN apk update && apk upgrade \
  && apk add nodejs@edge bash g++ krb5-dev curl make python \
  && rm -rf /var/cache/apk/*

RUN mkdir parse

ADD . /parse
WORKDIR /parse
RUN npm install

# ENV APP_ID setYourAppId
# ENV MASTER_KEY setYourMasterKey
# ENV DATABASE_URI setMongoDBURI
ENV NODE_ENV=production

# Optional (default : 'parse/cloud/main.js')
# ENV CLOUD_CODE_MAIN cloudCodePath

# Optional (default : '/parse')
# ENV PARSE_MOUNT mountPath

EXPOSE 1337

# Uncomment if you want to access cloud code outside of your container
# A main.js file must be present, if not Parse will not start

# VOLUME /parse/cloud

CMD [ "npm", "start" ]
