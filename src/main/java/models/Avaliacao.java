package models;

public class Avaliacao {

	private Long id;
	private int nota;
	private String sugestao;
	private Long idUsuarioResponsavel;
	private Long idAgenciaAvaliada;
	
	public Avaliacao() {
		
	}

	public Avaliacao(int nota, String sugestao, Long idUsuarioResponsavel, Long idAgenciaAvaliada) {
		super();
		this.nota = nota;
		this.sugestao = sugestao;
		this.idUsuarioResponsavel = idUsuarioResponsavel;
		this.idAgenciaAvaliada = idAgenciaAvaliada;
	}

	public Avaliacao(Long id, int nota, String sugestao, Long idUsuarioResponsavel, Long idAgenciaAvaliada) {
		super();
		this.id = id;
		this.nota = nota;
		this.sugestao = sugestao;
		this.idUsuarioResponsavel = idUsuarioResponsavel;
		this.idAgenciaAvaliada = idAgenciaAvaliada;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public int getNota() {
		return nota;
	}

	public void setNota(int nota) {
		this.nota = nota;
	}

	public String getSugestao() {
		return sugestao;
	}

	public void setSugestao(String sugestao) {
		this.sugestao = sugestao;
	}

	public Long getIdUsuarioResponsavel() {
		return idUsuarioResponsavel;
	}

	public void setIdUsuarioResponsavel(Long idUsuarioResponsavel) {
		this.idUsuarioResponsavel = idUsuarioResponsavel;
	}

	public Long getIdAgenciaAvaliada() {
		return idAgenciaAvaliada;
	}

	public void setIdAgenciaAvaliada(Long idAgenciaAvaliada) {
		this.idAgenciaAvaliada = idAgenciaAvaliada;
	}
	
	
}
