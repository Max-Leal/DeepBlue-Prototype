package models;

public class RankingAgencia {
	private long idAgencia;
	private String nomeAgencia;
	private double mediaEscala;
	
	public RankingAgencia() {
	}

	public long getIdAgencia() {
		return idAgencia;
	}

	public void setIdAgencia(long idAgencia) {
		this.idAgencia = idAgencia;
	}

	public String getNomeAgencia() {
		return nomeAgencia;
	}

	public void setNomeAgencia(String nomeAgencia) {
		this.nomeAgencia = nomeAgencia;
	}

	public double getMediaEscala() {
		return mediaEscala;
	}

	public void setMediaEscala(double mediaEscala) {
		this.mediaEscala = mediaEscala;
	}
				
}
