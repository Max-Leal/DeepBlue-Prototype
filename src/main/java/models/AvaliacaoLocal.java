package models;

import java.time.LocalDateTime;

public class AvaliacaoLocal {
    private Long id;
    private Long idLocal;
    private Long idUsuario;
    private String texto;
    private int escala; 
    private LocalDateTime dataComentario;
    private String nomeLocal;

    public AvaliacaoLocal() {}

   
    public AvaliacaoLocal(Long idLocal, Long idUsuario, String texto, int escala, LocalDateTime dataComentario) {
		super();
		this.idLocal = idLocal;
		this.idUsuario = idUsuario;
		this.texto = texto;
		this.escala = escala;
		this.dataComentario = dataComentario;
	}


	public AvaliacaoLocal(Long id, Long idLocal, Long idUsuario, String texto, int escala) {
		super();
		this.id = id;
		this.idLocal = idLocal;
		this.idUsuario = idUsuario;
		this.texto = texto;
		this.escala = escala;
	}


	// Getters e Setters

		
    public Long getId() {
        return id;
    }

    public String getNomeLocal() {
		return nomeLocal;
	}


	public void setNomeLocal(String nomeLocal) {
		this.nomeLocal = nomeLocal;
	}

	public void setId(Long id) {
        this.id = id;
    }

    public Long getIdLocal() {
        return idLocal;
    }

    public void setIdLocal(Long idLocal) {
        this.idLocal = idLocal;
    }

    public Long getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Long idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }

    public int getEscala() {
        return escala;
    }

    public void setEscala(int escala) {
        this.escala = escala;
    }

    public LocalDateTime getDataComentario() {
        return dataComentario;
    }

    public void setDataComentario(LocalDateTime dataComentario) {
        this.dataComentario = dataComentario;
    }
}
