FROM tomcat:8.0.43-jre8
ADD target/SpringBootDemo-0.0.1.jar /usr/local/tomcat/webapps/
EXPOSE 8080
CMD chmod +x /usr/local/tomcat/bin/catalina.sh
CMD ["catalina.sh", "run"]
