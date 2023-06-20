package br.integration.cookmasterapi;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModel;

@Entity
@Table(name = "sacola")
@ApiModel(description = "Modelo para representação de uma entidade sacola")
@Api
public class Sacola {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@ManyToOne(cascade=CascadeType.ALL)
	private Usuario usuario;
	
	
	@OneToMany
	private List<Ingrediente> ingredientes;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Usuario getUsuario() {
		return usuario;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}

	public List<Ingrediente> getIngredientes() {
		return ingredientes;
	}

	public void setIngredientes(List<Ingrediente> ingredientes) {
		this.ingredientes = ingredientes;
	}

	public Sacola(Long id, Usuario usuario, List<Ingrediente> ingredientes) {
		this.id = id;
		this.usuario = usuario;
		this.ingredientes = ingredientes;
	}
	
	public Sacola() {
	}

	@Override
	public String toString() {
		return "Sacola [id=" + id + ", usuario=" + usuario + ", ingredientes=" + ingredientes + "]";
	}

	
	
}
