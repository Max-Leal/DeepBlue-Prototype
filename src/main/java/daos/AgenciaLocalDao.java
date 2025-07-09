package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import models.AgenciaLocal;
import utils.ConexaoDB;

public class AgenciaLocalDao {

    public static void insert(AgenciaLocal agenciaLocal) {
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "INSERT INTO tb_agencia_local (id_agencia, id_local, oferece_mergulho, oferece_passeio) VALUES (?, ?, ?, ?)";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, agenciaLocal.getIdAgencia());
            stm.setInt(2, agenciaLocal.getIdLocal());
            stm.setBoolean(3, agenciaLocal.isOfereceMergulho());
            stm.setBoolean(4, agenciaLocal.isOferecePasseio());
            stm.execute();

            stm.close();
            con.close();
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    public static List<AgenciaLocal> getAll() {
        List<AgenciaLocal> lista = new ArrayList<>();
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "SELECT * FROM tb_agencia_local";
            PreparedStatement stm = con.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                AgenciaLocal al = new AgenciaLocal();
                al.setIdAgencia(rs.getInt("id_agencia"));
                al.setIdLocal(rs.getInt("id_local"));
                al.setOfereceMergulho(rs.getBoolean("oferece_mergulho"));
                al.setOferecePasseio(rs.getBoolean("oferece_passeio"));
                lista.add(al);
            }

            rs.close();
            stm.close();
            con.close();
            return lista;
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    public static void delete(int idAgencia, int idLocal) {
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "DELETE FROM tb_agencia_local WHERE id_agencia = ? AND id_local = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, idAgencia);
            stm.setInt(2, idLocal);
            stm.execute();

            stm.close();
            con.close();
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    // 🔍 Buscar todas as agências que atendem um local
    public static List<AgenciaLocal> getAgenciasByLocalId(int idLocal) {
        List<AgenciaLocal> lista = new ArrayList<>();
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "SELECT * FROM tb_agencia_local WHERE id_local = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, idLocal);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                AgenciaLocal al = new AgenciaLocal();
                al.setIdAgencia(rs.getInt("id_agencia"));
                al.setIdLocal(rs.getInt("id_local"));
                al.setOfereceMergulho(rs.getBoolean("oferece_mergulho"));
                al.setOferecePasseio(rs.getBoolean("oferece_passeio"));
                lista.add(al);
            }

            rs.close();
            stm.close();
            con.close();
            return lista;
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    // 🔍 Buscar todos os locais associados a uma agência
    public static List<AgenciaLocal> getLocaisByAgenciaId(int idAgencia) {
        List<AgenciaLocal> lista = new ArrayList<>();
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "SELECT * FROM tb_agencia_local WHERE id_agencia = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, idAgencia);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                AgenciaLocal al = new AgenciaLocal();
                al.setIdAgencia(rs.getInt("id_agencia"));
                al.setIdLocal(rs.getInt("id_local"));
                al.setOfereceMergulho(rs.getBoolean("oferece_mergulho"));
                al.setOferecePasseio(rs.getBoolean("oferece_passeio"));
                lista.add(al);
            }

            rs.close();
            stm.close();
            con.close();
            return lista;
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }
}
