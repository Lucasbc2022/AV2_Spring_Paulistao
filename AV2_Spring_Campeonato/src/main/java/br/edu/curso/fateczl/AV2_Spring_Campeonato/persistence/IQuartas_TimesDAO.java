package br.edu.curso.fateczl.AV2_Spring_Campeonato.persistence;

import java.sql.SQLException;
import java.util.List;

import br.edu.curso.fateczl.AV2_Spring_Campeonato.model.Quartas_Times;

public interface IQuartas_TimesDAO {

	public List<Quartas_Times> verTimes_Quartas() throws SQLException, ClassNotFoundException;
}
