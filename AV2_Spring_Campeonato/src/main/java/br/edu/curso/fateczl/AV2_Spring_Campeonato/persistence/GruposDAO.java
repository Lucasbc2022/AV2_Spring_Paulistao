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

import br.edu.curso.fateczl.AV2_Spring_Campeonato.model.Grupos;

@Repository
public class GruposDAO implements IGruposDAO<Grupos>{

	@Autowired
	private GenericDAO gDao;
	
	public GruposDAO(GenericDAO gDao) {
		this.gDao = gDao;
	}
	
	
	@Override
	public List<Grupos> sorteio() throws SQLException, ClassNotFoundException {
		List<Grupos> grupos = new ArrayList<>();
		Connection c = gDao.getConnection();
		
		String proc_sql = "{CALL p_sorteio}";
		
		String sql = " SELECT t.NomeTime, g.Grupo\r\n" + 
				     " FROM Grupos g, Times t\r\n" + 
				     " WHERE t.CodigoTime = g.CodigoTime";
		
		
		try {
		CallableStatement cs = c.prepareCall(proc_sql);
		cs.execute();
		
		
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()) {
			Grupos grupo = new Grupos();
			grupo.setNometime(rs.getString("NomeTime"));
			grupo.setGrupo(rs.getString("Grupo"));
			grupos.add(grupo);
		}
		
		rs.close();
		ps.close();
		cs.close();
		
		
		} catch(Exception e) {
			PreparedStatement ps = c.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
				Grupos grupo = new Grupos();
				grupo.setNometime(rs.getString("NomeTime"));
				grupo.setGrupo(rs.getString("Grupo"));
				grupos.add(grupo);
			}
			
			rs.close();
			ps.close();
			
		}
		c.close();
		
		
		return grupos;
	}

	@Override
	public List<Grupos> vergrupo(String tipo_grupo) throws SQLException, ClassNotFoundException {
		List<Grupos> grupos = new ArrayList<>();
		Connection c = gDao.getConnection();
		
		String sql = " SELECT t.NomeTime, g.Grupo\r\n" + 
                " FROM Grupos g, Times t\r\n" + 
                " WHERE t.CodigoTime = g.CodigoTime" +
                " AND Grupo = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, tipo_grupo);
		ResultSet rs = ps.executeQuery();

		
		while (rs.next()) {
			Grupos grupo = new Grupos();
			grupo.setNometime(rs.getString("NomeTime"));
			grupo.setGrupo(rs.getString("Grupo"));
			grupos.add(grupo);
		}
		
		rs.close();
		ps.close();
		c.close();
		
		return grupos;
	}


}
