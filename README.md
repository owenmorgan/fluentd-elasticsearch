# fluentd-elasticsearch
fluentd docker image pre-configured to forward in logstash format to a host specified in environment variables : 

es_log_host

es_log_port


e.g.

	docker run -e es_log_host=https://my.elasticsearch.com -e es_log_port=9200 osmorgan/fluentd-elasticsearch:latest

can be used as a companion for other containers running locally:

e.g.

####docker-compose.yml
	version: "2"

	services:
  		web-app:
    		image: httpd
    		ports:
      			- "80:80"
    		logging:
      			driver: "json-file"

  		logger:
	    	image: osmorgan/fluentd-elasticsearch:latest
	    	environment: 
	      			- es_log_host=my.elasticsearch.com
	      			- es_log_port=9200
	      	volumes:
	     	 	- /var/lib/docker/containers:/fluentd/logs
	    	logging:
	      		driver: none

      			
