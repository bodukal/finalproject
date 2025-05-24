FROM maven:3.8.4-amazoncorretto-17 AS builder
WORKDIR /app

# Copy source code
COPY . .

# Package the application using Maven
RUN mvn clean package -DskipTests

# Stage 2: Use Apache Tomcat 9.0.105 with Java 17 to run the WAR
FROM tomcat:9.0.105-jdk17-temurin

# Clean default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file from the builder stage into Tomcat
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose the default Tomcat port
EXPOSE 8081

# Start Tomcat
CMD ["catalina.sh", "run"]

