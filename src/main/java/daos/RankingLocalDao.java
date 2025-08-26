package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import models.RankingLocal;
import utils.ConexaoDB;

public class RankingLocalDao {

	public static List<RankingLocal> getRankingLocais(int limit) {
	    List<RankingLocal> lista = new ArrayList<>();
	    try {
	        Connection con = ConexaoDB.getConexao();
	        String sql = """
	            SELECT
	                loc.id AS id_local,
	                loc.nome AS nome_local,
	                AVG(ava.escala) AS media_escala
	            FROM
	                tb_avaliacao_local ava
	            JOIN
	                tb_local loc ON ava.id_local = loc.id
	            GROUP BY
	                loc.id, loc.nome
	            ORDER BY
	                media_escala DESC
	            LIMIT ?
	        """;
	        PreparedStatement stm = con.prepareStatement(sql);
	        stm.setInt(1, limit);
	        ResultSet rs = stm.executeQuery();

	        while (rs.next()) {

	            RankingLocal ranking = new RankingLocal();
	            ranking.setIdLocal(rs.getLong("id_local"));
	            ranking.setNomeLocal(rs.getString("nome_local"));
	            	       
	            ranking.setMediaEscala(rs.getDouble("media_escala"));
	            
	            lista.add(ranking);
	        }

	        rs.close();
	        stm.close();
	        con.close();

	    } catch (Exception e) {
	        throw new RuntimeException("Erro ao listar o ranking de locais: " + e.getMessage(), e);
	    }
	    return lista;
	}
}
