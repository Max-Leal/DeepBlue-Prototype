package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.ArrayList;

import Enums.Situacao;
import models.Local;
import utils.ConexaoDB;

public class LocalDao {

    public static int insertAndReturnId(Local local) {
        int id = -1;
        try (Connection conn = ConexaoDB.getConexao()) {
            String sql = "INSERT INTO tb_local (nome, localidade, descricao, tipo_embarcacao, ano_afundamento, profundidade, situacao, latitude, longitude) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            stmt.setString(1, local.getNome());
            stmt.setString(2, local.getLocalidade());
            stmt.setString(3, local.getDescricao());
            stmt.setString(4, local.getTipoEmbarcacao());
            stmt.setInt(5, local.getAnoAfundamento());
            stmt.setDouble(6, local.getProfundidade());
            stmt.setString(7, local.getSituacao().toString().toLowerCase());
            stmt.setString(8, local.getLatitude());
            stmt.setString(9, local.getLongitude());

            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                id = rs.getInt(1);
            }

            rs.close();
            stmt.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao inserir local e retornar ID: " + e.getMessage());
        }
        return id;
    }

    public static List<Local> getLista() {
        List<Local> lista = new ArrayList<>();
        try (Connection con = ConexaoDB.getConexao()) {
            String sql = "SELECT * FROM tb_local";
            PreparedStatement stm = con.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Local local = new Local();
                local.setId(rs.getLong("id"));
                local.setNome(rs.getString("nome"));
                local.setLocalidade(rs.getString("localidade"));
                local.setDescricao(rs.getString("descricao"));
                local.setTipoEmbarcacao(rs.getString("tipo_embarcacao"));
                local.setAnoAfundamento(rs.getInt("ano_afundamento"));
                local.setProfundidade(rs.getDouble("profundidade"));
                local.setSituacao(Situacao.valueOf(rs.getString("situacao").toUpperCase()));
                local.setLatitude(rs.getString("latitude"));
                local.setLongitude(rs.getString("longitude"));
                lista.add(local);
            }

            rs.close();
            stm.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao listar locais: " + e.getMessage());
        }
        return lista;
    }

    public static void insert(Local l) {
        String sql = "INSERT INTO tb_local (nome, localidade, descricao, tipo_embarcacao, ano_afundamento, profundidade, situacao, latitude, longitude) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = ConexaoDB.getConexao();
             PreparedStatement stm = con.prepareStatement(sql)) {

            stm.setString(1, l.getNome());
            stm.setString(2, l.getLocalidade());
            stm.setString(3, l.getDescricao());
            stm.setString(4, l.getTipoEmbarcacao());
            stm.setInt(5, l.getAnoAfundamento());
            stm.setDouble(6, l.getProfundidade());
            stm.setString(7, l.getSituacao().toString().toLowerCase());
            stm.setString(8, l.getLatitude());
            stm.setString(9, l.getLongitude());

            stm.executeUpdate();

        } catch (Exception e) {
            throw new RuntimeException("Erro ao inserir local: " + e.getMessage(), e);
        }
    }

    public static Local getLocalById(int id) {
        try (Connection con = ConexaoDB.getConexao()) {
            String sql = "SELECT * FROM tb_local WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();

            Local local = null;
            if (rs.next()) {
                local = new Local();
                local.setId(rs.getLong("id"));
                local.setNome(rs.getString("nome"));
                local.setLocalidade(rs.getString("localidade"));
                local.setDescricao(rs.getString("descricao"));
                local.setTipoEmbarcacao(rs.getString("tipo_embarcacao"));
                local.setAnoAfundamento(rs.getInt("ano_afundamento"));
                local.setProfundidade(rs.getDouble("profundidade"));
                local.setSituacao(Situacao.valueOf(rs.getString("situacao").toUpperCase()));
                local.setLatitude(rs.getString("latitude"));
                local.setLongitude(rs.getString("longitude"));
            }

            rs.close();
            stm.close();
            return local;
        } catch (Exception e) {
            throw new RuntimeException("Erro ao buscar local por ID: " + e.getMessage());
        }
    }

    public static void deleteById(int id) {
        try (Connection con = ConexaoDB.getConexao()) {
            String sql = "DELETE FROM tb_local WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, id);
            stm.execute();
            stm.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao deletar local: " + e.getMessage());
        }
    }

    public static void update(Long id, Local localAtualizado) {
        try (Connection con = ConexaoDB.getConexao()) {
            String sql = "UPDATE tb_local SET nome = ?, localidade = ?, descricao = ?, tipo_embarcacao = ?, ano_afundamento = ?, profundidade = ?, situacao = ?, latitude = ?, longitude = ? WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);

            stm.setString(1, localAtualizado.getNome());
            stm.setString(2, localAtualizado.getLocalidade());
            stm.setString(3, localAtualizado.getDescricao());
            stm.setString(4, localAtualizado.getTipoEmbarcacao());
            stm.setInt(5, localAtualizado.getAnoAfundamento());
            stm.setDouble(6, localAtualizado.getProfundidade());
            stm.setString(7, localAtualizado.getSituacao().toString().toLowerCase());
            stm.setString(8, localAtualizado.getLatitude());
            stm.setString(9, localAtualizado.getLongitude());
            stm.setLong(10, id);

            stm.executeUpdate();
            stm.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao atualizar local: " + e.getMessage());
        }
    }
    
    public static List<Local> buscarPorNome(String nome) {
        List<Local> lista = new ArrayList<>();
        try (Connection con = ConexaoDB.getConexao()) {
            String sql = "SELECT * FROM tb_local WHERE nome LIKE ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, "%" + nome + "%");
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Local local = new Local();
                local.setId(rs.getLong("id"));
                local.setNome(rs.getString("nome"));
                local.setLocalidade(rs.getString("localidade"));
                local.setDescricao(rs.getString("descricao"));
                local.setTipoEmbarcacao(rs.getString("tipo_embarcacao"));
                local.setAnoAfundamento(rs.getInt("ano_afundamento"));
                local.setProfundidade(rs.getDouble("profundidade"));
                local.setSituacao(Situacao.valueOf(rs.getString("situacao").toUpperCase()));
                local.setLatitude(rs.getString("latitude"));
                local.setLongitude(rs.getString("longitude"));
                lista.add(local);
            }

            rs.close();
            stm.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao buscar locais por nome: " + e.getMessage());
        }
        return lista;
    }

}
