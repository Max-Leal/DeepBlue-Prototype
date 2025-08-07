package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import models.AvaliacaoLocal;
import utils.ConexaoDB;

public class AvaliacaoLocalDao {

	public static List<AvaliacaoLocal> getAvaliacoesPorLocal(Long idLocal) {
	    List<AvaliacaoLocal> lista = new ArrayList<>();

	    try {
	        Connection con = ConexaoDB.getConexao();
	        String sql = "SELECT * FROM tb_avaliacao_local WHERE id_local = ? ORDER BY data_comentario DESC";
	        PreparedStatement stm = con.prepareStatement(sql);
	        stm.setLong(1, idLocal);
	        ResultSet rs = stm.executeQuery();

	        while (rs.next()) {
	            AvaliacaoLocal avaliacao = new AvaliacaoLocal();
	            avaliacao.setId(rs.getLong("id"));
	            avaliacao.setIdLocal(rs.getLong("id_local"));
	            avaliacao.setIdUsuario(rs.getLong("id_usuario"));
	            avaliacao.setTexto(rs.getString("texto"));
	            avaliacao.setEscala(Integer.parseInt(rs.getString("escala")));
	            avaliacao.setDataComentario(rs.getTimestamp("data_comentario").toLocalDateTime());
	            lista.add(avaliacao);
	        }

	        rs.close();
	        stm.close();
	        con.close();

	    } catch (Exception e) {
	        throw new RuntimeException("Erro ao listar avaliações do local: " + e.getMessage());
	    }

	    return lista;
	}

	
    public static void insert(AvaliacaoLocal avaliacao) {
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "INSERT INTO tb_avaliacao_local (id_local, id_usuario, texto, escala) VALUES (?, ?, ?, ?)";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setLong(1, avaliacao.getIdLocal());
            stm.setLong(2, avaliacao.getIdUsuario());
            stm.setString(3, avaliacao.getTexto());
            stm.setString(4, String.valueOf(avaliacao.getEscala())); // ENUM armazenado como String
            stm.execute();
            stm.close();
            con.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao inserir avaliação de local: " + e.getMessage());
        }
    }

    public static AvaliacaoLocal getById(Long id) {
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "SELECT * FROM tb_avaliacao_local WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setLong(1, id);
            ResultSet rs = stm.executeQuery();

            AvaliacaoLocal avaliacao = null;
            if (rs.next()) {
                avaliacao = new AvaliacaoLocal();
                avaliacao.setId(rs.getLong("id"));
                avaliacao.setIdLocal(rs.getLong("id_local"));
                avaliacao.setIdUsuario(rs.getLong("id_usuario"));
                avaliacao.setTexto(rs.getString("texto"));
                avaliacao.setEscala(Integer.parseInt(rs.getString("escala")));
                avaliacao.setDataComentario(rs.getTimestamp("data_comentario").toLocalDateTime());
            }

            rs.close();
            stm.close();
            con.close();

            return avaliacao;
        } catch (Exception e) {
            throw new RuntimeException("Erro ao buscar avaliação por ID: " + e.getMessage());
        }
    }

    public static List<AvaliacaoLocal> getAll() {
        List<AvaliacaoLocal> lista = new ArrayList<>();
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "SELECT * FROM tb_avaliacao_local ORDER BY data_comentario DESC";
            PreparedStatement stm = con.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                AvaliacaoLocal avaliacao = new AvaliacaoLocal();
                avaliacao.setId(rs.getLong("id"));
                avaliacao.setIdLocal(rs.getLong("id_local"));
                avaliacao.setIdUsuario(rs.getLong("id_usuario"));
                avaliacao.setTexto(rs.getString("texto"));
                avaliacao.setEscala(Integer.parseInt(rs.getString("escala")));
                avaliacao.setDataComentario(rs.getTimestamp("data_comentario").toLocalDateTime());
                lista.add(avaliacao);
            }

            rs.close();
            stm.close();
            con.close();

        } catch (Exception e) {
            throw new RuntimeException("Erro ao listar avaliações de local: " + e.getMessage());
        }

        return lista;
    }

    public static void deleteById(Long id) {
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "DELETE FROM tb_avaliacao_local WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setLong(1, id);
            stm.execute();
            stm.close();
            con.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao deletar avaliação: " + e.getMessage());
        }
    }

    public static void update(Long id, AvaliacaoLocal atualizada) {
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "UPDATE tb_avaliacao_local SET texto = ?, escala = ? WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, atualizada.getTexto());
            stm.setString(2, String.valueOf(atualizada.getEscala()));
            stm.setLong(3, id);
            stm.execute();
            stm.close();
            con.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao atualizar avaliação: " + e.getMessage());
        }
    }
}
