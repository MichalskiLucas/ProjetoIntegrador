package br.integration.cookmasterapi.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.integration.cookmasterapi.Categoria;
import br.integration.cookmasterapi.repository.CategoriaRepository;

@Service
public class CategoriaService {

	@Autowired
	private CategoriaRepository categoriaRepository;
	
	
	public Categoria insert(Categoria categoria) throws Exception {
		
		validarInsert(categoria);
		categoriaRepository.saveAndFlush(categoria);
		return categoria;
		
	}
	
	public Categoria edit(Categoria categoria) throws Exception {
		categoriaRepository.saveAndFlush(categoria);
		return categoria;
		
	}
	
	public List<Categoria> findAll(){
		return categoriaRepository.findAll();
	}
	
	public Categoria findById(Long id) throws Exception{
		Optional<Categoria> retorno =  categoriaRepository.findById(id);
		if(retorno.isPresent())
			return retorno.get();
		else
			throw new Exception("Categoria com ID: " + id+ " não identificado!");
	}
	
	public List<Categoria> findByFilters(String descricao) {
		return categoriaRepository.findByDescricaoContainingAllIgnoringCase(descricao);
	}
	
	public Categoria findByDescricao(String descricao) {
		return categoriaRepository.findCategoriaByDescricao(descricao);
	}
	
	private void validarInsert(Categoria categoria) throws Exception{
        if (categoria.getId() != null){
            throw new Exception("Não deve informar o ID para inserir a categoria");
        }
        if(findByDescricao(categoria.getDescricao()) != null){
        	throw new Exception("Categoria com a mesma descrição já inserido");
        }
    }
}
