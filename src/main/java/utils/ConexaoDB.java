package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexaoDB {

    public static Connection getConexao() throws SQLException {
        // Tenta ler as variáveis de ambiente (para o ambiente Docker)
        String host = System.getenv("DB_HOST");
        String port = System.getenv("DB_PORT");
        String dbName = System.getenv("DB_NAME");
        String usuario = System.getenv("DB_USER");
        String senha = System.getenv("DB_PASSWORD");

        // Se as variáveis de ambiente não existirem, usa a configuração para o ambiente local (Eclipse)
        if (host == null || host.isEmpty()) {
            System.out.println("INFO: Variáveis de ambiente não encontradas. Usando configuração de banco de dados local.");
            host = "localhost";
            port = "3306";
            dbName = "deepblue"; // O nome do seu banco local
            usuario = "root";    // Seu usuário local
            senha = "root";        // Sua senha local (se houver, coloque aqui)
        }

        // Monta a URL de conexão do JDBC
        String url = "jdbc:mysql://" + host + ":" + port + "/" + dbName + "?useSSL=false&serverTimezone=UTC";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver MySQL não encontrado.", e);
        }
        
        // Usa as credenciais definidas para criar a conexão
        return DriverManager.getConnection(url, usuario, senha);
    }
}