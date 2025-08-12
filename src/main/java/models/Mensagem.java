package models;

import java.time.LocalDateTime;

import Enums.TipoUsuario;

public class Mensagem {
	private Long id;
	private Long remetenteId;
	private TipoUsuario remetenteTipo;
	private Long destinatarioId;
	private TipoUsuario destinatarioTipo;
	private String conteudo;
	private LocalDateTime dataEnvio;

	public Mensagem() {
		
	}

	public Mensagem(Long remetenteId, TipoUsuario remetenteTipo, Long destinatarioId, TipoUsuario destinatarioTipo,
			String conteudo, LocalDateTime dataEnvio) {
		super();
		this.remetenteId = remetenteId;
		this.remetenteTipo = remetenteTipo;
		this.destinatarioId = destinatarioId;
		this.destinatarioTipo = destinatarioTipo;
		this.conteudo = conteudo;
		this.dataEnvio = dataEnvio;
	}

	public Mensagem(Long id, Long remetenteId, TipoUsuario remetenteTipo, Long destinatarioId,
			TipoUsuario destinatarioTipo, String conteudo, LocalDateTime dataEnvio) {
		super();
		this.id = id;
		this.remetenteId = remetenteId;
		this.remetenteTipo = remetenteTipo;
		this.destinatarioId = destinatarioId;
		this.destinatarioTipo = destinatarioTipo;
		this.conteudo = conteudo;
		this.dataEnvio = dataEnvio;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getRemetenteId() {
		return remetenteId;
	}

	public void setRemetenteId(Long remetenteId) {
		this.remetenteId = remetenteId;
	}

	public TipoUsuario getRemetenteTipo() {
		return remetenteTipo;
	}

	public void setRemetenteTipo(TipoUsuario remetenteTipo) {
		this.remetenteTipo = remetenteTipo;
	}

	public Long getDestinatarioId() {
		return destinatarioId;
	}

	public void setDestinatarioId(Long destinatarioId) {
		this.destinatarioId = destinatarioId;
	}

	public TipoUsuario getDestinatarioTipo() {
		return destinatarioTipo;
	}

	public void setDestinatarioTipo(TipoUsuario destinatarioTipo) {
		this.destinatarioTipo = destinatarioTipo;
	}

	public String getConteudo() {
		return conteudo;
	}

	public void setConteudo(String conteudo) {
		this.conteudo = conteudo;
	}

	public LocalDateTime getDataEnvio() {
		return dataEnvio;
	}

	public void setDataEnvio(LocalDateTime dataEnvio) {
		this.dataEnvio = dataEnvio;
	}

	
	
}