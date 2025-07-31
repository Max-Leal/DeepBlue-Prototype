package models;

public class AgenciaLocal {
    private int idAgencia;
    private int idLocal;
    private String tipoAtividade;

    public AgenciaLocal() {}

    public AgenciaLocal(int idAgencia, int idLocal, String tipoAtividade) {
        this.idAgencia = idAgencia;
        this.idLocal = idLocal;
        this.tipoAtividade = tipoAtividade;
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

    public String getTipoAtividade() {
        return tipoAtividade;
    }

    public void setTipoAtividade(String tipoAtividade) {
        this.tipoAtividade = tipoAtividade;
    }
}
