package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import Enums.TipoUsuario;
import models.Usuario;
import utils.ConexaoDB;

public class UsuarioDao {

	public static Usuario getUsuarioByEmail(String email) {
		try {
			Connection con = ConexaoDB.getConexao();
			String sql = "select * from tb_usuario where email = ?";
			PreparedStatement stm = con.prepareStatement(sql);
			stm.setString(1, email);
			ResultSet rs = stm.executeQuery();
			Usuario usuario = null;
			if (rs.next()) {
				usuario = new Usuario();
				usuario.setId(rs.getInt("id"));
				usuario.setNome(rs.getString("nome"));
				usuario.setData_nascimento(rs.getDate("data_nascimento").toLocalDate());
				usuario.setCpf(rs.getString("cpf"));
				usuario.setEmail(rs.getString("email"));
				usuario.setSenha(rs.getString("senha"));
				usuario.setTipo(TipoUsuario.valueOf(rs.getString("tipo")));
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
			String sql = "insert into tb_usuario (nome, data_nascimento, cpf, email, senha, tipo) values (?, ?, ?, ?, ?, ?)";
			PreparedStatement stm = con.prepareStatement(sql);
			stm.setString(1, usuario.getNome());
			stm.setDate(2, java.sql.Date.valueOf(usuario.getData_nascimento()));
			stm.setString(3, usuario.getCpf());
			stm.setString(4, usuario.getEmail());
			stm.setString(5, usuario.getSenha());
			stm.setString(6, usuario.getTipo().toString());
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
				usuario.setId(rs.getInt("id"));
				usuario.setNome(rs.getString("nome"));
				usuario.setData_nascimento(rs.getDate("data_nascimento").toLocalDate());
				usuario.setCpf(rs.getString("cpf"));
				usuario.setEmail(rs.getString("email"));
				usuario.setSenha(rs.getString("senha"));
				usuario.setTipo(TipoUsuario.valueOf(rs.getString("tipo")));
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

	// o usuario vai ser encontrado pelo id que for passado na entidade
	// usuarioAlterado (como atributo)
	public static void update(Usuario usuarioAlterado) {
		try {
			Connection con = ConexaoDB.getConexao();
			String sql = "update tb_usuario set nome = ?, data_nascimento = ?, cpf = ?, email = ?, senha = ?, tipo = ? where id = ?";
			PreparedStatement stm = con.prepareStatement(sql);
			stm.setString(1, usuarioAlterado.getNome());
			stm.setDate(2, java.sql.Date.valueOf(usuarioAlterado.getData_nascimento()));
			stm.setString(3, usuarioAlterado.getCpf());
			stm.setString(4, usuarioAlterado.getEmail());
			stm.setString(5, usuarioAlterado.getSenha());
			stm.setString(6, usuarioAlterado.getTipo().toString());
			stm.setInt(7, usuarioAlterado.getId());
			stm.execute();

			stm.close();
			con.close();

		} catch (Exception e) {
			throw new RuntimeException(e.getMessage());
		}
	}
}
