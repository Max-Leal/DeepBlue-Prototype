package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import models.AvaliacaoAgencia;
import utils.ConexaoDB;

public class AvaliacaoAgenciaDao {

    public static void insert(AvaliacaoAgencia a) {
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "INSERT INTO tb_avaliacao_agencia (escala, sugestao, tb_usuario_id, tb_agencia_id) VALUES (?, ?, ?, ?)";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, String.valueOf(a.getEscala())); // ENUM como string
            stm.setString(2, a.getSugestao());
            stm.setLong(3, a.getUsuarioId());
            stm.setLong(4, a.getAgenciaId());
            stm.execute();

            stm.close();
            con.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao inserir avaliação: " + e.getMessage());
        }
    }

    public static AvaliacaoAgencia getAvaliacaoById(Long id) {
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "SELECT * FROM tb_avaliacao_agencia WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setLong(1, id);
            ResultSet rs = stm.executeQuery();
            AvaliacaoAgencia a = null;
            if (rs.next()) {
                a = new AvaliacaoAgencia();
                a.setId(rs.getLong("id"));
                a.setEscala(Integer.parseInt(rs.getString("escala")));
                a.setSugestao(rs.getString("sugestao"));
                a.setUsuarioId(rs.getLong("tb_usuario_id"));
                a.setAgenciaId(rs.getLong("tb_agencia_id"));

                if (rs.getTimestamp("data_avaliacao") != null) {
                    a.setDataAvaliacao(rs.getTimestamp("data_avaliacao").toLocalDateTime());
                }
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
            String sql = "DELETE FROM tb_avaliacao_agencia WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setLong(1, id);
            stm.execute();

            stm.close();
            con.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao deletar avaliação: " + e.getMessage());
        }
    }

    public static void update(Long id, AvaliacaoAgencia atualizada) {
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "UPDATE tb_avaliacao_agencia SET escala = ?, sugestao = ?, tb_usuario_id = ?, tb_agencia_id = ? WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, String.valueOf(atualizada.getEscala()));
            stm.setString(2, atualizada.getSugestao());
            stm.setLong(3, atualizada.getUsuarioId());
            stm.setLong(4, atualizada.getAgenciaId());
            stm.setLong(5, id);
            stm.execute();

            stm.close();
            con.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao atualizar avaliação: " + e.getMessage());
        }
    }
}
