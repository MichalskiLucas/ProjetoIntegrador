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

import br.integration.cookmasterapi.Categoria;
import br.integration.cookmasterapi.services.CategoriaService;
import io.swagger.annotations.Api;

@Api(description = "Controlador Rest responsável pelas operações que representam a o objeto categoria")
@RestController
@RequestMapping(path = "/categoria")
public class CategoriaController {

	@Autowired
	private CategoriaService categoriaService;

	@PostMapping
	public Categoria insert(@RequestBody @Valid Categoria categoria) throws Exception {

		return categoriaService.insert(categoria);

	}

	@PutMapping
	public Categoria edit(@RequestBody Categoria categoria) throws Exception {

		return categoriaService.edit(categoria);

	}

	@GetMapping
	public List<Categoria> findAll() throws Exception {

		return categoriaService.findAll();

	}
	
	@GetMapping(path = "/{id}")
	public Categoria findById(@PathVariable Long id) throws Exception {
			return categoriaService.findById(id);

	}
	
	@GetMapping(path = "/filter")
	public List<Categoria> findByFilters(@RequestParam("descricao") String descricao) {

			return categoriaService.findByFilters(descricao);

	}
}
