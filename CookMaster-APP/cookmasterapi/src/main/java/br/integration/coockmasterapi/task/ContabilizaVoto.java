package br.integration.coockmasterapi.task;

import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@EnableAsync
public class ContabilizaVoto {

    @Async
    @Scheduled(fixedRate = 1000)
    public void atualizaVoto() {
        System.out.println(
                "TASK VOTO RODANDO - ");
    }
}
