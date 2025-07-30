package controllers;

import java.util.List;

import daos.LocalDao;
import models.Local;

public class LocalController {

	// Buscar a lista de Locais
	public List<Local> listaLocais() {
		return LocalDao.getLista();
	}

	// Buscar Local por ID
	public Local getLocalById(int id) {
		return LocalDao.getLocalById(id);
	}

	// Inserir local
	public void adicionarLocal(Local l) {
		LocalDao.insert(l);
	}

	// Atualizar Local
	public void updateLocal(Long id, Local local) {
		LocalDao.update(id, local);
	}

	// Deletar agência por ID
	public void deleteLocalById(int id) {
		LocalDao.deleteById(id);
	}
	
	public int cadastrarLocalRetornandoId(Local local) {
	    return LocalDao.insertAndReturnId(local);
	}
	
	//Buscar na SearchBar
	public List<Local> buscarPorNome(String nome) {
	    return LocalDao.buscarPorNome(nome);
	}


}
