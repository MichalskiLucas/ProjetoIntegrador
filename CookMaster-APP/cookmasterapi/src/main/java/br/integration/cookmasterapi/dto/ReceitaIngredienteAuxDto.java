package br.integration.cookmasterapi.dto;

import br.integration.cookmasterapi.model.Preparo;
import br.integration.cookmasterapi.model.Receita;
import br.integration.cookmasterapi.model.ReceitaIngrediente;
import br.integration.cookmasterapi.util.Util;
import lombok.Data;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.DataFormatException;


@Data
public class ReceitaIngredienteAuxDto {
    private Long idReceita;
    private String imgReceita;
    private String dsReceita;
    private Long idUsuario;
    private List<Preparo> preparos = new ArrayList<>();
    private int voto;
    private List<IngredienteCompostoDto> ingredientes = new ArrayList<>();
    private ReceitaIngrediente receitaIngrediente;

    public ReceitaIngredienteAuxDto getInstance(ReceitaIngrediente entity) throws IOException, DataFormatException {
        if (entity != null) {
            ReceitaIngredienteAuxDto dto = new ReceitaIngredienteAuxDto();
            if(entity.getReceita() != null){
                dto.setIdReceita(entity.getReceita().getId());

                if(entity.getReceita().getImagem() != null)
                   dto.setImgReceita(Util.decompress(entity.getReceita().getImagem()));

                if(entity.getReceita().getUsuario() != null)
                    dto.setIdUsuario(entity.getReceita().getUsuario().getId());

                dto.setVoto(entity.getReceita().getVoto());
            }

          /*

            dto.setId(entity.getId());
            dto.setDescricao(entity.getDescricao());
            dto.setAtivo(entity.isAtivo());
            if(entity.getImagem() !=null)
                dto.setImagem(Util.decompress(entity.getImagem()));

            dto.setUsuario(entity.getUsuario());
            dto.setVoto(entity.getVoto());
            dto.setCategoria(entity.getCategoria());

           */
            return dto;
        } else
            return null;
    }


}







