package br.edu.curso.fateczl.AV2_Spring_Campeonato.persistence;

import java.sql.SQLException;
import java.util.List;

import br.edu.curso.fateczl.AV2_Spring_Campeonato.model.Grupos_Resultados;

public interface IGrupos_resultadoDAO {

       public List<Grupos_Resultados> verResultadosGrupos(String grupo) throws SQLException, ClassNotFoundException;
}
