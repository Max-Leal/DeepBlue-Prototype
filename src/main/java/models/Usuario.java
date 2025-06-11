package models;

import java.time.LocalDate;

import Enums.TipoUsuario;

public class Usuario {

	private int id;
	private String nome;
	private LocalDate data_nascimento;
	private String cpf;
	private String email;
	private String senha;
	private TipoUsuario tipo;

	public Usuario() {
	}

	public Usuario(String nome, LocalDate data_nascimento, String cpf, String email, String senha, TipoUsuario tipo) {
		super();
		this.nome = nome;
		this.data_nascimento = data_nascimento;
		this.cpf = cpf;
		this.email = email;
		this.senha = senha;
		this.tipo = tipo;
	}

	public Usuario(int id, String nome, LocalDate data_nascimento, String cpf, String email, String senha,
			TipoUsuario tipo) {
		super();
		this.id = id;
		this.nome = nome;
		this.data_nascimento = data_nascimento;
		this.cpf = cpf;
		this.email = email;
		this.senha = senha;
		this.tipo = tipo;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public LocalDate getData_nascimento() {
		return data_nascimento;
	}

	public void setData_nascimento(LocalDate data_nascimento) {
		this.data_nascimento = data_nascimento;
	}

	public String getCpf() {
		return cpf;
	}

	public void setCpf(String cpf) {
		this.cpf = cpf;
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

	public TipoUsuario getTipo() {
		return tipo;
	}

	public void setTipo(TipoUsuario tipo) {
		this.tipo = tipo;
	}

	@Override
	public String toString() {
		return "Usuario [id=" + id + ", nome=" + nome + ", data_nascimento=" + data_nascimento + ", cpf=" + cpf
				+ ", email=" + email + ", tipo=" + tipo + "]";
	}

}
