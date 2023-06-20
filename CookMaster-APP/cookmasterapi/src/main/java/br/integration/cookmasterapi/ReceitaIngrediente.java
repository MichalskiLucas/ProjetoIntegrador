package br.integration.cookmasterapi;

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

@Entity
@Table(name = "receitaingrediente")
@ApiModel(description = "Modelo para representação de uma entidade ReceitaIngrediente")
@Api
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
	
	@OneToOne
	private Categoria categoria;
	
	@NotBlank
	@NotEmpty
	@NotNull
	private Double qtdIngrediente;
	
	
	//private Double qtdIngrediente;
	
	@NotBlank
	@NotEmpty
	@NotNull
	@Enumerated(EnumType.STRING)
	private EnumUnitMeasure unMedida;
	
	private boolean ativo;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Receita getReceita() {
		return receita;
	}

	public void setReceita(Receita receita) {
		this.receita = receita;
	}

	public EnumUnitMeasure getUnMedida() {
		return unMedida;
	}

	public void setUnMedida(EnumUnitMeasure unMedida) {
		this.unMedida = unMedida;
	}

	public boolean isAtivo() {
		return ativo;
	}

	public void setAtivo(boolean ativo) {
		this.ativo = ativo;
	}

	public List<Ingrediente> getIngredientes() {
		return ingredientes;
	}

	public void setIngredientes(List<Ingrediente> ingredientes) {
		this.ingredientes = ingredientes;
	}

	public List<Preparo> getPreparo() {
		return preparo;
	}

	public void setPreparo(List<Preparo> preparo) {
		this.preparo = preparo;
	}

	public Categoria getCategoria() {
		return categoria;
	}

	public void setCategoria(Categoria categoria) {
		this.categoria = categoria;
	}

	public Double getQtdIngrediente() {
		return qtdIngrediente;
	}

	public void setQtdIngrediente(Double qtdIngrediente) {
		this.qtdIngrediente = qtdIngrediente;
	}

	@Override
	public String toString() {
		return "ReceitaIngrediente [id=" + id + ", ingredientes=" + ingredientes + ", preparo=" + preparo + ", receita="
				+ receita + ", categoria=" + categoria + ", qtdIngrediente=" + qtdIngrediente + ", unMedida=" + unMedida
				+ ", ativo=" + ativo + "]";
	}

	public ReceitaIngrediente(Long id, List<Ingrediente> ingredientes, List<Preparo> preparo, Receita receita,
			Categoria categoria, Double qtdIngrediente, EnumUnitMeasure unMedida, boolean ativo) {
		this.id = id;
		this.ingredientes = ingredientes;
		this.preparo = preparo;
		this.receita = receita;
		this.categoria = categoria;
		this.qtdIngrediente = qtdIngrediente;
		this.unMedida = unMedida;
		this.ativo = ativo;
	}
	
	public ReceitaIngrediente() {
	}
	
	
	
}
