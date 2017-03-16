FROM slitaz/slitaz-curl:latest

COPY lighttpd-1.4.35-x86_64.tazpkg /
COPY index.html /var/www/.

RUN tazpkg -i lighttpd-1.4.35-x86_64.tazpkg && \
	rm /lighttpd-1.4.35-x86_64.tazpkg

RUN mkdir /var/www/packages && \
	cd /var/www/packages && \
	curl -k -c /tmp/cookies "https://drive.google.com/uc?export=download&id=0BwRQKjb-aCLwQjVGS3ZObC1PeWM" > /tmp/intermezzo.html && \
	curl -k -L -b /tmp/cookies "https://drive.google.com$(cat /tmp/intermezzo.html \
	| grep -Po 'uc-download-link" [^>]* href="\K[^"]*' | sed 's/\&amp;/\&/g')" | tar -x 

EXPOSE 80

CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
