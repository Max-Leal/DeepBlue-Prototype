package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import models.Usuario;
import utils.ConexaoDB;

public class UsuarioDao {

	public static Usuario getUsuarioByEmail(String email) {
		Usuario usuario = new Usuario();
		try {
			Connection con = ConexaoDB.getConexao();
			String sql = "select * from tb_usuario where email = ?";
			PreparedStatement stm = con.prepareStatement(sql);
			stm.setString(1, email);
			ResultSet rs = stm.executeQuery();
			
			if (rs.next()) {
				usuario = new Usuario();
				usuario.setId(rs.getLong("id"));
				usuario.setNome(rs.getString("nome"));
				usuario.setData_nascimento(rs.getDate("data_nascimento").toLocalDate());
				usuario.setCpf(rs.getString("cpf"));
				usuario.setEmail(rs.getString("email"));
				usuario.setSenha(rs.getString("senha"));
			}
			rs.close();
			stm.close();
			con.close();
			return usuario;	
		} catch (Exception e) {
			throw new RuntimeException(e.getMessage());
		}
	}
	public static void insert(Usuario usuario) {
		try {
			Connection con = ConexaoDB.getConexao();
			String sql = "insert into tb_usuario (nome, data_nascimento, cpf, email, senha) values (?, ?, ?, ?, ?)";
			PreparedStatement stm = con.prepareStatement(sql);
			stm.setString(1, usuario.getNome());
			stm.setDate(2, java.sql.Date.valueOf(usuario.getData_nascimento()));
			stm.setString(3, usuario.getCpf());
			stm.setString(4, usuario.getEmail());
			stm.setString(5, usuario.getSenha());
			stm.execute();

			stm.close();
			con.close();
		} catch (Exception e) {
			throw new RuntimeException(e.getMessage());
		}
	}

	public static Usuario getUsuarioById(int id) {
		try {
			Connection con = ConexaoDB.getConexao();
			String sql = "select * from tb_usuario where id=?";
			PreparedStatement stm = con.prepareStatement(sql);
			stm.setInt(1, id);
			ResultSet rs = stm.executeQuery();
			Usuario usuario = null;
			if (rs.next()) {
				usuario = new Usuario();
				usuario.setId(rs.getLong("id"));
				usuario.setNome(rs.getString("nome"));
				usuario.setData_nascimento(rs.getDate("data_nascimento").toLocalDate());
				usuario.setCpf(rs.getString("cpf"));
				usuario.setEmail(rs.getString("email"));
				usuario.setSenha(rs.getString("senha"));
			}
			rs.close();
			stm.close();
			con.close();
			return usuario;
		} catch (Exception e) {
			throw new RuntimeException(e.getMessage());
		}
	}

	public static void deleteById(int id) {
		try {
			Connection con = ConexaoDB.getConexao();
			String sql = "delete from tb_usuario where id=?";
			PreparedStatement stm = con.prepareStatement(sql);
			stm.setInt(1, id);
			stm.execute();

			stm.close();
			con.close();
		} catch (Exception e) {
			throw new RuntimeException(e.getMessage());
		}
	}

	
	// usuarioAlterado (como atributo)
	public static void update(Long id, Usuario usuarioAlterado) {
		try {
			Connection con = ConexaoDB.getConexao();
			String sql = "update tb_usuario set nome = ?, data_nascimento = ?, cpf = ?, email = ?, senha = ? where id = ?";
			PreparedStatement stm = con.prepareStatement(sql);
			stm.setString(1, usuarioAlterado.getNome());
			stm.setDate(2, java.sql.Date.valueOf(usuarioAlterado.getData_nascimento()));
			stm.setString(3, usuarioAlterado.getCpf());
			stm.setString(4, usuarioAlterado.getEmail());
			stm.setString(5, usuarioAlterado.getSenha());
			stm.setLong(7, id);
			stm.execute();

			stm.close();
			con.close();

		} catch (Exception e) {
			throw new RuntimeException(e.getMessage());
		}
	}
}
