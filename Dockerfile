FROM slitaz/curl:latest

RUN cd /var/www/packages && \
	curl -k -c /tmp/cookies "https://drive.google.com/uc?export=download&id=0BwRQKjb-aCLwQjVGS3ZObC1PeWM" > /tmp/intermezzo.html && \
	curl -k -L -b /tmp/cookies "https://drive.google.com$(cat /tmp/intermezzo.html \
	| grep -Po 'uc-download-link" [^>]* href="\K[^"]*' | sed 's/\&amp;/\&/g')" | tar -x 
