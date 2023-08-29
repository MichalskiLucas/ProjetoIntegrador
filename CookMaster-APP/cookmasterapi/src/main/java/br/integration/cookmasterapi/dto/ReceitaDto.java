package br.integration.cookmasterapi.dto;

import br.integration.cookmasterapi.Categoria;
import br.integration.cookmasterapi.Receita;
import br.integration.cookmasterapi.Usuario;
import br.integration.cookmasterapi.enums.EnumVoto;
import br.integration.cookmasterapi.util.Util;
import lombok.Data;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;
import java.util.zip.DataFormatException;

@Data
public class ReceitaDto extends BaseDto<Receita, ReceitaDto> {

    private Long id;
    private String descricao;
    private boolean ativo;
    private String imagem;
    private Usuario usuario;
    private Double voto;
    private Categoria categoria;

    @Override
    public ReceitaDto getInstance(Receita entity) throws IOException, DataFormatException {
        if (entity != null) {
            ReceitaDto dto = new ReceitaDto();

            dto.setId(entity.getId());
            dto.setDescricao(entity.getDescricao());
            dto.setAtivo(entity.isAtivo());
            dto.setImagem(Util.decompress(entity.getImagem()));
            dto.setUsuario(entity.getUsuario());
            dto.setVoto(entity.getVoto());
            dto.setCategoria(entity.getCategoria());
            return null;
        } else
            return null;
    }

    @Override
    public List<ReceitaDto> getListInstance(List<Receita> list) {
        return list.stream().map((Receita r) -> {
            try {
                return getInstance(r);
            } catch (IOException | DataFormatException e) {
                throw new RuntimeException(e);
            }
        }).collect(Collectors.toList());

    }
}
