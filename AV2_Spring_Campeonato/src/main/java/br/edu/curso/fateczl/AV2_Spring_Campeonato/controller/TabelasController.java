package br.edu.curso.fateczl.AV2_Spring_Campeonato.controller;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
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
public class TabelasController {

	@Autowired
	JogosDAO jDao;
	
	@RequestMapping(name = "tabelas", value = "/tabelas", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("tabelas");
	}
	
	@RequestMapping(name = "tabelas", value = "/tabelas", method = RequestMethod.POST)
	public ModelAndView tabela(ModelMap model, @RequestParam Map<String, String> allParam) {
		String botao = allParam.get("botao");
		List<Jogos> tabela = new ArrayList<>();
		String erro = "";
		String saida = "";
		
		try {
			LocalDate data = (LocalDate.parse(allParam.get("data")));
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy", Locale.US);
			String data_string = data.format(dtf);
			
			if(botao.equalsIgnoreCase("buscar")) {
				 tabela = jDao.buscarJogos(data_string);
			}
			
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("tabela", tabela);
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
		}
		return new ModelAndView("tabelas");
	}}
