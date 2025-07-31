package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import models.AvaliacaoFotoLocal;
import utils.ConexaoDB;

public class AvaliacaoFotoLocalDao {

    public static void insert(AvaliacaoFotoLocal foto) {
        try (Connection con = ConexaoDB.getConexao()) {
            String sql = "INSERT INTO tb_avaliacao_foto_local (id_avaliacao, url_foto) VALUES (?, ?)";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setLong(1, foto.getIdAvaliacao());
            stm.setString(2, foto.getUrlFoto());
            stm.execute();
            stm.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao inserir foto: " + e.getMessage(), e);
        }
    }

    public static List<AvaliacaoFotoLocal> getFotosByAvaliacaoId(Long idAvaliacao) {
        List<AvaliacaoFotoLocal> lista = new ArrayList<>();
        try (Connection con = ConexaoDB.getConexao()) {
            String sql = "SELECT * FROM tb_avaliacao_foto_local WHERE id_avaliacao = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setLong(1, idAvaliacao);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                AvaliacaoFotoLocal foto = new AvaliacaoFotoLocal();
                foto.setId(rs.getLong("id"));
                foto.setIdAvaliacao(rs.getLong("id_avaliacao"));
                foto.setUrlFoto(rs.getString("url_foto"));
                lista.add(foto);
            }
            rs.close();
            stm.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao buscar fotos: " + e.getMessage(), e);
        }
        return lista;
    }

    public static void deleteById(Long id) {
        try (Connection con = ConexaoDB.getConexao()) {
            String sql = "DELETE FROM tb_avaliacao_foto_local WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setLong(1, id);
            stm.execute();
            stm.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao deletar foto: " + e.getMessage(), e);
        }
    }

    public static void deleteByAvaliacaoId(Long idAvaliacao) {
        try (Connection con = ConexaoDB.getConexao()) {
            String sql = "DELETE FROM tb_avaliacao_foto_local WHERE id_avaliacao = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setLong(1, idAvaliacao);
            stm.execute();
            stm.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao deletar fotos da avaliação: " + e.getMessage(), e);
        }
    }
}
