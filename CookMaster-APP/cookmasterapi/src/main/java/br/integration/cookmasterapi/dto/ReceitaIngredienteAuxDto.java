package br.integration.cookmasterapi.dto;

import br.integration.cookmasterapi.model.Preparo;
import br.integration.cookmasterapi.model.Receita;
import br.integration.cookmasterapi.model.ReceitaIngrediente;
import br.integration.cookmasterapi.util.Util;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.DataFormatException;


@Data
public class ReceitaIngredienteAuxDto {

    private Long idReceita;

    @NotNull
    private String imgReceita;

    @NotNull
    private String dsReceita;

    @NotNull
    private Long idUsuario;

    @NotNull
    private Long idCategoria;

    private int voto;

    @NotNull
    @NotEmpty
    private List<PreparoDto> preparos = new ArrayList<>();


    @NotNull
    @NotEmpty
    private List<IngredienteCompostoDto> ingredientes = new ArrayList<>();


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







