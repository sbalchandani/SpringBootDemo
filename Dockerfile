FROM tomcat:8.0.43-jre8
ADD /Users/saileshbalchandani/.m2/repository/com/test/boot/sailesh/SpringBootDemo/0.0.1/SpringBootDemo-0.0.1.jar /usr/local/tomcat/webapps/
EXPOSE 8080
CMD chmod +x /usr/local/tomcat/bin/catalina.sh
CMD ["catalina.sh", "run"]
