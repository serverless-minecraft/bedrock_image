FROM itzg/minecraft-bedrock-server:latest
LABEL maintainer "kevin@littlejohn.id.au"
COPY route53_upsert_template.json /
COPY do*.sh /
RUN apt-get update && apt-get install -y cron
RUN \
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
	unzip -q awscliv2.zip && \
	./aws/install -i /usr/local/aws-cli -b /usr/bin && \
	chmod +x /do*.sh
ENTRYPOINT ["/usr/local/bin/entrypoint-demoter", "--match", "/data", "--debug", "--stdin-on-term", "stop", "/doentry.sh"]
