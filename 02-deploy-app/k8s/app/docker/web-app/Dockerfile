FROM jetty:9.4.9
EXPOSE 8080
ADD https://s3.amazonaws.com/infra-assessment/companyNews.war /var/lib/jetty/webapps/root.war
USER root
RUN chmod 755 /var/lib/jetty/webapps/root.war