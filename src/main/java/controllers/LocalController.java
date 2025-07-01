package controllers;

import daos.LocalDao;
import models.Local;

public class LocalController {

    // Buscar Local por ID
    public Local getLocalById(int id) {
        return LocalDao.getLocalById(id);
    }
    
    // Inserir local
    public void adicionarLocal(Local l) {
    	LocalDao.insert(l);
    }

    // Atualizar Local
    public void updateLocal(Long id,Local local) {
    	LocalDao.update(id,local);
    }

    // Deletar agência por ID
    public void deleteLocalById(int id) {
    	LocalDao.deleteById(id);
    }
}
