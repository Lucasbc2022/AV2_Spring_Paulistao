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

import br.edu.curso.fateczl.AV2_Spring_Campeonato.model.Quartas_Times;

@Repository
public class Quartas_TimesDAO implements IQuartas_TimesDAO{

	@Autowired
	private GenericDAO gDAO;
	
	public Quartas_TimesDAO(GenericDAO gDAO) {
		this.gDAO = gDAO;
	}
	
	
	@Override
	public List<Quartas_Times> verTimes_Quartas() throws SQLException, ClassNotFoundException {
		List<Quartas_Times> times_quartas = new ArrayList<>();
		Connection c = gDAO.getConnection();
		
		String sql_proc = "{CALL p_achar_rebaixados}";
		
        String sql = "SELECT nome_times_quartas FROM dbo.fn_nomes_times_quartas()";	
        
        CallableStatement cs = c.prepareCall(sql_proc);
        cs.execute();
        
        PreparedStatement ps = c.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while(rs.next()) {
        	Quartas_Times time = new Quartas_Times();
        	time.setNome_time_quartas(rs.getString("nome_times_quartas"));
        	times_quartas.add(time);
        }
        ps.close();
        rs.close();
        cs.close();
        c.close();
		
		return times_quartas;
	}

}
