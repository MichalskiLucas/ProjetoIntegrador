package br.integration.cookmasterapi.repository;

import br.integration.cookmasterapi.dto.IngredienteIdDto;
import br.integration.cookmasterapi.model.Receita;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReceitaRepository extends JpaRepository<Receita,Long>{

	@Query
	public List<Receita> findByDescricaoContainingAllIgnoringCase(String descricao);
	
	@Query
	public List<Receita> findByCategoriaId(Long categoriaId);

	@Query("select r.id from Receita r where r.voto != null")
	List<Long> findIdReceitaWithVoto ();

	List<Receita> findTop5ByOrderByVotoDesc();

	@Query(value = "select receita.*\n" +
			       "  from receita,\n" +
			       "       receitaingrediente\n" +
			       " where receita.id = receitaingrediente.receita_id\n" +
			       "   and receitaingrediente.ingrediente_id in (:ingredientes)" +
			       " group by receita.id",
	nativeQuery = true)

	List<Receita> findByIngredienteId(@Param("ingredientes")List<Long> ingredientes);


}

