package br.edu.curso.fateczl.AV2_Spring_Campeonato.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.springframework.stereotype.Repository;

@Repository
public class AlterarDAO implements IAlterarDAO {

	private GenericDAO gDAO;
	
	public AlterarDAO(GenericDAO gDAO) {
		this.gDAO = gDAO;
	}
	@Override
	public String alterarGols(String nome_timeA, String nome_timeB, int gols_timeA, int gols_timeB, String data_jogo)
			throws SQLException, ClassNotFoundException {
		Connection c = gDAO.getConnection();
		String sql_proc = "{CALL p_alterar_gols(?,?,?,?,?)}";
		
		
		CallableStatement cs = c.prepareCall(sql_proc);
		cs.setString(1, nome_timeA);
		cs.setString(2, nome_timeB);
		cs.setInt(3, gols_timeA);
		cs.setInt(4, gols_timeB);
		cs.setString(5, data_jogo);
		System.out.println(nome_timeA +" "+ nome_timeB +" "+ gols_timeA +" "+ gols_timeB +" "+ data_jogo );
		cs.execute();
		
		cs.close();
		c.close();
		
		
		return "Jogo atualizado";
	}

}
