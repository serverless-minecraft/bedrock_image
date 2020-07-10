FROM itzg/minecraft-bedrock-server:latest
LABEL maintainer "kevin@littlejohn.id.au"
RUN \
	mkdir -p /aws && \
	apk -Uuv add groff less && \
	pip install --upgrade pip && \
	pip install awscli && \
	rm /var/cache/apk/* && \
	chmod +x /do*.sh
COPY route53_upsert_template.json /
COPY do*.sh /
