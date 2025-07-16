package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import models.Usuario;
import utils.ConexaoDB;

public class UsuarioDao {

	public static Usuario autenticar(String email, String senha) {
	    Usuario usuario = null;
	    try {
	        Connection con = ConexaoDB.getConexao();
	        String sql = "SELECT * FROM tb_usuario WHERE email = ? AND senha = ?";
	        PreparedStatement stm = con.prepareStatement(sql);
	        stm.setString(1, email);
	        stm.setString(2, senha);
	        ResultSet rs = stm.executeQuery();

	        if (rs.next()) {
	            usuario = new Usuario();
	            usuario.setId(rs.getLong("id"));
	            usuario.setNome(rs.getString("nome"));
	            usuario.setEmail(rs.getString("email"));
	            usuario.setSenha(rs.getString("senha"));
	            usuario.setFoto(rs.getString("foto"));
	        }

	        rs.close();
	        stm.close();
	        con.close();
	        return usuario;

	    } catch (Exception e) {
	        throw new RuntimeException(e.getMessage());
	    }
	}
	
    public static Usuario getUsuarioByEmail(String email) {
        Usuario usuario = null;
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "SELECT * FROM tb_usuario WHERE email = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, email);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                usuario = new Usuario();
                usuario.setId(rs.getLong("id"));
                usuario.setNome(rs.getString("nome"));
                usuario.setEmail(rs.getString("email"));
                usuario.setSenha(rs.getString("senha"));
                usuario.setFoto(rs.getString("foto"));
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
            String sql = "INSERT INTO tb_usuario (nome, email, senha, foto) VALUES (?, ?, ?, ?)";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, usuario.getNome());
            stm.setString(2, usuario.getEmail());
            stm.setString(3, usuario.getSenha());
            stm.setString(4, usuario.getFoto());
            stm.execute();

            stm.close();
            con.close();
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    public static Usuario getUsuarioById(int id) {
        Usuario usuario = null;
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "SELECT * FROM tb_usuario WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                usuario = new Usuario();
                usuario.setId(rs.getLong("id"));
                usuario.setNome(rs.getString("nome"));
                usuario.setEmail(rs.getString("email"));
                usuario.setSenha(rs.getString("senha"));
                usuario.setFoto(rs.getString("foto"));
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
            String sql = "DELETE FROM tb_usuario WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, id);
            stm.execute();

            stm.close();
            con.close();
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    public static void update(Long id, Usuario usuarioAlterado) {
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "UPDATE tb_usuario SET nome = ?, email = ?, senha = ?, foto = ? WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, usuarioAlterado.getNome());
            stm.setString(2, usuarioAlterado.getEmail());
            stm.setString(3, usuarioAlterado.getSenha());
            stm.setString(4, usuarioAlterado.getFoto());
            stm.setLong(5, id);
            stm.execute();

            stm.close();
            con.close();
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }
}
