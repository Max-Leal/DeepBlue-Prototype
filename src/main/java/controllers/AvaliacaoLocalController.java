package controllers;

import java.util.List;

import daos.AvaliacaoLocalDao;
import models.AvaliacaoLocal;

public class AvaliacaoLocalController {

    public void adicionarAvaliacao(AvaliacaoLocal avaliacao) {
        AvaliacaoLocalDao.insert(avaliacao);
    }

    public AvaliacaoLocal buscarPorId(Long id) {
        return AvaliacaoLocalDao.getById(id);
    }

    public List<AvaliacaoLocal> listarAvaliacoes() {
        return AvaliacaoLocalDao.getAll();
    }

    public void removerAvaliacao(Long id) {
        AvaliacaoLocalDao.deleteById(id);
    }

    public void atualizarAvaliacao(Long id, AvaliacaoLocal nova) {
        AvaliacaoLocalDao.update(id, nova);
    }
}
