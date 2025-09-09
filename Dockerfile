FROM tomcat:10.1-jdk17-temurin

# Remove apps padrões
RUN rm -rf /usr/local/tomcat/webapps/*

# Copia o WAR
COPY ./build/DeepBlue-Prototype.war /usr/local/tomcat/webapps/ROOT.war

# Copia a lib do Gson para dentro do Tomcat
COPY ./src/main/webapp/WEB-INF/lib/gson-2.10.1.jar /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/

EXPOSE 8080
