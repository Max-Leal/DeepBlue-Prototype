package controllers;

import daos.AvaliacaoAgenciaDao;
import models.AvaliacaoAgencia;

public class AvaliacaoAgenciaController {

    // Cadastrar uma nova avaliação
    public void registrarAvaliacao(AvaliacaoAgencia avaliacao) {
        AvaliacaoAgenciaDao.insert(avaliacao);
    }

    // Buscar uma avaliação por ID
    public AvaliacaoAgencia getAvaliacaoPorId(Long id) {
        return AvaliacaoAgenciaDao.getAvaliacaoById(id);
    }

    // Atualizar uma avaliação existente
    public void atualizarAvaliacao(Long id, AvaliacaoAgencia novaAvaliacao) {
        AvaliacaoAgenciaDao.update(id, novaAvaliacao);
    }

    // Remover uma avaliação
    public void deletarAvaliacao(Long id) {
        AvaliacaoAgenciaDao.deleteById(id);
    }
}
