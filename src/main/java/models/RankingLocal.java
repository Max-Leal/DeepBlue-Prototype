package models;

public class RankingLocal {
	private long idLocal;
	private String nomeLocal;
	private double mediaEscala;

	// Construtor, Getters e Setters
	public RankingLocal() {
	}

	public long getIdLocal() {
		return idLocal;
	}

	public void setIdLocal(long idLocal) {
		this.idLocal = idLocal;
	}

	public String getNomeLocal() {
		return nomeLocal;
	}

	public void setNomeLocal(String nomeLocal) {
		this.nomeLocal = nomeLocal;
	}

	public double getMediaEscala() {
		return mediaEscala;
	}

	public void setMediaEscala(double mediaEscala) {
		this.mediaEscala = mediaEscala;
	}
}