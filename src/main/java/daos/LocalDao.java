package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

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
	        stmt.setString(4, local.getTipo_embarcacao());
	        stmt.setInt(5, local.getAno_afundamento());
	        stmt.setDouble(6, local.getProfundidade());
	        stmt.setString(7, local.getSituacao().toString().toLowerCase());
	        stmt.setString(8, local.getLongitude());
	        stmt.setString(9, local.getLatitude());

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
        List<Local> lista = new java.util.ArrayList<>();
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "SELECT * FROM tb_local";
            PreparedStatement stm = con.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Local local = new Local();
                local.setId(rs.getLong("id"));
                local.setNome(rs.getString("nome"));
                local.setLocalidade(rs.getString("localidade"));
                local.setDescricao(rs.getString("descricao"));
                local.setTipo_embarcacao(rs.getString("tipo_embarcacao"));
                local.setAno_afundamento(rs.getInt("ano_afundamento"));
                local.setProfundidade(rs.getDouble("profundidade"));
                local.setSituacao(Situacao.valueOf(rs.getString("situacao").toUpperCase()));
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
        String sql = "INSERT INTO tb_local (nome, localidade, descricao, tipo_embarcacao, ano_afundamento, profundidade, situacao, longitude, latitude) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = ConexaoDB.getConexao();
             PreparedStatement stm = con.prepareStatement(sql)) {

            stm.setString(1, l.getNome());
            stm.setString(2, l.getLocalidade());
            stm.setString(3, l.getDescricao());
            stm.setString(4, l.getTipo_embarcacao());
            stm.setInt(5, l.getAno_afundamento());
            stm.setDouble(6, l.getProfundidade());
            stm.setString(7, l.getSituacao().toString().toLowerCase()); 
            stm.setString(8, l.getLongitude());
            stm.setString(9, l.getLatitude());

            stm.executeUpdate(); 

        } catch (Exception e) {
            throw new RuntimeException("Erro ao inserir local: " + e.getMessage(), e);
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
                local.setNome(rs.getString("nome"));
                local.setLocalidade(rs.getString("localidade"));
                local.setDescricao(rs.getString("descricao"));
                local.setTipo_embarcacao(rs.getString("tipo_embarcacao"));
                local.setAno_afundamento(rs.getInt("ano_afundamento"));
                local.setProfundidade(rs.getDouble("profundidade"));
                local.setSituacao(Situacao.valueOf(rs.getString("situacao").toUpperCase()));
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
            String sql = "UPDATE tb_local SET nome = ?, localidade = ?, descricao = ?, tipo_embarcacao = ?, ano_afundamento = ?, profundidade = ?, situacao = ?, longitude = ?, latitude = ? WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);

            stm.setString(1, localAtualizado.getNome());
            stm.setString(2, localAtualizado.getLocalidade());
            stm.setString(3, localAtualizado.getDescricao());
            stm.setString(4, localAtualizado.getTipo_embarcacao());
            stm.setInt(5, localAtualizado.getAno_afundamento());
            stm.setDouble(6, localAtualizado.getProfundidade());
            stm.setString(7, localAtualizado.getSituacao().toString().toLowerCase());
            stm.setString(8, localAtualizado.getLongitude());
            stm.setString(9, localAtualizado.getLatitude());
            stm.setLong(10, id);

            stm.executeUpdate();

            stm.close();
            con.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao atualizar local: " + e.getMessage());
        }
    } 
}
