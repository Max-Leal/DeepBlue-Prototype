package models;

import java.time.LocalDateTime;

public class Mensagem {
    private Long id;
    private Long idUsuario;
    private Long idAgencia;
    private String conteudo;
    private LocalDateTime dataEnvio;
    private String remetente; // "usuario" ou "agencia"

    public Mensagem() {}

    public Mensagem(Long idUsuario, Long idAgencia, String conteudo, String remetente) {
        this.idUsuario = idUsuario;
        this.idAgencia = idAgencia;
        this.conteudo = conteudo;
        this.remetente = remetente;
        this.dataEnvio = LocalDateTime.now();
    }

    public Mensagem(Long id, Long idUsuario, Long idAgencia, String conteudo, LocalDateTime dataEnvio, String remetente) {
        this.id = id;
        this.idUsuario = idUsuario;
        this.idAgencia = idAgencia;
        this.conteudo = conteudo;
        this.dataEnvio = dataEnvio;
        this.remetente = remetente;
    }

    // Getters e Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Long idUsuario) {
        this.idUsuario = idUsuario;
    }

    public Long getIdAgencia() {
        return idAgencia;
    }

    public void setIdAgencia(Long idAgencia) {
        this.idAgencia = idAgencia;
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

    public String getRemetente() {
        return remetente;
    }

    public void setRemetente(String remetente) {
        this.remetente = remetente;
    }
}
