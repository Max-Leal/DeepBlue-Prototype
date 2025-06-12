package controllers;

import daos.UsuarioDao;
import models.Usuario;

public class UsuarioController {
	// This class will handle user-related operations such as registration, login,
	// and profile management.
	// It will interact with the UsuarioDao to perform database operations.

	// Example method for user registration
	public void registerUser(Usuario usuario) {
		UsuarioDao.insert(usuario);
	}

	// Example method for user login
	public boolean loginUser(String email, String senha) {
		Usuario user = UsuarioDao.getUsuarioByEmail(email);
		if (user != null && user.getSenha().equals(senha)) {
			// User authenticated successfully
			return true;
		}
		return false; // Placeholder return value
	}

	// Método para buscar um usuário pelo ID
	public Usuario getUsuarioById(int id) {
		return UsuarioDao.getUsuarioById(id);
	}

	public Usuario getUsuarioByEmail(String email) {
		return UsuarioDao.getUsuarioByEmail(email);
	}
	
}
