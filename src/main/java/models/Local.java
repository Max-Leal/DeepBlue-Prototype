package models;

import Enums.Situacao;

public class Local {

	
	private Long id;
	private String localidade;
	private Situacao situacao;
	private String nome;
	private String descricao;
	private String longitude;
	private String latitude;
	
	public Local() {
		
	}

	public Local(String localidade, Situacao situacao, String nome, String descricao, String longitude,
			String latitude) {
		super();
		this.localidade = localidade;
		this.situacao = situacao;
		this.nome = nome;
		this.descricao = descricao;
		this.longitude = longitude;
		this.latitude = latitude;
	}

	public Local(Long id, String localidade, Situacao situacao, String nome, String descricao, String longitude,
			String latitude) {
		super();
		this.id = id;
		this.localidade = localidade;
		this.situacao = situacao;
		this.nome = nome;
		this.descricao = descricao;
		this.longitude = longitude;
		this.latitude = latitude;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getLocalidade() {
		return localidade;
	}

	public void setLocalidade(String localidade) {
		this.localidade = localidade;
	}

	public Situacao getSituacao() {
		return situacao;
	}

	public void setSituacao(Situacao situacao) {
		this.situacao = situacao;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
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
