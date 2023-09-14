package br.integration.cookmasterapi.model;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import br.integration.cookmasterapi.enums.EnumUnitMeasure;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModel;
import lombok.Data;

@Entity
@Table(name = "receitaingrediente")
@ApiModel(description = "Modelo para representação de uma entidade ReceitaIngrediente")
@Api
@Data
public class ReceitaIngrediente {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToMany
    private List<Ingrediente> ingredientes;

    @OneToMany
    private List<Preparo> preparo;

    @OneToOne
    private Receita receita;

    @NotBlank
    @NotEmpty
    @NotNull
    private Double qtdIngrediente;

    @NotBlank
    @NotEmpty
    @NotNull
    @Enumerated(EnumType.STRING)
    private EnumUnitMeasure unMedida;
}
