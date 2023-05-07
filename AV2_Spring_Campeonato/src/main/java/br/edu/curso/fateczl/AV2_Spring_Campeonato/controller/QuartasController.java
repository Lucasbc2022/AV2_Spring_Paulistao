package br.edu.curso.fateczl.AV2_Spring_Campeonato.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.edu.curso.fateczl.AV2_Spring_Campeonato.model.Quartas_Jogos;
import br.edu.curso.fateczl.AV2_Spring_Campeonato.model.Quartas_Times;
import br.edu.curso.fateczl.AV2_Spring_Campeonato.persistence.Quartas_JogosDAO;
import br.edu.curso.fateczl.AV2_Spring_Campeonato.persistence.Quartas_TimesDAO;

@Controller
public class QuartasController {
	
	@Autowired
	Quartas_TimesDAO qtDAO;
	
	@Autowired
	Quartas_JogosDAO qjDAO;

	@RequestMapping(name = "quartas", value = "/quartas", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		List<Quartas_Times> times_classificados = new ArrayList<>();
		List<Quartas_Jogos> jogos_finais = new ArrayList<>();
	    String saida = "";
	    String erro = "";
	    
	    try {
	    	times_classificados = qtDAO.verTimes_Quartas();
	    	jogos_finais = qjDAO.verJogos_Quartas();
	    	
	    } catch(SQLException | ClassNotFoundException e) {
	    	erro = e.getMessage();
	    } finally {
	    	model.addAttribute("times_classificados", times_classificados);
	    	model.addAttribute("jogos_finais", jogos_finais);
	    	model.addAttribute("erro", erro);
	    	model.addAttribute("saida", saida);
	    }
		return new ModelAndView("quartas");
	}
	
	@RequestMapping(name = "quartas", value = "/quartas", method = RequestMethod.POST)
	public ModelAndView quartas(ModelMap model, @RequestParam Map<String, String> allParam) {
		return new ModelAndView("quartas");
	}
}
