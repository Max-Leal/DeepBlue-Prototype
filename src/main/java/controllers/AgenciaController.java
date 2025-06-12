package controllers;

import daos.AgenciaDao;
import models.Agencia;

public class AgenciaController {
    // Cadastro de agência
    public void registerAgencia(Agencia agencia) {
        AgenciaDao.insert(agencia);
    }

    // Login de agência
    public boolean loginAgencia(String email, String senha) {
        Agencia agencia = AgenciaDao.getAgenciaByEmail(email);
        if (agencia != null && agencia.getSenha().equals(senha)) {
            return true;
        }
        return false;
    }

    // Buscar agência por ID
    public Agencia getAgenciaById(int id) {
        return AgenciaDao.getAgenciaById(id);
    }

    // Buscar agência por email
    public Agencia getAgenciaByEmail(String email) {
        return AgenciaDao.getAgenciaByEmail(email);
    }

    // Atualizar agência
    public void updateAgencia(Agencia agencia) {
        AgenciaDao.update(agencia);
    }

    // Deletar agência por ID
    public void deleteAgenciaById(int id) {
        AgenciaDao.deleteById(id);
    }
}