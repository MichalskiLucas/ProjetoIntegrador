package br.integration.cookmasterapi.services;

import java.util.List;
import java.util.Optional;

import br.integration.cookmasterapi.dto.CategoriaDto;
import br.integration.cookmasterapi.dto.ReceitaDto;
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


    public Receita insert(ReceitaDto dto) throws Exception {

        return receitaRepository.saveAndFlush(validaInsert(dto));

    }

    public Receita edit(ReceitaDto dto) throws Exception {
        return receitaRepository.saveAndFlush(validaUpdate(dto));
    }

    public List<Receita> findAll() {
        return receitaRepository.findAll();
    }

    public Receita findById(Long id) throws Exception {
        Optional<Receita> retorno = receitaRepository.findById(id);
        if (retorno.isPresent())
            return retorno.get();
        else
            throw new Exception("Receita com ID: " + id + " não identificada!");
    }

    public List<Receita> findByFilters(String descricao) {
        return receitaRepository.findByDescricaoContainingAllIgnoringCase(descricao);
    }

    public List<Receita> findByCategoria(Categoria categoria) {
        return receitaRepository.findReceitaByCategoria(categoria);
    }

    private Receita validaInsert(ReceitaDto dto) throws Exception {

        Receita r = new Receita();

        if (dto.getId() != null)
            throw new Exception("Para inserir uma nova receita, não deve-se informar o ID");
        if (findByFilters(dto.getDescricao()) != null) {
            throw new Exception("Receita com a mesma descrição já inserida");
        }
        r.setId(dto.getId());
        r.setDescricao(dto.getDescricao());
        r.setImagem(Util.compressData(dto.getImagem()));
        r.setAtivo(dto.isAtivo());
        r.setCategoria(dto.getCategoria());
        r.setUsuario(dto.getUsuario());
        r.setVoto(dto.getVoto());
        return r;

    }

    private Receita validaUpdate(ReceitaDto dto) throws Exception {

        if (dto.getId() == null)
            throw new Exception("Para atualizar uma receita, deve-se informar o ID");

        Receita r = findById(dto.getId());

        if (findByFilters(dto.getDescricao()) != null)
            throw new Exception("Receita com a mesma descrição já inserida");

        r.setId(dto.getId());
        r.setDescricao(dto.getDescricao());
        r.setImagem(Util.compressData(dto.getImagem()));
        r.setAtivo(dto.isAtivo());
        r.setCategoria(dto.getCategoria());
        r.setUsuario(dto.getUsuario());
        r.setVoto(dto.getVoto());
        return r;

    }
}
