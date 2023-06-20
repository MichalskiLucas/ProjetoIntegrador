package br.integration.cookmasterapi;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import br.integration.cookmasterapi.enums.EnumVoto;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModel;

@Entity
@Table(name = "classificacao")
@ApiModel(description = "Modelo para representação de uma entidade de calssificação")
@Api
public class Classificacao {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@ManyToOne
	private Receita receita;
	
	@ManyToOne
	private Usuario usuario;
	
	
	private EnumVoto voto;


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


	public Usuario getUsuario() {
		return usuario;
	}


	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}


	public EnumVoto getVoto() {
		return voto;
	}


	public void setVoto(EnumVoto voto) {
		this.voto = voto;
	}


	public Classificacao(Long id, Receita receita, Usuario usuario, EnumVoto voto) {
		this.id = id;
		this.receita = receita;
		this.usuario = usuario;
		this.voto = voto;
	}
	
	public Classificacao() {
	}


	@Override
	public String toString() {
		return "Classificacao [id=" + id + ", receita=" + receita + ", usuario=" + usuario + ", voto=" + voto + "]";
	}
	
	
}
