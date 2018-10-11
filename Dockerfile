FROM anapsix/alpine-java:jre8

EXPOSE 8080

COPY target/SampleApplication-1.0-SNAPSHOT.jar /tmp/sample-application.jar

ENTRYPOINT ["java", "-jar"]

CMD ["/tmp/sample-application.jar"]