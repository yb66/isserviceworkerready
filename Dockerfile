FROM crystallang/crystal:0.35.1-alpine

WORKDIR /home

COPY shard.yml .
COPY src/ ./src/
RUN	shards
RUN crystal build --release src/app.cr 

FROM crystallang/crystal:0.35.1-alpine
WORKDIR /home
COPY --from=0 /home/app /home/
COPY key.pem pem.pem ./
#COPY public/ /home/public

EXPOSE 3000

ENTRYPOINT ["/home/app", "3000", "--ssl", "--ssl-key-file", "key.pem", "--ssl-cert-file", "pem.pem"]
