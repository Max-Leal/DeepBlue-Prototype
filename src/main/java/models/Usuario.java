package models;

import java.time.LocalDate;

public class Usuario {

	private Long id;
	private String nome;
	private LocalDate data_nascimento;
	private String cpf;
	private String email;
	private String senha;
	
	public Usuario(String nome, LocalDate data_nascimento, String cpf, String email, String senha) {
		this.nome = nome;
		this.data_nascimento = data_nascimento;
		this.cpf = cpf;
		this.email = email;
		this.senha = senha;
	}

	public Usuario() {
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
	

	

}
