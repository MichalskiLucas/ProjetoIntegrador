package br.integration.cookmasterapi.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import br.integration.cookmasterapi.dto.*;
import br.integration.cookmasterapi.enums.EnumUnitMeasure;
import br.integration.cookmasterapi.model.*;
import br.integration.cookmasterapi.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.integration.cookmasterapi.repository.ReceitaRepository;

@Service
public class ReceitaService {

    @Autowired
    private ReceitaRepository receitaRepository;

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private EmailService emailService;

    @Autowired
    private PreparoService preparoService;

    @Autowired
    private CategoriaService categoriaService;

    @Autowired
    private ReceitaIngredienteService receitaIngredienteService;

    public Receita insert(ReceitaDto dto) throws Exception {
        Receita r = receitaRepository.saveAndFlush(validaInsert(dto));
        emailService.sendEmailRecipe(r.getId());
        return r;

    }

    public ReceitaIngredienteAuxDto insertRecipeComplete(ReceitaIngredienteAuxDto dto) throws Exception {

        ReceitaDto receitaDto = new ReceitaDto();

        Usuario usuario = usuarioService.findById(dto.getIdUsuario());

        receitaDto.setUsuario(usuario);
        receitaDto.setDescricao(dto.getDsReceita());
        receitaDto.setImagem(dto.getImgReceita());
        receitaDto.setVoto(0);
        receitaDto.setAtivo(false);
        receitaDto.setCategoriaId(dto.getIdCategoria());
        Receita r = insert(receitaDto);

        dto.setIdReceita(r.getId());

        for (int i = 0; i < dto.getPreparos().size(); i++) {
            PreparoDto preparoDto = new PreparoDto();
            preparoDto.setReceita(r);
            preparoDto.setDescricao(dto.getPreparos().get(i).getDescricao());
            Preparo p = preparoService.insert(preparoDto);
            dto.getPreparos().get(i).setId(p.getId());
        }

        for (int i = 0; i < dto.getIngredientes().size(); i++) {
            ReceitaIngredienteDto receitaIngredienteDto = new ReceitaIngredienteDto();
            receitaIngredienteDto.setReceita(r);
            receitaIngredienteDto.setIngredienteId(dto.getIngredientes().get(i).getId());
            receitaIngredienteDto.setQtdIngrediente(dto.getIngredientes().get(i).getQtdIngrediente());
            receitaIngredienteDto.setUnMedida(EnumUnitMeasure.valueOf(dto.getIngredientes().get(i).getUnMedida()));
            receitaIngredienteService.insert(receitaIngredienteDto);
        }

        return dto;
    }


    public Receita edit(ReceitaDto dto) throws Exception {
        return receitaRepository.saveAndFlush(validaUpdate(dto));
    }

    public List<Receita> findAll() {
        return receitaRepository.findByAtivoIsTrue();
    }

    public List<Receita> findTopFive() {
        return receitaRepository.findTop5ByOrderByVotoDesc();
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

    public List<Receita> findByCategoria(Long categoriaId) {
        return receitaRepository.findByCategoriaIdAndAndAtivoIsTrue(categoriaId);
    }

    public List<Long> findIdReceitaWithVoto() {
        return receitaRepository.findIdReceitaWithVoto();
    }

    private Receita validaInsert(ReceitaDto dto) throws Exception {

        Receita r = new Receita();

        if (dto.getId() != null)
            throw new Exception("Para inserir uma nova receita, não deve-se informar o ID");

        r.setDescricao(dto.getDescricao());
        if (dto.getImagem() != null)
            r.setImagem(Util.compressData(dto.getImagem()));
        r.setAtivo(dto.isAtivo());
        if (dto.getCategoriaId() != null)
            r.setCategoria(categoriaService.findById(dto.getCategoriaId()));
        r.setUsuario(dto.getUsuario());
        r.setVoto(dto.getVoto());

        return r;
    }

    private Receita validaUpdate(ReceitaDto dto) throws Exception {

        if (dto.getId() == null)
            throw new Exception("Para atualizar uma receita, deve-se informar o ID");

        Receita r = findById(dto.getId());

        r.setId(dto.getId());
        r.setDescricao(dto.getDescricao());
        r.setImagem(Util.compressData(dto.getImagem()));
        r.setAtivo(dto.isAtivo());
        if (dto.getCategoriaId() != null)
            r.setCategoria(categoriaService.findById(dto.getCategoriaId()));
        r.setUsuario(dto.getUsuario());
        r.setVoto(dto.getVoto());
        return r;

    }

    public void updateVoto(Long idReceita, int voto) throws Exception {
        Receita receita = findById(idReceita);
        receita.setVoto(voto);
        receitaRepository.saveAndFlush(receita);
    }

    public ReceitaCompletaDto findReceitaCompleteById(Long idReceita) throws Exception {
        ReceitaCompletaDto rcDto = new ReceitaCompletaDto();
        ReceitaDto rDto = new ReceitaDto();

        Receita receita = findById(idReceita);
        List<ReceitaIngrediente> receitaIngredienteList = receitaIngredienteService.findByReceitaId(idReceita);
        List<Preparo> preparoList = preparoService.findByReceitaId(idReceita);

        rcDto.setId(receita.getId());
        rcDto.setDescricao(receita.getDescricao());
        rcDto.setImage(Util.decompress(receita.getImagem()));
        rcDto.setIdCategoria(receita.getCategoria().getId());
        rcDto.setIdUsuario(receita.getUsuario().getId());
        rcDto.setVoto(receita.getVoto());

        for (int i = 0; i < preparoList.size(); i++) {
            PreparoAuxDto preparoAuxDto = new PreparoAuxDto();
            preparoAuxDto.setDescricao(preparoList.get(i).getDescricao());
            rcDto.getPreparo().add(preparoAuxDto);
        }

        for (int i = 0; i < receitaIngredienteList.size(); i++) {
            IngredienteCompostoDto icDto = new IngredienteCompostoDto();
            icDto.setId(receitaIngredienteList.get(i).getIngrediente().getId());
            icDto.setDescricao(receitaIngredienteList.get(i).getIngrediente().getDescricao());
            icDto.setQtdIngrediente(receitaIngredienteList.get(i).getQtdIngrediente());
            icDto.setUnMedida(receitaIngredienteList.get(i).getUnMedida().getValue());

            rcDto.getIngredientes().add(icDto);
        }

        return rcDto;
    }

    public List<ReceitaDto> findByIngredientes(IngredienteIdDto ingredientes) throws Exception {
        return new ReceitaDto().getListInstance(receitaRepository.findByIngredienteId(ingredientes.getIngredientes()));
    }
}
