package br.integration.cookmasterapi.task;

import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

@Component
public class ContabilizaVoto {

    @Scheduled(fixedDelay = 1000)
    public void atualizaVoto() {
        System.out.println(
                "TASK VOTO RODANDO - ");
    }
}
