FROM maven:latest AS build

WORKDIR /app
COPY . .

# Desativa a execução dos testes durante o estágio de construção
RUN mvn clean install -DskipTests=true

FROM openjdk:17-jdk-slim

EXPOSE 8080

COPY --from=build /app/target/cardapio-0.0.1-SNAPSHOT.jar /app/app.jar

ENTRYPOINT [ "java", "-jar", "/app/app.jar" ]
