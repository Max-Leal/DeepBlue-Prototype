package models;

import Enums.Situacao;

public class Local {

	
	private Long id;
	private String nome;
	private String localidade;
	private String descricao;
	private String tipo_embarcacao;
	private int ano_afundamento;
	private double profundidade;
	private Situacao situacao;
	private String longitude;
	private String latitude;
	
	public Local() {
		
	}

	public Local(Long id, String nome, String localidade, String descricao, String tipo_embarcacao, int ano_afundamento,
			double profundidade, Situacao situacao, String longitude, String latitude) {
		super();
		this.id = id;
		this.nome = nome;
		this.localidade = localidade;
		this.descricao = descricao;
		this.tipo_embarcacao = tipo_embarcacao;
		this.ano_afundamento = ano_afundamento;
		this.profundidade = profundidade;
		this.situacao = situacao;
		this.longitude = longitude;
		this.latitude = latitude;
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

	public String getLocalidade() {
		return localidade;
	}

	public void setLocalidade(String localidade) {
		this.localidade = localidade;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public String getTipo_embarcacao() {
		return tipo_embarcacao;
	}

	public void setTipo_embarcacao(String tipo_embarcacao) {
		this.tipo_embarcacao = tipo_embarcacao;
	}

	public int getAno_afundamento() {
		return ano_afundamento;
	}

	public void setAno_afundamento(int ano_afundamento) {
		this.ano_afundamento = ano_afundamento;
	}

	public double getProfundidade() {
		return profundidade;
	}

	public void setProfundidade(double profundidade) {
		this.profundidade = profundidade;
	}

	public Situacao getSituacao() {
		return situacao;
	}

	public void setSituacao(Situacao situacao) {
		this.situacao = situacao;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
}

	
	