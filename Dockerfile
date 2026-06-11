FROM tomcat:9.0-jdk17

RUN rm -rf /usr/local/tomcat/webapps/*

COPY EMS.war /usr/local/tomcat/webapps/ROOT.war

# Replace default port with Render PORT
ENV PORT 8080

EXPOSE 8080

CMD ["catalina.sh", "run"]
