package controllers;

import java.util.List;

import daos.AvaliacaoAgenciaDao;
import models.AvaliacaoAgencia;
import models.AvaliacaoLocal;

public class AvaliacaoAgenciaController {

	public List<AvaliacaoAgencia> getAvaliacoesPorAgencia(Long id){
		return AvaliacaoAgenciaDao.getAvaliacoesPorAgencia(id);
	}
	
	public List<AvaliacaoAgencia> getUltimasAvaliacoes(int limit) {
		return AvaliacaoAgenciaDao.getUltimasAvaliacoes(limit);
	}
	
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
