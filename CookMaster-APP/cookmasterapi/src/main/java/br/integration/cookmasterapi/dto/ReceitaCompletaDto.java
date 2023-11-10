package br.integration.cookmasterapi.dto;

import br.integration.cookmasterapi.model.Preparo;
import br.integration.cookmasterapi.model.Receita;
import br.integration.cookmasterapi.model.ReceitaIngrediente;
import lombok.Data;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.List;

@Data
public class ReceitaCompletaDto {

    private Long id;

    private String descricao;

    private String image;

    private Long idUsuario;

    private Long idCategoria;

    private int voto;

    private List<PreparoAuxDto> preparo = new ArrayList<>();

    private List<IngredienteCompostoDto> ingredientes = new ArrayList<>();

}
