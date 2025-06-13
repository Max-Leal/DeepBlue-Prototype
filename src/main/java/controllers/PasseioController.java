package controllers;

import java.util.List;
import daos.PasseioDao;
import models.Passeio;

public class PasseioController {

    public static void cadastrarPasseio(Passeio passeio) {
        PasseioDao.insert(passeio);
    }

    public static Passeio buscarPasseioPorId(int id) {
        return PasseioDao.getPasseioById(id);
    }

    public static List<Passeio> listarPasseios() {
        return PasseioDao.listarTodos();
    }

    public static void atualizarPasseio(Passeio passeio) {
        PasseioDao.update(passeio);
    }

    public static void deletarPasseio(int id) {
        PasseioDao.deleteById(id);
    }
}