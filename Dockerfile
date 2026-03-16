# Step 1: Build the project using Maven
FROM maven:3.8.5-openjdk-17 AS build
COPY . .
RUN mvn clean package -DskipTests

# Step 2: Run the project using OpenJDK
FROM openjdk:17-jdk-slim
COPY --from=build /target/*.war app.war
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.war"]
