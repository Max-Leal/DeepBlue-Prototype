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
        try (Connection con = ConexaoDB.getConexao()) {
            String sql = "INSERT INTO tb_agencia_local (id_agencia, id_local, tipo_atividade) VALUES (?, ?, ?)";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, agenciaLocal.getIdAgencia());
            stm.setInt(2, agenciaLocal.getIdLocal());
            stm.setString(3, agenciaLocal.getTipoAtividade());
            stm.executeUpdate();
            stm.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao inserir relação agência-local: " + e.getMessage());
        }
    }

    public static List<AgenciaLocal> getAll() {
        List<AgenciaLocal> lista = new ArrayList<>();
        try (Connection con = ConexaoDB.getConexao()) {
            String sql = "SELECT * FROM tb_agencia_local";
            PreparedStatement stm = con.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                AgenciaLocal al = new AgenciaLocal();
                al.setIdAgencia(rs.getInt("id_agencia"));
                al.setIdLocal(rs.getInt("id_local"));
                al.setTipoAtividade(rs.getString("tipo_atividade"));
                lista.add(al);
            }

            rs.close();
            stm.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao listar relações agência-local: " + e.getMessage());
        }
        return lista;
    }

    public static List<AgenciaLocal> getAgenciasByLocalId(int idLocal) {
        List<AgenciaLocal> lista = new ArrayList<>();
        try (Connection con = ConexaoDB.getConexao()) {
            String sql = "SELECT * FROM tb_agencia_local WHERE id_local = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, idLocal);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                AgenciaLocal al = new AgenciaLocal();
                al.setIdAgencia(rs.getInt("id_agencia"));
                al.setIdLocal(rs.getInt("id_local"));
                al.setTipoAtividade(rs.getString("tipo_atividade"));
                lista.add(al);
            }

            rs.close();
            stm.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao buscar agências por local: " + e.getMessage());
        }
        return lista;
    }

    public static List<AgenciaLocal> getLocaisByAgenciaId(Long idAgencia) {
        List<AgenciaLocal> lista = new ArrayList<>();
        try (Connection con = ConexaoDB.getConexao()) {
            String sql = "SELECT * FROM tb_agencia_local WHERE id_agencia = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setLong(1, idAgencia);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                AgenciaLocal al = new AgenciaLocal();
                al.setIdAgencia(rs.getInt("id_agencia"));
                al.setIdLocal(rs.getInt("id_local"));
                al.setTipoAtividade(rs.getString("tipo_atividade"));
                lista.add(al);
            }

            rs.close();
            stm.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao buscar locais por agência: " + e.getMessage());
        }
        return lista;
    }

    public static void delete(int idAgencia, int idLocal) {
        try (Connection con = ConexaoDB.getConexao()) {
            String sql = "DELETE FROM tb_agencia_local WHERE id_agencia = ? AND id_local = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, idAgencia);
            stm.setInt(2, idLocal);
            stm.execute();
            stm.close();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao deletar relação agência-local: " + e.getMessage());
        }
    }
}
