package br.integration.cookmasterapi.dto;

import java.io.IOException;
import java.util.List;
import java.util.zip.DataFormatException;

public abstract class BaseDto<TEntity, TDto> {

    public abstract List<TDto> getListInstance(List<TEntity> list);

    public abstract TDto getInstance(TEntity oentity) throws IOException, DataFormatException;

    private String erro;

    public String getErro() {
        return erro;
    }

    public void setErro(String erro) {
        this.erro = erro;
    }

}