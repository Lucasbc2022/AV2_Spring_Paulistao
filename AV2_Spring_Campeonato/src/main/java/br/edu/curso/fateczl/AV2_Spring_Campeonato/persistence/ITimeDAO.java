package br.edu.curso.fateczl.AV2_Spring_Campeonato.persistence;

import java.sql.SQLException;
import java.util.List;

public interface ITimeDAO<Times> {

	public List<Times> listar() throws SQLException, ClassNotFoundException;
}
