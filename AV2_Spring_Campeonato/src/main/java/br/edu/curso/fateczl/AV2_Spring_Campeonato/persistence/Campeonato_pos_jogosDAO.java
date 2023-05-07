package br.edu.curso.fateczl.AV2_Spring_Campeonato.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import br.edu.curso.fateczl.AV2_Spring_Campeonato.model.Campeonato_pos_jogos;

@Repository
public class Campeonato_pos_jogosDAO implements ICampeonato_pos_jogosDAO{

	private GenericDAO gDao;
	
	public Campeonato_pos_jogosDAO(GenericDAO gDao) {
		this.gDao = gDao;
	}
	@Override
	public List<Campeonato_pos_jogos> verCampeonato() throws SQLException, ClassNotFoundException {
		List<Campeonato_pos_jogos> campeonato_resultados = new ArrayList<>();
		Connection c = gDao.getConnection();
	    String sql_proc = "{CALL p_achar_rebaixados}";
		
		String sql = "SELECT nome_time, "
				          + "num_jogos_disputados, "
				          + "vitorias, "
				          + "empates, "
				          + "derrotas, "
				          + "gols_marcados, "
				          + "gols_sofridos, "
				          + "saldo_gols, "
				          + "pontos, "
				          + "classificacao "
				          + "FROM dbo.CAMPEONATO() ORDER BY pontos DESC, vitorias DESC, gols_marcados DESC, saldo_gols DESC";
		CallableStatement cs = c.prepareCall(sql_proc);
		cs.execute();
		
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			Campeonato_pos_jogos campeonato_resul = new Campeonato_pos_jogos();
			campeonato_resul.setNome_time(rs.getString("nome_time"));
			campeonato_resul.setNum_jogos_disputados(rs.getInt("num_jogos_disputados"));
			campeonato_resul.setVitorias(rs.getInt("vitorias"));
			campeonato_resul.setEmpates(rs.getInt("empates"));
			campeonato_resul.setDerrotas(rs.getInt("derrotas"));
			campeonato_resul.setGols_marcados(rs.getInt("gols_marcados"));
			campeonato_resul.setGols_sofridos(rs.getInt("gols_sofridos"));
			campeonato_resul.setSaldo_gols(rs.getInt("pontos"));
			campeonato_resul.setPontos(rs.getInt("pontos"));
			campeonato_resul.setClassificacao(rs.getString("classificacao"));
			campeonato_resultados.add(campeonato_resul);
			
		
		}
		
	    cs.close();
	    ps.close();
	    rs.close();
	    c.close();
		
		return campeonato_resultados;
	}

}
