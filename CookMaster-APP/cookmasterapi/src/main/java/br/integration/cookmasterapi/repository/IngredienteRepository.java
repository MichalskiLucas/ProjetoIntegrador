package br.integration.cookmasterapi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import br.integration.cookmasterapi.Ingrediente;

public interface IngredienteRepository extends JpaRepository<Ingrediente,Long>{

	@Query
	public List<Ingrediente> findByDescricaoContainingAllIgnoringCase(String nome);
	
}
