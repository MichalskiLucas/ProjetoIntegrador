package br.integration.cookmasterapi;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import br.integration.cookmasterapi.enums.EnumVoto;

@Entity
@Table(name = "receita")
public class Receita {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	private String descricao;

	
	private boolean ativo;
	
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
