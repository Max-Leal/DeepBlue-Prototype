package controllers;

import java.util.List;

import daos.AgenciaLocalDao;
import models.AgenciaLocal;

public class AgenciaLocalController {
    
    // Inserir relação entre agência e local
    public void registerAgenciaLocal(AgenciaLocal agenciaLocal) {
        AgenciaLocalDao.insert(agenciaLocal);
    }

    // Atualizar relação
    public void updateAgenciaLocal(AgenciaLocal agenciaLocal) {
        AgenciaLocalDao.update(agenciaLocal);
    }

    // Deletar relação entre agência e local
    public void deleteAgenciaLocal(int idAgencia, int idLocal) {
        AgenciaLocalDao.delete(idAgencia, idLocal);
    }

    // Buscar uma relação específica por IDs
    public AgenciaLocal getAgenciaLocalByIds(int idAgencia, int idLocal) {
        return AgenciaLocalDao.getByIds(idAgencia, idLocal);
    }

    // Listar todas as relações entre agências e locais
    public List<AgenciaLocal> listarTodasAgenciaLocal() {
        return AgenciaLocalDao.getAll();
    }
}
