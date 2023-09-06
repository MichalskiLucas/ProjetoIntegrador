package br.integration.cookmasterapi.services;

import br.integration.cookmasterapi.model.ReceitaIngrediente;
import br.integration.cookmasterapi.repository.ReceitaIngredienteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ReceitaIngredienteService {

    @Autowired
    private ReceitaIngredienteRepository receitaIngredienteRepository;


    public ReceitaIngrediente insert(ReceitaIngrediente receitaIngrediente) throws Exception {

        validarInsert(receitaIngrediente);
        receitaIngredienteRepository.saveAndFlush(receitaIngrediente);
        return receitaIngrediente;

    }

    public ReceitaIngrediente edit(ReceitaIngrediente receitaIngrediente) throws Exception {

        receitaIngredienteRepository.saveAndFlush(receitaIngrediente);
        return receitaIngrediente;

    }

    public List<ReceitaIngrediente> findAll() {
        return receitaIngredienteRepository.findAll();
    }

    public ReceitaIngrediente findById(Long id) throws Exception {
        Optional<ReceitaIngrediente> retorno = receitaIngredienteRepository.findById(id);
        if (retorno.isPresent())
            return retorno.get();
        else
            throw new Exception("ReceitaIngrediente com ID: " + id + " não identificado!");
    }

    public List<ReceitaIngrediente> findByFilters(String descricao) {
        return null;
        //return receitaIngredienteRepository.findByDescricaoContainingAllIgnoringCase(descricao);
    }

    private void validarInsert(ReceitaIngrediente receitaIngrediente) throws Exception {
//        if (preparo.getId() != null) {
//            throw new Exception("Não deve informar o ID para inserir o preparo");
//        }
    }
}
