package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import models.Avaliacao;
import utils.ConexaoDB;

public class AvaliacaoDao {

    public static void insert(Avaliacao a) {
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "INSERT INTO tb_avaliacao (escala, sugestao, tb_usuario_id, tb_agencia_id) VALUES (?, ?, ?, ?)";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, String.valueOf(a.getNota())); // ENUM em string
            stm.setString(2, a.getSugestao());
            stm.setLong(3, a.getIdUsuarioResponsavel());
            stm.setLong(4, a.getIdAgenciaAvaliada());
            stm.execute();

            stm.close();
            con.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao inserir avaliação: " + e.getMessage());
        }
    }

    public static Avaliacao getAvaliacaoById(Long id) {
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "SELECT * FROM tb_avaliacao WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setLong(1, id);
            ResultSet rs = stm.executeQuery();
            Avaliacao a = null;
            if (rs.next()) {
                a = new Avaliacao();
                a.setId(rs.getLong("id"));
                a.setNota(Integer.parseInt(rs.getString("escala"))); // Enum é string
                a.setSugestao(rs.getString("sugestao"));
                a.setIdUsuarioResponsavel(rs.getLong("tb_usuario_id"));
                a.setIdAgenciaAvaliada(rs.getLong("tb_agencia_id"));
            }
            rs.close();
            stm.close();
            con.close();
            return a;
        } catch (Exception e) {
            throw new RuntimeException("Erro ao buscar avaliação por ID: " + e.getMessage());
        }
    }

    public static void deleteById(Long id) {
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "DELETE FROM tb_avaliacao WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setLong(1, id);
            stm.execute();

            stm.close();
            con.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao deletar avaliação: " + e.getMessage());
        }
    }

    public static void update(Long id, Avaliacao atualizada) {
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "UPDATE tb_avaliacao SET escala = ?, sugestao = ?, tb_usuario_id = ?, tb_agencia_id = ? WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, String.valueOf(atualizada.getNota())); // enum como string
            stm.setString(2, atualizada.getSugestao());
            stm.setLong(3, atualizada.getIdUsuarioResponsavel());
            stm.setLong(4, atualizada.getIdAgenciaAvaliada());
            stm.setLong(5, id);
            stm.execute();

            stm.close();
            con.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao atualizar avaliação: " + e.getMessage());
        }
    }
}
