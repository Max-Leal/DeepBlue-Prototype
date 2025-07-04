package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import Enums.Situacao;
import models.Local;
import utils.ConexaoDB;

public class LocalDao {

    public static List<Local> getLista() {
        List<Local> lista = new java.util.ArrayList<>();
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "SELECT * FROM tb_local";
            PreparedStatement stm = con.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Local local = new Local();
                local.setId(rs.getLong("id"));
                local.setLocalidade(rs.getString("localidade"));
                local.setSituacao(Situacao.valueOf(rs.getString("situacao").toUpperCase()));
                local.setNome(rs.getString("nome"));
                local.setDescricao(rs.getString("descricao"));
                local.setLongitude(rs.getString("longitude"));
                local.setLatitude(rs.getString("latitude"));
                lista.add(local);
            }
            rs.close();
            stm.close();
            con.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao listar locais: " + e.getMessage());
        }
        return lista;
    }
    public static void insert(Local l) {
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "INSERT INTO tb_local (localidade, situacao, nome, descricao, latitude, longitude) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, l.getLocalidade());
            stm.setString(2, l.getSituacao().toString().toLowerCase());
            stm.setString(3, l.getNome());
            stm.setString(4, l.getLongitude());
            stm.setString(5, l.getDescricao());
            stm.setString(6, l.getLatitude());
            stm.execute();

            stm.close();
            con.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao inserir local: " + e.getMessage());
        }
    }

    public static Local getLocalById(int id) {
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "SELECT * FROM tb_local WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            Local local = null;
            if (rs.next()) {
                local = new Local();
                local.setId(rs.getLong("id"));
                local.setLocalidade(rs.getString("localidade"));
                local.setSituacao(Situacao.valueOf(rs.getString("situacao").toUpperCase()));
                local.setNome(rs.getString("nome"));
                local.setDescricao(rs.getString("descricao"));
                local.setLongitude(rs.getString("longitude"));
                local.setLatitude(rs.getString("latitude"));
            }
            rs.close();
            stm.close();
            con.close();
            return local;
        } catch (Exception e) {
            throw new RuntimeException("Erro ao buscar local por ID: " + e.getMessage());
        }
    }

    public static void deleteById(int id) {
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "DELETE FROM tb_local WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, id);
            stm.execute();

            stm.close();
            con.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao deletar local: " + e.getMessage());
        }
    }

    public static void update(Long id, Local localAtualizado) {
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "UPDATE tb_local SET localidade = ?, situacao = ?, nome = ?, descricao = ?, longitude = ?, latitude = ? WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, localAtualizado.getLocalidade());
            stm.setString(2, localAtualizado.getSituacao().toString().toLowerCase());
            stm.setString(3, localAtualizado.getNome());
            stm.setString(4, localAtualizado.getDescricao());
            stm.setString(5, localAtualizado.getLongitude());
            stm.setString(6, localAtualizado.getLatitude());
            stm.setLong(7, id);
            stm.execute();

            stm.close();
            con.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao atualizar local: " + e.getMessage());
        }
    }
}
