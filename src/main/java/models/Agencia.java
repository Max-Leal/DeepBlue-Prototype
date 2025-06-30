package models;

import Enums.Situacao;

public class Agencia {
	private Long id;
	private String nomeEmpresarial;
	private String cnpj;
	private String email;
	private String senha;
	private Situacao situacao;

	public Agencia() {
	}

	public Agencia(String nomeEmpresarial, String cnpj, String email, String senha, Situacao situacao) {
		super();
		this.nomeEmpresarial = nomeEmpresarial;
		this.cnpj = cnpj;
		this.email = email;
		this.senha = senha;
		this.situacao = situacao;
	}



	public Agencia(Long id, String nomeEmpresarial, String cnpj, String email, String senha, Situacao situacao) {
		this.id = id;
		this.nomeEmpresarial = nomeEmpresarial;
		this.cnpj = cnpj;
		this.email = email;
		this.senha = senha;
		this.situacao = situacao;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getNomeEmpresarial() {
		return nomeEmpresarial;
	}

	public void setNomeEmpresarial(String nomeEmpresarial) {
		this.nomeEmpresarial = nomeEmpresarial;
	}

	public String getCnpj() {
		return cnpj;
	}

	public void setCnpj(String cnpj) {
		this.cnpj = cnpj;
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

	public Situacao getSituacao() {
		return situacao;
	}

	public void setSituacao(Situacao situacao) {
		this.situacao = situacao;
	}
}