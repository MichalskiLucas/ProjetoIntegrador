package br.integration.cookmasterapi.repository;

import java.util.Date;
import java.util.List;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import br.integration.cookmasterapi.Categoria;
import br.integration.cookmasterapi.Receita;

@Repository
public interface ReceitaRepository extends JpaRepository<Receita,Long>{

	@Query
	public List<Receita> findByDescricaoContainingAllIgnoringCase(String descricao);
	
	@Query
	public List<Receita> findReceitaByCategoria(Categoria categoria);

//	@Query("select r from Receita r order by r.voto desc limit 5")
//	List<Receita> findDistinctTopByVotoWithLimit5 ();



//	public List<Receita> findTop5ReceitasByVoto() {
//		String hql = "SELECT r FROM Receita r ORDER BY r.voto DESC";
//		Query query = entityManager.createQuery(hql);
//		query.setMaxResults(5); // Defina o limite aqui
//
//		return query.getResultList();
//	}
}

