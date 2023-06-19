package br.integration.cookmasterapi.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.integration.cookmasterapi.Ingrediente;
import br.integration.cookmasterapi.repository.IngredienteRepository;

@Service
public class IngredienteService {

	@Autowired
	private IngredienteRepository ingredienteRepository;
	
	
	public Ingrediente insert(Ingrediente ingrediente) throws Exception {
		
		//validarInsercao(marca);
		ingredienteRepository.saveAndFlush(ingrediente);
		return ingrediente;
		
	}
	
	public Ingrediente edit(Ingrediente ingrediente) throws Exception {
		//validarEdicao(ingrediente);
		ingredienteRepository.saveAndFlush(ingrediente);
		return ingrediente;
		
	}
	
	public List<Ingrediente> findAll(){
		return ingredienteRepository.findAll();
	}
	
	public Ingrediente findById(Long id) throws Exception{
		Optional<Ingrediente> retorno =  ingredienteRepository.findById(id);
		if(retorno.isPresent())
			return retorno.get();
		else
			throw new Exception("Ingrediente com ID: " + id+" não identificado!");
	}
	
	public List<Ingrediente> findByFilters(String nome) {
		return ingredienteRepository.findByDescricaoContainingAllIgnoringCase(nome);
	}
}
