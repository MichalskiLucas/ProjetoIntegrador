package br.integration.cookmasterapi;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import br.integration.cookmasterapi.enums.EnumVoto;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import org.hibernate.annotations.Type;

@Data
@Entity
@Table(name = "receita")
@ApiModel(description = "Modelo para representação de uma receita")
@Api
public class Receita {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank
    @NotEmpty
    @NotNull
    private String descricao;


    private boolean ativo;

    @Type(type = "org.hibernate.type.BinaryType")
    private byte[] imagem;

    @ManyToOne
    private Usuario usuario;

    private EnumVoto voto;

    @OneToOne
    private Categoria categoria;

}
