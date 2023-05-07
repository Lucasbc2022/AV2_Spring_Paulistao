package br.edu.curso.fateczl.AV2_Spring_Campeonato.persistence;

import java.sql.SQLException;
import java.util.List;

import br.edu.curso.fateczl.AV2_Spring_Campeonato.model.Quartas_Jogos;

public interface IQuartas_JogosDAO {
	
	public List<Quartas_Jogos> verJogos_Quartas() throws SQLException, ClassNotFoundException;

}
