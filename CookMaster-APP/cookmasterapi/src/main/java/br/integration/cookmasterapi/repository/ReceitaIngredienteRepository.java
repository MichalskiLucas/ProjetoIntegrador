package br.integration.cookmasterapi.repository;

import br.integration.cookmasterapi.ReceitaIngrediente;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReceitaIngredienteRepository extends JpaRepository<ReceitaIngrediente, Long> {

//    @Query
//    public List<Preparo> findByDescricaoContainingAllIgnoringCase(String descricao);
}
