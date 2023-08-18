package br.integration.cookmasterapi.services;

import java.util.List;
import java.util.Optional;

import br.integration.cookmasterapi.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.integration.cookmasterapi.Categoria;
import br.integration.cookmasterapi.Receita;
import br.integration.cookmasterapi.repository.ReceitaRepository;

@Service
public class ReceitaService {

	@Autowired
	private ReceitaRepository receitaRepository;
	
	
	public Receita insert(Receita receita) throws Exception {
		validarInsert(receita);
		receita.setImagem(Util.compressData(receita.getImagem()));
		receitaRepository.saveAndFlush(receita);
		return receita;
	}
	
	public Receita edit(Receita receita) throws Exception {
		receita.setImagem(Util.compressData(receita.getImagem()));
		receitaRepository.saveAndFlush(receita);
		return receita;
	}
	
	public List<Receita> findAll(){
		return receitaRepository.findAll();
	}
	
	public Receita findById(Long id) throws Exception{
		Optional<Receita> retorno =  receitaRepository.findById(id);
		if(retorno.isPresent())
			return retorno.get();
		else
			throw new Exception("Receita com ID: " + id+" não identificada!");
	}
	
	public List<Receita> findByFilters(String descricao) {
		return receitaRepository.findByDescricaoContainingAllIgnoringCase(descricao);
	}
	
	public List<Receita> findByCategoria(Categoria categoria) {
		return receitaRepository.findReceitaByCategoria(categoria);
	}
	
	private void validarInsert(Receita receita) throws Exception{
        if (receita.getId() != null){
            throw new Exception("Não deve informar o ID para inserir a receita");
        }
        if(findByFilters(receita.getDescricao()) != null){
        	throw new Exception("Receita com a mesma descrição já inserida");
        }
    }
}
