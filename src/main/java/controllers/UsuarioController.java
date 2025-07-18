package controllers;

import daos.UsuarioDao;
import models.Usuario;
import utils.HashUtil;

public class UsuarioController {

    // Cadastro
    public void registerUsuario(Usuario usuario) {
        usuario.setSenhaHash(usuario.getSenha());
        UsuarioDao.insert(usuario);
    }

    // Login
    public boolean loginUsuario(String email, String senha) {
        Usuario usuario = UsuarioDao.getUsuarioByEmail(email);
        return usuario != null && HashUtil.verificarSenha(senha, usuario.getSenha());
    }

    // Buscar por ID
    public Usuario getUsuarioById(int id) {
        return UsuarioDao.getUsuarioById(id);
    }

    // Buscar por email
    public Usuario getUsuarioByEmail(String email) {
        return UsuarioDao.getUsuarioByEmail(email);
    }

    // Atualizar
    public void updateUsuario(Long id, Usuario usuario) {
        UsuarioDao.update(id, usuario);
    }

    // Deletar
    public void deleteUsuarioById(int id) {
        UsuarioDao.deleteById(id);
    }
}
