package models;

public class AvaliacaoFotoLocal {
    private Long id;
    private Long idAvaliacao;
    private String urlFoto;

    public AvaliacaoFotoLocal() {}

    public AvaliacaoFotoLocal(Long idAvaliacao, String urlFoto) {
        this.idAvaliacao = idAvaliacao;
        this.urlFoto = urlFoto;
    }

    public AvaliacaoFotoLocal(Long id, Long idAvaliacao, String urlFoto) {
        this.id = id;
        this.idAvaliacao = idAvaliacao;
        this.urlFoto = urlFoto;
    }

    // Getters e Setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIdAvaliacao() {
        return idAvaliacao;
    }

    public void setIdAvaliacao(Long idAvaliacao) {
        this.idAvaliacao = idAvaliacao;
    }

    public String getUrlFoto() {
        return urlFoto;
    }

    public void setUrlFoto(String urlFoto) {
        this.urlFoto = urlFoto;
    }
}
