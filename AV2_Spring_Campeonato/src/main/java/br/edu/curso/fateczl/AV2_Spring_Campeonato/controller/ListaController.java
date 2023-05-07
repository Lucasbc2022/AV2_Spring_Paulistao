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

import br.edu.curso.fateczl.AV2_Spring_Campeonato.model.Jogos;
import br.edu.curso.fateczl.AV2_Spring_Campeonato.persistence.JogosDAO;

@Controller
public class ListaController {

	@Autowired
	JogosDAO jDao;
	
	@RequestMapping(name = "lista", value = "/lista", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("lista");
	}
	
	@RequestMapping(name = "lista", value = "/lista", method = RequestMethod.POST)
	public ModelAndView lista(ModelMap model, @RequestParam Map<String, String> allParam) {
		String botao = allParam.get("botao");
		List<Jogos> lista = new ArrayList<>();
		String erro = "";
		String saida = "";
		
		try {
			if(botao.equalsIgnoreCase("listar")) {
				lista = jDao.listarJogos();
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("lista", lista);
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
		}
		return new ModelAndView("lista");
	}
}
