package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import models.Mensagem;
import utils.ConexaoDB;

public class MensagemDao {

    public static void insert(Mensagem m) {
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "INSERT INTO tb_mensagem (id_usuario, id_agencia, conteudo, remetente) VALUES (?, ?, ?, ?)";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setLong(1, m.getIdUsuario());
            stm.setLong(2, m.getIdAgencia());
            stm.setString(3, m.getConteudo());
            stm.setString(4, m.getRemetente());
            stm.execute();
            stm.close();
            con.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao inserir mensagem: " + e.getMessage());
        }
    }

    public static Mensagem getById(Long id) {
        Mensagem m = null;
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "SELECT * FROM tb_mensagem WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setLong(1, id);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                m = new Mensagem();
                m.setId(rs.getLong("id"));
                m.setIdUsuario(rs.getLong("id_usuario"));
                m.setIdAgencia(rs.getLong("id_agencia"));
                m.setConteudo(rs.getString("conteudo"));
                m.setRemetente(rs.getString("remetente"));
                m.setDataEnvio(rs.getTimestamp("data_envio").toLocalDateTime());
            }

            rs.close();
            stm.close();
            con.close();
            return m;
        } catch (Exception e) {
            throw new RuntimeException("Erro ao buscar mensagem por ID: " + e.getMessage());
        }
    }

    public static List<Mensagem> getConversasEntreUsuarioEAgencia(Long idUsuario, Long idAgencia) {
        List<Mensagem> mensagens = new ArrayList<>();
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "SELECT * FROM tb_mensagem WHERE id_usuario = ? AND id_agencia = ? ORDER BY data_envio ASC";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setLong(1, idUsuario);
            stm.setLong(2, idAgencia);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Mensagem m = new Mensagem();
                m.setId(rs.getLong("id"));
                m.setIdUsuario(rs.getLong("id_usuario"));
                m.setIdAgencia(rs.getLong("id_agencia"));
                m.setConteudo(rs.getString("conteudo"));
                m.setRemetente(rs.getString("remetente"));
                m.setDataEnvio(rs.getTimestamp("data_envio").toLocalDateTime());
                mensagens.add(m);
            }

            rs.close();
            stm.close();
            con.close();
            return mensagens;
        } catch (Exception e) {
            throw new RuntimeException("Erro ao buscar mensagens da conversa: " + e.getMessage());
        }
    }

    public static void deleteById(Long id) {
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "DELETE FROM tb_mensagem WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setLong(1, id);
            stm.execute();

            stm.close();
            con.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao deletar mensagem: " + e.getMessage());
        }
    }
}
