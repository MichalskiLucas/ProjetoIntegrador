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
		
		validarInsert(ingrediente);
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
	
	public List<Ingrediente> findByFilters(String descricao) {
		return ingredienteRepository.findByDescricaoContainingAllIgnoringCase(descricao);
	}
	
	public Ingrediente findByDescricao(String descricao) {
		return ingredienteRepository.findIngredienteByDescricao(descricao);
	}
	
	private void validarInsert(Ingrediente ingrediente) throws Exception{
        if (ingrediente.getId() != null){
            throw new Exception("Não deve informar o ID para inserir o ingrediente");
        }
        if(findByDescricao(ingrediente.getDescricao()) != null){
        	throw new Exception("Ingrediente com a mesma descrição já inserido");
        }
    }
}
