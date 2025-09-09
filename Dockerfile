FROM tomcat:10.1-jdk17-temurin

# Remove apps padrões
RUN rm -rf /usr/local/tomcat/webapps/*

# Copia o WAR
COPY ./build/DeepBlue-Prototype.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080