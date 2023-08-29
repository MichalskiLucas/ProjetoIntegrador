package br.integration.cookmasterapi.services;

import br.integration.cookmasterapi.Receita;
import br.integration.cookmasterapi.Usuario;
import br.integration.cookmasterapi.Voto;
import br.integration.cookmasterapi.repository.ReceitaRepository;
import br.integration.cookmasterapi.repository.UsuarioRepository;
import br.integration.cookmasterapi.repository.VotoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class VotoService {

    @Autowired
    private VotoRepository votoRepository;

    @Autowired
    private ReceitaRepository receitaRepository;


    public Voto insert(Voto voto) throws Exception {
        validaInsert(voto);
        votoRepository.saveAndFlush(voto);
        return voto;

    }

    public Voto edit(Voto voto) throws Exception {
        validaUpdate(voto);
        votoRepository.saveAndFlush(voto);
        return voto;

    }

    public List<Voto> findAll() {
        return votoRepository.findAll();
    }

    public Voto findById(Long id) throws Exception {
        Optional<Voto> retorno = votoRepository.findById(id);
        if (retorno.isPresent()) return retorno.get();
        else throw new Exception("Voto com ID: " + id + " não identificado!");
    }

    public List<Voto> findByReceita(Long receitaId) {
        Optional<Receita> receita = receitaRepository.findById(receitaId);
        return votoRepository.findVotoByReceita(receita);
    }

    private void validaInsert(Voto voto) throws Exception {
        if (voto.getId() != null)
            throw new Exception("Para inserir um voto, não deve-se informar o ID");
    }

    private void validaUpdate(Voto voto) throws Exception {

        if (voto.getId() == null || voto.getId() == 0)
            throw new Exception("Para atualizar um voto, deve-se informar o ID.");
    }
}
