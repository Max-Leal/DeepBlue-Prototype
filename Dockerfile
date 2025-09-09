FROM tomcat:10.1-jdk17-temurin

RUN rm -rf /usr/local/tomcat/webapps/*

COPY ./build/DeepBlue-Prototype.war /usr/local/tomcat/webapps/ROOT.war

# Garante que a pasta lib exista
RUN mkdir -p /usr/local/tomcat/webapps/ROOT/WEB-INF/lib

# Copia manualmente os jars que não estão indo no WAR
COPY ./lib/gson-2.10.1.jar /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
COPY ./lib/conexao.jar /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/

EXPOSE 8080
