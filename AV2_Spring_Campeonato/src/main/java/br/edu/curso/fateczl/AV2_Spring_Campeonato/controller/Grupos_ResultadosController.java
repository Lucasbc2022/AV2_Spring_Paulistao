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

import br.edu.curso.fateczl.AV2_Spring_Campeonato.model.Grupos_Resultados;
import br.edu.curso.fateczl.AV2_Spring_Campeonato.persistence.Grupos_ResultadosDAO;

@Controller
public class Grupos_ResultadosController {
	
	@Autowired
	Grupos_ResultadosDAO grDAO;

	@RequestMapping(name = "grupos_resultados", value = "/grupos_resultados", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
	    return new ModelAndView("grupos_resultados");	
	}
	
	@RequestMapping(name = "grupos_resultados", value = "/grupos_resultados", method = RequestMethod.POST)
	public ModelAndView grupos_resultados(ModelMap model, @RequestParam Map<String, String> allParam) {
	String botao = allParam.get("botao");
	List<Grupos_Resultados> verGrupoA = new ArrayList<>();
	List<Grupos_Resultados> verGrupoB = new ArrayList<>();
	List<Grupos_Resultados> verGrupoC = new ArrayList<>();
	List<Grupos_Resultados> verGrupoD = new ArrayList<>();
	
	String erro = "";
	String saida = "";
	
	try {
		if(botao.equalsIgnoreCase("exibir")) {
			verGrupoA = grDAO.verResultadosGrupos("A");
			verGrupoB = grDAO.verResultadosGrupos("B");
			verGrupoC = grDAO.verResultadosGrupos("C");
			verGrupoD = grDAO.verResultadosGrupos("D");
		}
	} catch (SQLException | ClassNotFoundException e) {
		erro = e.getMessage();
	} finally {
		model.addAttribute("verGrupoA", verGrupoA);
		model.addAttribute("verGrupoB", verGrupoB);
		model.addAttribute("verGrupoC", verGrupoC);
		model.addAttribute("verGrupoD", verGrupoD);
		model.addAttribute("saida", saida);
		model.addAttribute("erro", erro);
	}
	return new ModelAndView("grupos_resultados");
	
	}
}

