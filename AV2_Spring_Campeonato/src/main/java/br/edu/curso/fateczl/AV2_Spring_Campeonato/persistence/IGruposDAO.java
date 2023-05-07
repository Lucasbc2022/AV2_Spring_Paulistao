package br.edu.curso.fateczl.AV2_Spring_Campeonato.persistence;

import java.sql.SQLException;
import java.util.List;

public interface IGruposDAO<Grupos> {
	
	public List<Grupos> sorteio() throws SQLException, ClassNotFoundException;
	public List<Grupos> vergrupo(String tipo_grupo) throws SQLException, ClassNotFoundException;

}
