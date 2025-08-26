package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import models.RankingAgencia;
import utils.ConexaoDB;

public class RankingAgenciaDao {

	public static List<RankingAgencia> getRankingAgencia(int limit) {
	    List<RankingAgencia> lista = new ArrayList<>();
	    try {
	        Connection con = ConexaoDB.getConexao();
	        String sql = """
	            SELECT
	                age.id AS id_agencia,
	                age.nome_empresarial AS nome_agencia,
	                AVG(ava.escala) AS media_escala
	            FROM
	                tb_avaliacao_agencia ava
	            JOIN
	                tb_agencia age ON ava.tb_agencia_id = age.id
	            GROUP BY
	                age.id, age.nome_empresarial
	            ORDER BY
	                media_escala DESC
	            LIMIT ?
	        """;
	        PreparedStatement stm = con.prepareStatement(sql);
	        stm.setInt(1, limit);
	        ResultSet rs = stm.executeQuery();

	        while (rs.next()) {

	        	RankingAgencia ranking = new RankingAgencia();
	            ranking.setIdAgencia(rs.getLong("id_agencia"));
	            ranking.setNomeAgencia(rs.getString("nome_agencia"));	            	       
	            ranking.setMediaEscala(rs.getDouble("media_escala"));
	            
	            lista.add(ranking);
	        }

	        rs.close();
	        stm.close();
	        con.close();

	    } catch (Exception e) {
	        throw new RuntimeException("Erro ao listar o ranking de agências: " + e.getMessage(), e);
	    }
	    return lista;
	}
}
