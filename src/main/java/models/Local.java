package models;

import Enums.Situacao;

public class Local {

    private Long id;
    private String nome;
    private String localidade;
    private String descricao;
    private String tipoEmbarcacao;
    private int anoAfundamento;
    private double profundidade;
    private Situacao situacao;
    private String latitude;
    private String longitude;

    public Local() {}

    public Local(String nome, String localidade, String descricao, String tipoEmbarcacao,
                 int anoAfundamento, double profundidade, Situacao situacao, String latitude, String longitude) {
        this.nome = nome;
        this.localidade = localidade;
        this.descricao = descricao;
        this.tipoEmbarcacao = tipoEmbarcacao;
        this.anoAfundamento = anoAfundamento;
        this.profundidade = profundidade;
        this.situacao = situacao;
        this.latitude = latitude;
        this.longitude = longitude;
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

    public String getTipoEmbarcacao() {
        return tipoEmbarcacao;
    }

    public void setTipoEmbarcacao(String tipoEmbarcacao) {
        this.tipoEmbarcacao = tipoEmbarcacao;
    }

    public int getAnoAfundamento() {
        return anoAfundamento;
    }

    public void setAnoAfundamento(int anoAfundamento) {
        this.anoAfundamento = anoAfundamento;
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

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }
}
