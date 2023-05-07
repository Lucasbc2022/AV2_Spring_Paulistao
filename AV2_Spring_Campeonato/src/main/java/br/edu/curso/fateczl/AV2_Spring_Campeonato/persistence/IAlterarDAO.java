package br.edu.curso.fateczl.AV2_Spring_Campeonato.persistence;

import java.sql.SQLException;

public interface IAlterarDAO {
    public String alterarGols(String nome_timeA, String nome_timeB, int gols_timeA, int gols_timeB, String data_jogo)throws SQLException, ClassNotFoundException;

}
