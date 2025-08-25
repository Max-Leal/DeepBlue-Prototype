package controllers;

import java.util.List;

import Enums.TipoUsuario;
import daos.MensagemDao;
import models.Mensagem;

public class MensagemController {

	public List<Mensagem> buscarConversas(Long id, TipoUsuario tipo) {
	    return MensagemDao.getConversas(id, tipo);
	}
	
    // Enviar uma nova mensagem
    public void enviarMensagem(Mensagem mensagem) {
        MensagemDao.insert(mensagem);
    }

    // Buscar uma mensagem específica por ID
    public Mensagem buscarMensagemPorId(Long id) {
        return MensagemDao.getById(id);
    }

    // Buscar conversa do usuario logado
    public List<Mensagem> buscarTodasAsMensagensDoUsuario(Long idUsuario, TipoUsuario tipoUsuario) {
        return MensagemDao.getTodasAsMensagensDoUsuario(idUsuario, tipoUsuario);
    }

    // Deletar mensagem por ID
    public void deletarMensagem(Long id) {
        MensagemDao.deleteById(id);
    }
    
}
