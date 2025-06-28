FROM ubuntu AS build
ENV DEBIAN_FROETNEND=noninteractive
RUN apt update -y && apt install openjdk-17-jdk -y maven git
RUN git clone https://github.com/khaleel9876/train-ticket-reservation.git
WORKDIR /train-ticket-reservation
RUN mvn package

FROM tomcat:9-jdk17
COPY --from=build /train-ticket-reservation/target/*.war /usr/local/tomcat/webapps/ROOT.war
RUN chmod 755 /usr/local/tomcat/webapps/*.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
