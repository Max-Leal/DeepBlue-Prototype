package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import Enums.Situacao;
import Enums.TipoPasseio;
import models.Passeio;
import utils.ConexaoDB;

public class PasseioDao {

    public static void insert(Passeio passeio) {
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "INSERT INTO tb_passeio (local, data, duracao, valor, tb_agencia_id, tipo, situacao) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, passeio.getLocal());
            stm.setDate(2, java.sql.Date.valueOf(passeio.getData()));
            stm.setString(3, passeio.getDuracao());
            stm.setDouble(4, passeio.getValor());
            stm.setInt(5, passeio.getAgenciaId());
            stm.setString(6, passeio.getTipo().toString().toLowerCase());
            stm.setString(7, passeio.getSituacao().toString().toLowerCase());
            stm.execute();

            stm.close();
            con.close();
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    public static Passeio getPasseioById(int id) {
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "SELECT * FROM tb_passeio WHERE id=?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            Passeio passeio = null;
            if (rs.next()) {
                passeio = new Passeio(
                    rs.getInt("id"),
                    rs.getString("local"),
                    rs.getDate("data").toLocalDate(),
                    rs.getString("duracao"),
                    rs.getDouble("valor"),
                    rs.getInt("tb_agencia_id"),
                    TipoPasseio.valueOf(rs.getString("tipo").toUpperCase()),
                    Situacao.valueOf(rs.getString("situacao").toUpperCase())
                );
            }
            rs.close();
            stm.close();
            con.close();
            return passeio;
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    public static List<Passeio> listarTodos() {
        List<Passeio> passeios = new ArrayList<>();
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "SELECT * FROM tb_passeio";
            PreparedStatement stm = con.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Passeio passeio = new Passeio(
                    rs.getInt("id"),
                    rs.getString("local"),
                    rs.getDate("data").toLocalDate(),
                    rs.getString("duracao"),
                    rs.getDouble("valor"),
                    rs.getInt("tb_agencia_id"),
                    TipoPasseio.valueOf(rs.getString("tipo").toUpperCase()),
                    Situacao.valueOf(rs.getString("situacao").toUpperCase())
                );
                passeios.add(passeio);
            }
            rs.close();
            stm.close();
            con.close();
            return passeios;
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    public static void deleteById(int id) {
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "DELETE FROM tb_passeio WHERE id=?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, id);
            stm.execute();

            stm.close();
            con.close();
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    public static void update(Passeio passeioAlterado) {
        try {
            Connection con = ConexaoDB.getConexao();
            String sql = "UPDATE tb_passeio SET local=?, data=?, duracao=?, valor=?, tb_agencia_id=?, tipo=?, situacao=? WHERE id=?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, passeioAlterado.getLocal());
            stm.setDate(2, java.sql.Date.valueOf(passeioAlterado.getData()));
            stm.setString(3, passeioAlterado.getDuracao());
            stm.setDouble(4, passeioAlterado.getValor());
            stm.setInt(5, passeioAlterado.getAgenciaId());
            stm.setString(6, passeioAlterado.getTipo().toString().toLowerCase());
            stm.setString(7, passeioAlterado.getSituacao().toString().toLowerCase());
            stm.setInt(8, passeioAlterado.getId());
            stm.execute();

            stm.close();
            con.close();

        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }
}