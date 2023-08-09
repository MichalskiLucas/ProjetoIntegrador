package br.integration.cookmasterapi;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModel;
import lombok.Data;

@Entity
@Table(name = "categoria")
@ApiModel(description = "Modelo para representação de uma entidade de categoria")
@Api
@Data
public class Categoria {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String descricao;
    @Column(length = 320000)
    private String imagem;


}
