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

import br.edu.curso.fateczl.AV2_Spring_Campeonato.model.Campeonato_pos_jogos;
import br.edu.curso.fateczl.AV2_Spring_Campeonato.persistence.Campeonato_pos_jogosDAO;

@Controller
public class CampeonatoController {
	
	@Autowired
	Campeonato_pos_jogosDAO cpjDAO;
	
	@RequestMapping(name = "campeonato", value = "/campeonato", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		List<Campeonato_pos_jogos> camp_resul = new ArrayList<>();
		String saida = "";
		String erro = "";
		try {
			camp_resul = cpjDAO.verCampeonato();
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("camp_resul", camp_resul);
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			
		}
		return new ModelAndView("campeonato");
	}
	
	@RequestMapping(name = "campeonato", value = "/campeonato", method = RequestMethod.POST)
	public ModelAndView campeonato(ModelMap model, @RequestParam Map<String, String> allParam) {
		return new ModelAndView("campeonato");
	}
	

}
