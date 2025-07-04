package controllers;

import daos.AvaliacaoDao;
import models.Avaliacao;

public class AvaliacaoController {

    // Buscar Avaliação por ID
    public Avaliacao getAvaliacaoById(Long id) {
        return AvaliacaoDao.getAvaliacaoById(id);
    }

    // Inserir Avaliação
    public void adicionarAvaliacao(Avaliacao a) {
        AvaliacaoDao.insert(a);
    }

    // Atualizar Avaliação
    public void updateAvaliacao(Long id, Avaliacao a) {
        AvaliacaoDao.update(id, a);
    }

    // Deletar Avaliação por ID
    public void deleteAvaliacaoById(Long id) {
        AvaliacaoDao.deleteById(id);
    }
}
