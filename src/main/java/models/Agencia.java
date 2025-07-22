package models;

import Enums.Situacao;
import utils.HashUtil;

public class Agencia {
    private Long id;
    private String nomeEmpresarial;
    private String cnpj;
    private String email;
    private String senha;
    private Situacao situacao;
    private String descricao;
    private String cep;
    private String telefone;
    private String whatsapp;
    private String instagram;

    public Agencia() {}

    public Agencia(String nomeEmpresarial, String cnpj, String email, String senha, Situacao situacao) {
        this.nomeEmpresarial = nomeEmpresarial;
        this.cnpj = cnpj;
        this.email = email;
        this.senha = HashUtil.hashSenha(senha);
        this.situacao = situacao;
    }

    // Getters e Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getNomeEmpresarial() { return nomeEmpresarial; }
    public void setNomeEmpresarial(String nomeEmpresarial) { this.nomeEmpresarial = nomeEmpresarial; }

    public String getCnpj() { return cnpj; }
    public void setCnpj(String cnpj) { this.cnpj = cnpj; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getSenha() { return senha; }
    public void setSenha(String senha) { this.senha = senha; }
    public void setSenhaHash(String senha) { this.senha = HashUtil.hashSenha(senha); }

    public Situacao getSituacao() { return situacao; }
    public void setSituacao(Situacao situacao) { this.situacao = situacao; }

    public String getDescricao() { return descricao; }
    public void setDescricao(String descricao) { this.descricao = descricao; }

    public String getCep() { return cep; }
    public void setCep(String cep) { this.cep = cep; }

    public String getTelefone() { return telefone; }
    public void setTelefone(String telefone) { this.telefone = telefone; }

    public String getWhatsapp() { return whatsapp; }
    public void setWhatsapp(String whatsapp) { this.whatsapp = whatsapp; }

    public String getInstagram() { return instagram; }
    public void setInstagram(String instagram) { this.instagram = instagram; }
}
