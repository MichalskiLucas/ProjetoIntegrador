package br.integration.cookmasterapi.services;

import br.integration.cookmasterapi.model.Usuario;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.List;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender javaMailSender;

    @Autowired
    UsuarioService usuarioService;

    private void sendMail(String dest, String assunto, String corpo) throws Exception {
        MimeMessage mensagem = javaMailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mensagem, true);

        helper.setTo(dest);
        helper.setSubject(assunto);
        helper.setText(corpo, false);
        try {
            javaMailSender.send(mensagem);
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }

    }


    public void sendEmailRecipe(long idReceita) throws Exception {
        String corpo = "Receita com id: " + idReceita + " encontra-se pendente de aprovação.";
        String assunto = "Receita pendente de aprovação";
        List<Usuario> usuarios = usuarioService.findAdmin();

        for (int i = 0; i < usuarios.size(); i++) {
            sendMail(usuarios.get(i).getEmail(), corpo, assunto);
        }
    }

    public void sendEmailIngredient(long idIngrediente) throws Exception {
        String corpo = "Ingrediente com id: " + idIngrediente + " encontra-se pendente de aprovação.";
        String assunto = "Ingredente pendente de aprovação";
        List<Usuario> usuarios = usuarioService.findAdmin();

        for (int i = 0; i < usuarios.size(); i++) {
            sendMail(usuarios.get(i).getEmail(), corpo, assunto);
        }
    }

}