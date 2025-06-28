FROM ubuntu AS build 
RUN apt update -y && apt install -y openjdk-17-jdk maven 
RUN git clone https://github.com/hnarendra/train-ticket-reservation.git
WORKDIR /train-ticket-reservation
RUN mvn package
FROM tomcat:9-jdk17
COPY --from=build /train-ticket-reservation/target/*.war/usr/local/tomcat/webapps/ROOT.war
RUN chmod 755 /usr/local/tomcat/webapps
EXPOSE 8080
ENTRYPOINT ["catalina.sh","run"]
