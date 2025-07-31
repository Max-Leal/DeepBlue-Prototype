package controllers;

import java.util.List;

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

    // Buscar conversa entre um usuário e uma agência (ordenada por data)
    public List<Mensagem> buscarConversas(Long idUsuario, Long idAgencia) {
        return MensagemDao.getConversasEntreUsuarioEAgencia(idUsuario, idAgencia);
    }

    // Deletar mensagem por ID (opcional, se for necessário no sistema)
    public void deletarMensagem(Long id) {
        MensagemDao.deleteById(id);
    }
}
