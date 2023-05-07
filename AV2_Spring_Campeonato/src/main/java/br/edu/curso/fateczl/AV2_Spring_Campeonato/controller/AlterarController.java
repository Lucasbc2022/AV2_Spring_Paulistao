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

import br.edu.curso.fateczl.AV2_Spring_Campeonato.model.Times;
import br.edu.curso.fateczl.AV2_Spring_Campeonato.persistence.AlterarDAO;
import br.edu.curso.fateczl.AV2_Spring_Campeonato.persistence.TimesDAO;

@Controller
public class AlterarController {
	
	@Autowired
	AlterarDAO aDAO;
	
	@Autowired
	TimesDAO tDAO;

	@RequestMapping(name = "alterar", value = "/alterar", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
	    List<Times> times = new ArrayList<>();
	    String erro = "";
	    String saida = "";
	    
	    try {
	    		times = tDAO.listar();
	    		System.out.println(times);
	    	
	    } catch (SQLException | ClassNotFoundException e) {
	    	erro = e.getMessage();
	    } finally {
	    	model.addAttribute("saida", saida);
	    	model.addAttribute("erro", erro);
	    	model.addAttribute("times", times);
	    }		
		return new ModelAndView("alterar");
	}
	
	@RequestMapping(name = "alterar", value = "/alterar", method = RequestMethod.POST)
	public ModelAndView alterar(ModelMap model, @RequestParam Map<String, String> allParam) {

		String botao = allParam.get("botao");
		String timeA = allParam.get("timeA");
		String timeB = allParam.get("timeB");
		
		String saida = "";
		String erro = "";
		

		try {
			String nomeA = timeA;
			String nomeB = timeB;
			int golsA = Integer.parseInt(allParam.get("gols_timeA"));
			int golsB = Integer.parseInt(allParam.get("gols_timeB"));
			String data_jogo = allParam.get("data_jogo");
			if(botao.equalsIgnoreCase("alterar")) {
				System.out.println(nomeA +" "+ nomeB +" "+ golsA +" "+ golsB +" "+ data_jogo );
				saida = aDAO.alterarGols(nomeA, nomeB, golsA, golsB, data_jogo);
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
		}
	    return new ModelAndView("alterar");	
	}
}
