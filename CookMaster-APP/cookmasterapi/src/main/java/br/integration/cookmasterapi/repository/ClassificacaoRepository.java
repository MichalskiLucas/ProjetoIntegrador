package br.integration.cookmasterapi.repository;

import java.util.List;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import br.integration.cookmasterapi.Classificacao;
import br.integration.cookmasterapi.Receita;
@Repository
public interface ClassificacaoRepository extends JpaRepository<Classificacao,Long>{

	@Query
	public List<Classificacao> findByReceita(Receita receita);
	
	
}
