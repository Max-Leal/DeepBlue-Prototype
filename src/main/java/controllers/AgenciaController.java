package controllers;

import java.util.List;

import daos.AgenciaDao;
import models.Agencia;
import utils.HashUtil;

public class AgenciaController {
	
	public List<Agencia> listaAgencias() {
		return  AgenciaDao.getAllAgencias();
	}
	
    // Cadastro de agência
    public void registerAgencia(Agencia agencia) {
        AgenciaDao.insert(agencia);
    }

    // Login de agência
    public boolean loginAgencia(String email, String senha) {
        Agencia agencia = AgenciaDao.getAgenciaByEmail(email);
     
        return HashUtil.verificarSenha(senha, agencia.getSenha());
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
    public void updateAgencia(Long id,Agencia agencia) {
        AgenciaDao.update(id,agencia);
    }

    // Deletar agência por ID
    public void deleteAgenciaById(int id) {
        AgenciaDao.deleteById(id);
    }
}