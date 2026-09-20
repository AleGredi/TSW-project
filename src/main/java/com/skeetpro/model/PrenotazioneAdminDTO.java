package com.skeetpro.model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Time;

public class PrenotazioneAdminDTO implements Serializable {
    private static final long serialVersionUID = 1L;
    private int codice;
    private Date data;
    private Time fasciaOraria;
    
    private int campoId;
    private String disciplina;
    
    private String clienteCF;
    private String clienteNome;
    private String clienteCognome;

    public int getCodice() { return codice; }
    public void setCodice(int codice) { this.codice = codice; }

    public Date getData() { return data; }
    public void setData(Date data) { this.data = data; }

    public Time getFasciaOraria() { return fasciaOraria; }
    public void setFasciaOraria(Time fasciaOraria) { this.fasciaOraria = fasciaOraria; }

    public int getCampoId() { return campoId; }
    public void setCampoId(int campoId) { this.campoId = campoId; }

    public String getDisciplina() { return disciplina; }
    public void setDisciplina(String disciplina) { this.disciplina = disciplina; }

    public String getClienteCF() { return clienteCF; }
    public void setClienteCF(String clienteCF) { this.clienteCF = clienteCF; }

    public String getClienteNome() { return clienteNome; }
    public void setClienteNome(String clienteNome) { this.clienteNome = clienteNome; }

    public String getClienteCognome() { return clienteCognome; }
    public void setClienteCognome(String clienteCognome) { this.clienteCognome = clienteCognome; }
}
