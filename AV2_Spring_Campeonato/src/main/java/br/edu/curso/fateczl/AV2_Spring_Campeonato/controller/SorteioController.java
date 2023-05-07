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
public class SorteioController {
    
	@Autowired
	GruposDAO gDao;
	
	@RequestMapping(name = "sorteio", value = "/sorteio", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("sorteio");
	}
	
	@RequestMapping(name = "sorteio", value = "/sorteio", method = RequestMethod.POST)
	public ModelAndView sorteio(ModelMap model, @RequestParam Map<String, String> allParam) {
		String botao = allParam.get("botao");
		List<Grupos> grupos = new ArrayList<>();
		String erro = "";
		String saida = "";
		
		try {
			if(botao.equalsIgnoreCase("sortear")) {
				grupos = gDao.sorteio();
			}
		} catch(SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("grupos", grupos);
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
		}
		
		
		return new ModelAndView("sorteio");
	}
}
