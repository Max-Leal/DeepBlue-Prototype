package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import Enums.Situacao;
import models.Agencia;
import utils.ConexaoDB;

public class AgenciaDao {

    public static Agencia getAgenciaByEmail(String email) {
        Agencia agencia = null;
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "SELECT * FROM tb_agencia WHERE email = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, email);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                agencia = new Agencia();
                agencia.setId(rs.getInt("id"));
                agencia.setNomeEmpresarial(rs.getString("nome_empresarial"));
                agencia.setCnpj(rs.getString("cnpj"));
                agencia.setEmail(rs.getString("email"));
                agencia.setSenha(rs.getString("senha"));
                agencia.setSituacao(Situacao.valueOf(rs.getString("situacao").toUpperCase()));
            }
            rs.close();
            stm.close();
            con.close();
            return agencia;
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    public static void insert(Agencia agencia) {
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "INSERT INTO tb_agencia (nome_empresarial, cnpj, email, senha, situacao) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, agencia.getNomeEmpresarial());
            stm.setString(2, agencia.getCnpj());
            stm.setString(3, agencia.getEmail());
            stm.setString(4, agencia.getSenha());
            stm.setString(5, agencia.getSituacao().toString().toLowerCase());
            stm.execute();

            stm.close();
            con.close();
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    public static Agencia getAgenciaById(int id) {
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "SELECT * FROM tb_agencia WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            Agencia agencia = null;
            if (rs.next()) {
                agencia = new Agencia();
                agencia.setId(rs.getInt("id"));
                agencia.setNomeEmpresarial(rs.getString("nome_empresarial"));
                agencia.setCnpj(rs.getString("cnpj"));
                agencia.setEmail(rs.getString("email"));
                agencia.setSenha(rs.getString("senha"));
                agencia.setSituacao(Situacao.valueOf(rs.getString("situacao").toUpperCase()));
            }
            rs.close();
            stm.close();
            con.close();
            return agencia;
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    public static void deleteById(int id) {
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "DELETE FROM tb_agencia WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, id);
            stm.execute();

            stm.close();
            con.close();
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    public static void update(Agencia agenciaAlterada) {
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "UPDATE tb_agencia SET nome_empresarial = ?, cnpj = ?, email = ?, senha = ?, situacao = ? WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, agenciaAlterada.getNomeEmpresarial());
            stm.setString(2, agenciaAlterada.getCnpj());
            stm.setString(3, agenciaAlterada.getEmail());
            stm.setString(4, agenciaAlterada.getSenha());
            stm.setString(5, agenciaAlterada.getSituacao().toString().toLowerCase());
            stm.setInt(6, agenciaAlterada.getId());
            stm.execute();

            stm.close();
            con.close();

        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }
}