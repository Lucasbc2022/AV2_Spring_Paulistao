package br.edu.curso.fateczl.AV2_Spring_Campeonato.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import br.edu.curso.fateczl.AV2_Spring_Campeonato.model.Quartas_Jogos;

@Repository
public class Quartas_JogosDAO implements IQuartas_JogosDAO{

	@Autowired
	private GenericDAO gDAO;
	
	public Quartas_JogosDAO(GenericDAO gDAO) {
		this.gDAO= gDAO;
	}

	@Override
	public List<Quartas_Jogos> verJogos_Quartas() throws SQLException, ClassNotFoundException {
		Connection c = gDAO.getConnection();
		List<Quartas_Jogos> jogos_finais = new ArrayList<>();
		
		String sql_proc = "{CALL p_achar_rebaixados}";
		
		String sql = "SELECT NomeTimeA, NomeTimeB FROM fn_Quarta_de_final()";
		
		CallableStatement cs = c.prepareCall(sql_proc);
		cs.execute();
		
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			Quartas_Jogos jogo_final = new Quartas_Jogos();
			jogo_final.setNome_timeA(rs.getString("NomeTimeA"));
			jogo_final.setNome_timeB(rs.getString("NomeTimeB"));
			jogos_finais.add(jogo_final);
		}
		
		rs.close();
		ps.close();
		cs.close();
		c.close();
		
		return jogos_finais;
	}
}
