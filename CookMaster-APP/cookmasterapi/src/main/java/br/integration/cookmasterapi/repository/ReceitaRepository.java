package br.integration.cookmasterapi.repository;

import java.util.List;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import br.integration.cookmasterapi.model.Categoria;
import br.integration.cookmasterapi.model.Receita;

@Repository
public interface ReceitaRepository extends JpaRepository<Receita,Long>{

	@Query
	public List<Receita> findByDescricaoContainingAllIgnoringCase(String descricao);
	
	@Query
	public List<Receita> findReceitaByCategoria(Categoria categoria);

	@Query("select r.id from Receita r where r.voto != null")
	List<Long> findIdReceitaWithVoto ();



//	public List<Receita> findTop5ReceitasByVoto() {
//		String hql = "SELECT r FROM Receita r ORDER BY r.voto DESC";
//		Query query = entityManager.createQuery(hql);
//		query.setMaxResults(5); // Defina o limite aqui
//
//		return query.getResultList();
//	}
}

