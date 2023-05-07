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

import br.edu.curso.fateczl.AV2_Spring_Campeonato.model.Grupos;
import br.edu.curso.fateczl.AV2_Spring_Campeonato.persistence.GruposDAO;


@Controller
public class GruposController {
	
	@Autowired
	GruposDAO gDao;

	@RequestMapping(name = "grupos", value = "/grupos", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("grupos");
	}

	@RequestMapping(name = "grupos", value = "/grupos", method = RequestMethod.POST)
	public ModelAndView grupos(ModelMap model, @RequestParam Map<String, String> allParam) {
		
		String botao = allParam.get("botao");
		
		List<Grupos> gruposA = new ArrayList<>();
		List<Grupos> gruposB = new ArrayList<>();
		List<Grupos> gruposC = new ArrayList<>();
		List<Grupos> gruposD = new ArrayList<>();
		
		String erro = "";
		String saida = "";
		
		try {
			if (botao.equalsIgnoreCase("exibir")) {
				gruposA = gDao.vergrupo("A");
				gruposB = gDao.vergrupo("B");
				gruposC = gDao.vergrupo("C");
				gruposD = gDao.vergrupo("D");
			}
			
			
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		}finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);     
			model.addAttribute("gruposA", gruposA);
			model.addAttribute("gruposB", gruposB); 
			model.addAttribute("gruposC", gruposC);
			model.addAttribute("gruposD", gruposD);
		}
		return new ModelAndView("grupos");
	}
}
