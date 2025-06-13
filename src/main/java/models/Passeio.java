package models;

import java.time.LocalDate;

import Enums.Situacao;
import Enums.TipoPasseio;

public class Passeio {
    private int id;
    private String local;
    private LocalDate data;
    private String duracao;
    private Double valor;
    private int agenciaId;
    private TipoPasseio tipo;
    private Situacao situacao;

    
    public Passeio() {}


	public Passeio(String local, LocalDate data, String duracao, Double valor, int agenciaId, TipoPasseio tipo,
			Situacao situacao) {
		super();
		this.local = local;
		this.data = data;
		this.duracao = duracao;
		this.valor = valor;
		this.agenciaId = agenciaId;
		this.tipo = tipo;
		this.situacao = situacao;
	}


	public Passeio(int id, String local, LocalDate data, String duracao, Double valor, int agenciaId, TipoPasseio tipo,
			Situacao situacao) {
		super();
		this.id = id;
		this.local = local;
		this.data = data;
		this.duracao = duracao;
		this.valor = valor;
		this.agenciaId = agenciaId;
		this.tipo = tipo;
		this.situacao = situacao;
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getLocal() {
		return local;
	}


	public void setLocal(String local) {
		this.local = local;
	}


	public LocalDate getData() {
		return data;
	}


	public void setData(LocalDate data) {
		this.data = data;
	}


	public String getDuracao() {
		return duracao;
	}


	public void setDuracao(String duracao) {
		this.duracao = duracao;
	}


	public Double getValor() {
		return valor;
	}


	public void setValor(Double valor) {
		this.valor = valor;
	}


	public int getAgenciaId() {
		return agenciaId;
	}


	public void setAgenciaId(int agenciaId) {
		this.agenciaId = agenciaId;
	}


	public TipoPasseio getTipo() {
		return tipo;
	}


	public void setTipo(TipoPasseio tipo) {
		this.tipo = tipo;
	}


	public Situacao getSituacao() {
		return situacao;
	}


	public void setSituacao(Situacao situacao) {
		this.situacao = situacao;
	}
   
}