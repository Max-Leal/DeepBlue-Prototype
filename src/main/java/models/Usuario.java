package models;

import utils.HashUtil;

public class Usuario {

    private Long id;
    private String nome;
    private String email;
    private String senha;
    private String foto;

    public Usuario() {}

    public Usuario(String nome, String email, String senha, String foto) {
        this.nome = nome;
        this.email = email;
        this.senha = HashUtil.hashSenha(senha);
        this.foto = foto;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public void setSenhaHash(String senha) {
        this.senha = HashUtil.hashSenha(senha);
    }

    public String getFoto() {
        return foto;
    }

    public void setFoto(String foto) {
        this.foto = foto;
    }
}
