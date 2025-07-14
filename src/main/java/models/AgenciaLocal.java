package models;

public class AgenciaLocal {
    private int idAgencia;
    private int idLocal;
    private boolean ofereceMergulho;
    private boolean oferecePasseio;

    public AgenciaLocal() {}

    public AgenciaLocal(int idAgencia, int idLocal, boolean ofereceMergulho, boolean oferecePasseio) {
        this.idAgencia = idAgencia;
        this.idLocal = idLocal;
        this.ofereceMergulho = ofereceMergulho;
        this.oferecePasseio = oferecePasseio;
    }

    public int getIdAgencia() {
        return idAgencia;
    }

    public void setIdAgencia(int idAgencia) {
        this.idAgencia = idAgencia;
    }

    public int getIdLocal() {
        return idLocal;
    }

    public void setIdLocal(int idLocal) {
        this.idLocal = idLocal;
    }

    public boolean isOfereceMergulho() {
        return ofereceMergulho;
    }

    public void setOfereceMergulho(boolean ofereceMergulho) {
        this.ofereceMergulho = ofereceMergulho;
    }

    public boolean isOferecePasseio() {
        return oferecePasseio;
    }

    public void setOferecePasseio(boolean oferecePasseio) {
        this.oferecePasseio = oferecePasseio;
    }
}
