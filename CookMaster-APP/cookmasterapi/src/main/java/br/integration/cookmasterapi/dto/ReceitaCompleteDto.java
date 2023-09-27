package br.integration.cookmasterapi.dto;

import br.integration.cookmasterapi.model.Ingrediente;
import br.integration.cookmasterapi.model.ReceitaIngrediente;
import lombok.Data;

import java.util.List;

@Data
public class ReceitaCompleteDto {
    private ReceitaDto receitaDto;
    private ReceitaIngrediente receitaIngrediente;
}



