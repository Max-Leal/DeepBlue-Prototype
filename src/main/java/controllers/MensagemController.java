package controllers;

import java.util.List;

import Enums.TipoUsuario;
import daos.MensagemDao;
import models.Mensagem;

public class MensagemController {

    // Enviar uma nova mensagem
    public void enviarMensagem(Mensagem mensagem) {
        MensagemDao.insert(mensagem);
    }

    // Buscar uma mensagem específica por ID
    public Mensagem buscarMensagemPorId(Long id) {
        return MensagemDao.getById(id);
    }

    // Buscar conversa entre dois participantes (independente de serem usuários ou agências)
    public List<Mensagem> buscarConversas(Long idA, TipoUsuario tipoA, Long idB, TipoUsuario tipoB) {
        return MensagemDao.getConversasEntre(idA, tipoA, idB, tipoB);
    }

    // Deletar mensagem por ID
    public void deletarMensagem(Long id) {
        MensagemDao.deleteById(id);
    }
}
