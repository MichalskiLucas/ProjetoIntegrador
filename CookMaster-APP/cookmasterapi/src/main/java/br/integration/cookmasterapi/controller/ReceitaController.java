package br.integration.cookmasterapi.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import br.integration.cookmasterapi.Receita;
import br.integration.cookmasterapi.services.ReceitaService;
import io.swagger.annotations.Api;

@Api(description = "Controlador Rest responsável pelas operações que representam a o objeto usuario")
@RestController
@RequestMapping(path = "/usuario")
public class ReceitaController {

	@Autowired
	private ReceitaService receitaService;

	@PostMapping
	public Receita insert(@RequestBody @Valid Receita receita) throws Exception {

		return receitaService.insert(receita);

	}

	@PutMapping
	public Receita edit(@RequestBody Receita receita) throws Exception {

		return receitaService.edit(receita);

	}

	@GetMapping
	public List<Receita> findAll() throws Exception {

		return receitaService.findAll();

	}
	
	@GetMapping(path = "/{id}")
	public Receita findById(@PathVariable Long id) throws Exception {
			return receitaService.findById(id);

	}
	
	@GetMapping(path = "/filter")
	public List<Receita> findByFilters(@RequestParam("descricao") String descricao) {

			return receitaService.findByFilters(descricao);

	}
}
