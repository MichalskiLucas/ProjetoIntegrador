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
	
	@Column(length = 320000)
	private String imagem;
	
	@ManyToOne
	private Usuario usuario;
	
	private EnumVoto voto;
	
	@OneToOne
	private Categoria categoria;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public boolean isAtivo() {
		return ativo;
	}

	public void setAtivo(boolean ativo) {
		this.ativo = ativo;
	}

	public String getImagem() {
		return imagem;
	}

	public void setImagem(String imagem) {
		this.imagem = imagem;
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

	public Categoria getCategoria() {
		return categoria;
	}

	public void setCategoria(Categoria categoria) {
		this.categoria = categoria;
	}

	public Receita(Long id, String descricao, boolean ativo, String imagem, Usuario usuario, EnumVoto voto,
			Categoria categoria) {
		this.id = id;
		this.descricao = descricao;
		this.ativo = ativo;
		this.imagem = imagem;
		this.usuario = usuario;
		this.voto = voto;
		this.categoria = categoria;
	}
	
	public Receita() {
	}

	@Override
	public String toString() {
		return "Receita [id=" + id + ", descricao=" + descricao + ", ativo=" + ativo + ", imagem=" + imagem
				+ ", usuario=" + usuario + ", voto=" + voto + ", categoria=" + categoria + "]";
	}
	
	
}
