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

import br.edu.curso.fateczl.AV2_Spring_Campeonato.model.Grupos_Resultados;

@Repository
public class Grupos_ResultadosDAO implements IGrupos_resultadoDAO{
	
	@Autowired 
	private GenericDAO gDao;
	
    public Grupos_ResultadosDAO(GenericDAO gDao) {
		this.gDao = gDao;
	}
	
	@Override
	public List<Grupos_Resultados> verResultadosGrupos(String grupo) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
	    List<Grupos_Resultados> grupos_com_resultados = new ArrayList<>();
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
	    		          + "estado "
	    		          + "FROM dbo.GRUPO(?) ORDER BY pontos DESC, vitorias DESC, gols_marcados DESC, saldo_gols DESC";
	    
		CallableStatement cs = c.prepareCall(sql_proc);
		cs.execute();
	    
	    PreparedStatement ps = c.prepareStatement(sql);
	    ps.setString(1, grupo);
	    ResultSet rs = ps.executeQuery();
	    while(rs.next()) {
	    	Grupos_Resultados grupo_resultado = new Grupos_Resultados();
	    	grupo_resultado.setNome_time(rs.getString("nome_time"));
	    	grupo_resultado.setNum_jogos_disputados(rs.getInt("num_jogos_disputados"));
	    	grupo_resultado.setVitorias(rs.getInt("vitorias"));
	    	grupo_resultado.setEmpates(rs.getInt("empates"));
	    	grupo_resultado.setDerrotas(rs.getInt("derrotas"));
	    	grupo_resultado.setGols_marcados(rs.getInt("gols_marcados"));
	    	grupo_resultado.setGols_sofridos(rs.getInt("gols_sofridos"));
	    	grupo_resultado.setSaldo_gols(rs.getInt("saldo_gols"));
	    	grupo_resultado.setPontos(rs.getInt("pontos"));
	    	grupo_resultado.setEstado(rs.getString("estado"));
	    	grupos_com_resultados.add(grupo_resultado);
	    	

	    		
	    }
	    
	    cs.close();
	    ps.close();
	    rs.close();
	    c.close();
		return grupos_com_resultados;
	}


}
