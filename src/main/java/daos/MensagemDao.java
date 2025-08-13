package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import Enums.TipoUsuario;
import models.Mensagem;
import utils.ConexaoDB;

public class MensagemDao {

	public static List<Mensagem> getConversas(Long id, TipoUsuario tipo) {
	    List<Mensagem> ultimas = new ArrayList<>();
	    // SQL para buscar todas as mensagens onde o usuário é o remetente OU o destinatário.
	    String sql = "SELECT * FROM tb_mensagens " +
	                 "WHERE (remetente_id = ? AND remetente_tipo = ?) " +
	                 "ORDER BY data_envio ASC";

	    try (Connection con = ConexaoDB.getConexao()) {
	        PreparedStatement stm = con.prepareStatement(sql);

	        // Converte o enum para a string esperada no banco ('usuario' ou 'agencia')
	        String tipoString = tipo.name().toLowerCase();

	        stm.setLong(1, id);
	        stm.setString(2, tipoString);

	        ResultSet rs = stm.executeQuery();

	        while (rs.next()) {
	        	Mensagem msg = new Mensagem();
                msg.setId(rs.getLong("id"));
                msg.setRemetenteId(rs.getLong("remetente_id"));
                msg.setRemetenteTipo(TipoUsuario.valueOf(rs.getString("remetente_tipo").toUpperCase()));
                msg.setDestinatarioId(rs.getLong("destinatario_id"));
                msg.setDestinatarioTipo(TipoUsuario.valueOf(rs.getString("destinatario_tipo").toUpperCase()));
                msg.setConteudo(rs.getString("conteudo"));
                msg.setDataEnvio(rs.getTimestamp("data_envio").toLocalDateTime());
                
                ultimas.add(msg);
	        }
	        
	        rs.close();
	        stm.close();
	    } catch (Exception e) {
	        throw new RuntimeException("Erro ao buscar últimas conversas: " + e.getMessage());
	    }
	    return ultimas;
	}

	
    public static void insert(Mensagem m) {
        try (Connection con = ConexaoDB.getConexao()) {
            String sql = "INSERT INTO tb_mensagens (remetente_id, remetente_tipo, destinatario_id, destinatario_tipo, conteudo) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setLong(1, m.getRemetenteId());
            stm.setString(2, m.getRemetenteTipo().name()); // Enum para String
            stm.setLong(3, m.getDestinatarioId());
            stm.setString(4, m.getDestinatarioTipo().name()); // Enum para String
            stm.setString(5, m.getConteudo());
            stm.execute();
            stm.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao inserir mensagem: " + e.getMessage());
        }
    }

    public static Mensagem getById(Long id) {
        Mensagem m = null;
        try (Connection con = ConexaoDB.getConexao()) {
            String sql = "SELECT * FROM tb_mensagens WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setLong(1, id);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                m = new Mensagem();
                m.setId(rs.getLong("id"));
                m.setRemetenteId(rs.getLong("remetente_id"));
                m.setRemetenteTipo(TipoUsuario.valueOf(rs.getString("remetente_tipo"))); // String para Enum
                m.setDestinatarioId(rs.getLong("destinatario_id"));
                m.setDestinatarioTipo(TipoUsuario.valueOf(rs.getString("destinatario_tipo"))); // String para Enum
                m.setConteudo(rs.getString("conteudo"));
                m.setDataEnvio(rs.getTimestamp("data_envio").toLocalDateTime());
            }

            rs.close();
            stm.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao buscar mensagem por ID: " + e.getMessage());
        }
        return m;
    }

    public static List<Mensagem> getConversasEntre(Long idA, TipoUsuario tipoA, Long idB, TipoUsuario tipoB) {
        List<Mensagem> mensagens = new ArrayList<>();
        try (Connection con = ConexaoDB.getConexao()) {
            String sql = "SELECT * FROM tb_mensagens " +
                         "WHERE (remetente_id = ? AND remetente_tipo = ? AND destinatario_id = ? AND destinatario_tipo = ?) " +
                         "   OR (remetente_id = ? AND remetente_tipo = ? AND destinatario_id = ? AND destinatario_tipo = ?) " +
                         "ORDER BY data_envio ASC";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setLong(1, idA);
            stm.setString(2, tipoA.name());
            stm.setLong(3, idB);
            stm.setString(4, tipoB.name());

            stm.setLong(5, idB);
            stm.setString(6, tipoB.name());
            stm.setLong(7, idA);
            stm.setString(8, tipoA.name());

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Mensagem m = new Mensagem();
                m.setId(rs.getLong("id"));
                m.setRemetenteId(rs.getLong("remetente_id"));
                m.setRemetenteTipo(TipoUsuario.valueOf(rs.getString("remetente_tipo")));
                m.setDestinatarioId(rs.getLong("destinatario_id"));
                m.setDestinatarioTipo(TipoUsuario.valueOf(rs.getString("destinatario_tipo")));
                m.setConteudo(rs.getString("conteudo"));
                m.setDataEnvio(rs.getTimestamp("data_envio").toLocalDateTime());
                mensagens.add(m);
            }

            rs.close();
            stm.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao buscar mensagens da conversa: " + e.getMessage());
        }
        return mensagens;
    }

    public static void deleteById(Long id) {
        try (Connection con = ConexaoDB.getConexao()) {
            String sql = "DELETE FROM tb_mensagens WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setLong(1, id);
            stm.execute();
            stm.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao deletar mensagem: " + e.getMessage());
        }
    }
}
