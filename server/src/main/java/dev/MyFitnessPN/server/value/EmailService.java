package dev.MyFitnessPN.server.value;

import com.sendgrid.Method;
import com.sendgrid.Request;
import com.sendgrid.Response;
import com.sendgrid.SendGrid;
import com.sendgrid.helpers.mail.Mail;
import com.sendgrid.helpers.mail.objects.Content;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import com.sendgrid.helpers.mail.objects.Email;

import java.io.IOException;

@Service
@RequiredArgsConstructor
public class EmailService {
    private final SendGrid sendGrid;
    public void sendSingleResetPasswordEmail(String toEmail, String subject, String token ) throws IOException {
        // specify the email details
        String fromEmail = "projectfinderweb@gmail.com";
        Email from = new Email(fromEmail);

        Email to = new Email(toEmail);
        String emailVerifyHtml = "<!DOCTYPE html>\n" +
                "    <html lang=\"en\">\n" +
                "    <head>\n" +
                "      <meta charset=\"UTF-8\">\n" +
                "      <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n" +
                "      <title>Mã đặt lại mật khẩu</title>\n" +
                "      <style>\n" +
                "        body {\n" +
                "          font-family: Arial, sans-serif;\n" +
                "          line-height: 1.6;\n" +
                "        }\n" +
                "        .email-container {\n" +
                "          max-width: 600px;\n" +
                "          margin-left: 80px;\n" +
                "          padding: 20px;\n" +
                "        }\n" +
                "        .thank-you {\n" +
                "          font-size: 18px;\n" +
                "          font-weight: bold;\n" +
                "          margin-bottom: 15px;\n" +
                "        }\n" +
                "        .order-details {\n" +
                "          margin-top: 20px;\n" +
                "          margin-bottom: 15px;\n" +
                "        }\n" +
                "        .item {\n" +
                "          margin-bottom: 15px;\n" +
                "          padding-left: 20px; /* Thụt lề so với cha của nó */\n" +
                "          border-left: 2px solid #333; /* Đường kẻ bên trái để làm nổi bật */\n" +
                "        }\n" +
                "        .item p {\n" +
                "          margin: 5px 0;\n" +
                "        }\n" +
                "      </style>\n" +
                "    </head>\n" +
                "    <body>\n" +
                "      <div class=\"email-container\">\n" +
                "        <h1>MY FITNESS PN</h1>\n" +
                "        <p class=\"thank-you\">Chào bạn,</p>\n" +
                "        <p>Bạn đã yêu cầu đặt lại mật khẩu. Làm ơn nhập mã dưới đây trong vòng 10p </p>\n" +
                "        <p class=\"order-details\">Mã của bạn là: </p>\n" +
                "        <p class=\"thank-you\">"+token+"</p>\n" +
                "       \n" +
                "        <p class=\"order-details\">Nếu bạn không yêu cầu đặt lại mật khẩu, hãy bỏ qua email này và liên hệ ngay cho chúng tôi.</p>\n" +
                "    \n" +
                "        <p class=\"order-details\">Xin chân thành cảm ơn bạn và chúc bạn một ngày tốt lành!</p>\n" +
                "      </div>\n" +
                "    </body>\n" +
                "    </html>";
        Content content = new Content("text/html", emailVerifyHtml);

        // initialize the Mail helper class
        Mail mail = new Mail(from, subject, to, content);
        sendEmail(mail);
    }
    private void sendEmail(Mail mail) throws IOException {
        // set the SendGrid API endpoint details as described
        // in the doc (https://docs.sendgrid.com/api-reference/mail-send/mail-send)
        Request request = new Request();
        request.setMethod(Method.POST);
        request.setEndpoint("mail/send");
        request.setBody(mail.build());

        // perform the request and send the email
        Response response = sendGrid.api(request);
        int statusCode = response.getStatusCode();
        // if the status code is not 2xx
        if (statusCode < 200 || statusCode >= 300) {
            throw new RuntimeException(response.getBody());
        }
    }
}
