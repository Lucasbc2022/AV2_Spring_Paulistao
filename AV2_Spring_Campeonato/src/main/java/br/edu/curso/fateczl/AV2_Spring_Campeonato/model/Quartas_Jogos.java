package br.edu.curso.fateczl.AV2_Spring_Campeonato.model;

public class Quartas_Jogos {
	
	private String nome_timeA;
	private String nome_timeB;
	
	public String getNome_timeA() {
		return nome_timeA;
	}
	public void setNome_timeA(String nome_timeA) {
		this.nome_timeA = nome_timeA;
	}
	public String getNome_timeB() {
		return nome_timeB;
	}
	public void setNome_timeB(String nome_timeB) {
		this.nome_timeB = nome_timeB;
	}
	@Override
	public String toString() {
		return "Quartas_Jogos [nome_timeA=" + nome_timeA + ", nome_timeB=" + nome_timeB + "]";
	}
	

}
