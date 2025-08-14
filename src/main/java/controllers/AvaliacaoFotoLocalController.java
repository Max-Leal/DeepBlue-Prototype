package controllers;

import java.util.List;

import daos.AvaliacaoFotoLocalDao;
import models.AvaliacaoFotoLocal;

public class AvaliacaoFotoLocalController {

    public void adicionarFoto(AvaliacaoFotoLocal foto) {
        AvaliacaoFotoLocalDao.insert(foto);
    }

    public List<AvaliacaoFotoLocal> listarFotosPorAvaliacao(Long idAvaliacao) {
        return AvaliacaoFotoLocalDao.getFotosByAvaliacaoId(idAvaliacao);
    }

    public void removerFoto(Long id) {
        AvaliacaoFotoLocalDao.deleteById(id);
    }

    public void removerFotosPorAvaliacao(Long idAvaliacao) {
        AvaliacaoFotoLocalDao.deleteByAvaliacaoId(idAvaliacao);
    }
}
