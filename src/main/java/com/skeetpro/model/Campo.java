package com.skeetpro.model;

import java.io.Serializable;

public class Campo implements Serializable {
    private static final long serialVersionUID = 1L;
    private int id;
    private String disciplina;

    public Campo() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getDisciplina() { return disciplina; }
    public void setDisciplina(String disciplina) { this.disciplina = disciplina; }
}
