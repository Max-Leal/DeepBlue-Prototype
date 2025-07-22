package controllers;

import java.util.List;

import daos.AgenciaDao;
import models.Agencia;
import utils.HashUtil;

public class AgenciaController {

    // Listar todas as agências
    public List<Agencia> listaAgencias() {
        return AgenciaDao.getAllAgencias();
    }

    // Cadastro de nova agência
    public void registerAgencia(Agencia agencia) {
        // Garante que a senha será criptografada antes de salvar
        agencia.setSenhaHash(agencia.getSenha());
        AgenciaDao.insert(agencia);
    }

    // Autenticação de login de agência
    public boolean loginAgencia(String email, String senha) {
        Agencia agencia = AgenciaDao.getAgenciaByEmail(email);

        if (agencia != null) {
            return HashUtil.verificarSenha(senha, agencia.getSenha());
        }

        return false;
    }

    // Buscar uma agência por ID
    public Agencia getAgenciaById(int id) {
        return AgenciaDao.getAgenciaById(id);
    }

    // Buscar uma agência por e-mail
    public Agencia getAgenciaByEmail(String email) {
        return AgenciaDao.getAgenciaByEmail(email);
    }

    // Atualizar dados da agência
    public void updateAgencia(Long id, Agencia agencia) {
        AgenciaDao.update(id, agencia);
    }

    // Excluir agência pelo ID
    public void deleteAgenciaById(int id) {
        AgenciaDao.deleteById(id);
    }
}
