package br.edu.curso.fateczl.AV2_Spring_Campeonato.persistence;

import java.sql.SQLException;
import java.util.List;

public interface IJogosDAO<Jogos> {
	public List<Jogos> listarJogos() throws SQLException, ClassNotFoundException;
	public List<Jogos> buscarJogos(String data_string) throws SQLException, ClassNotFoundException;

}
