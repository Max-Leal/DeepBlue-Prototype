package controllers;

import java.util.List;

import daos.AgenciaLocalDao;
import models.AgenciaLocal;

public class AgenciaLocalController {

    public void adicionar(AgenciaLocal al) {
        AgenciaLocalDao.insert(al);
    }

    public List<AgenciaLocal> listarTodos() {
        return AgenciaLocalDao.getAll();
    }

    public void remover(int idAgencia, int idLocal) {
        AgenciaLocalDao.delete(idAgencia, idLocal);
    }

    public List<AgenciaLocal> getAgenciasPorLocal(int idLocal) {
        return AgenciaLocalDao.getAgenciasByLocalId(idLocal);
    }

    public List<AgenciaLocal> getLocaisPorAgencia(int idAgencia) {
        return AgenciaLocalDao.getLocaisByAgenciaId(idAgencia);
    }
}
