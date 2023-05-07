package br.edu.curso.fateczl.AV2_Spring_Campeonato.persistence;

import java.sql.SQLException;
import java.util.List;

import br.edu.curso.fateczl.AV2_Spring_Campeonato.model.Campeonato_pos_jogos;

public interface ICampeonato_pos_jogosDAO {
	
	public List<Campeonato_pos_jogos> verCampeonato() throws SQLException, ClassNotFoundException;

}
