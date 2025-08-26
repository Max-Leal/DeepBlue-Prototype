package models;

import java.time.LocalDateTime;

public class AvaliacaoAgencia {

    private Long id;
    private int escala;
    private String sugestao;
    private Long usuarioId;
    private Long agenciaId;
    private LocalDateTime dataAvaliacao;
    private String nomeUsuario;
    private String nomeAgencia;

    public AvaliacaoAgencia() {
    }

    public AvaliacaoAgencia(int escala, String sugestao, Long usuarioId, Long agenciaId) {
        this.escala = escala;
        this.sugestao = sugestao;
        this.usuarioId = usuarioId;
        this.agenciaId = agenciaId;
    }

    public AvaliacaoAgencia(Long id, int escala, String sugestao, Long usuarioId, Long agenciaId, LocalDateTime dataAvaliacao) {
        this.id = id;
        this.escala = escala;
        this.sugestao = sugestao;
        this.usuarioId = usuarioId;
        this.agenciaId = agenciaId;
        this.dataAvaliacao = dataAvaliacao;
    }

    
	// Getters e Setters
    public String getNomeUsuario() {
		return nomeUsuario;
	}

	public void setNomeUsuario(String nomeUsuario) {
		this.nomeUsuario = nomeUsuario;
	}

	public String getNomeAgencia() {
		return nomeAgencia;
	}

	public void setNomeAgencia(String nomeAgencia) {
		this.nomeAgencia = nomeAgencia;
	}

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public int getEscala() {
        return escala;
    }

    public void setEscala(int escala) {
        this.escala = escala;
    }

    public String getSugestao() {
        return sugestao;
    }

    public void setSugestao(String sugestao) {
        this.sugestao = sugestao;
    }

    public Long getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(Long usuarioId) {
        this.usuarioId = usuarioId;
    }

    public Long getAgenciaId() {
        return agenciaId;
    }

    public void setAgenciaId(Long agenciaId) {
        this.agenciaId = agenciaId;
    }

    public LocalDateTime getDataAvaliacao() {
        return dataAvaliacao;
    }

    public void setDataAvaliacao(LocalDateTime dataAvaliacao) {
        this.dataAvaliacao = dataAvaliacao;
    }
}
