# Usando uma versão estável e recente do Tomcat 10 com JDK 17
FROM tomcat:10.1-jdk17-temurin

# Remove o conteúdo padrão da pasta webapps para evitar conflitos
RUN rm -rf /usr/local/tomcat/webapps/*

# CORREÇÃO: Copia o .war da raiz do projeto, pois ele não está na pasta /app
COPY ./build/DeepBlue-Prototype.war /usr/local/tomcat/webapps/ROOT.war

# Expõe a porta padrão do Tomcat
EXPOSE 8080