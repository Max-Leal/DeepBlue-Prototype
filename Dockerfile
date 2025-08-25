# Usar uma imagem base do Tomcat com JDK
FROM tomcat:9.0-jdk11

# Limpar apps padrão do Tomcat (opcional)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copiar o WAR para o diretório webapps do Tomcat
COPY seu-projeto.war /usr/local/tomcat/webapps/ROOT.war

# Expor a porta 8080
EXPOSE 8080

# Comando padrão já é start do Tomcat
