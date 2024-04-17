using System;
using MailKit.Net.Smtp;
using MailKit.Security;
using Microsoft.Extensions.Options;
using MimeKit;
using Sistema_Calificaciones.API.Services;

namespace Sistema_Calificaciones.API
{
    public class MailService : IMailService
    {
        private readonly MailSettings _mailSettings;

        public MailService(IOptions<MailSettings> mailSettingsOptions)
        {
            _mailSettings = mailSettingsOptions.Value;
        }

        public bool SendMail(MailData mailData)
        {
            try
            {
                using (var emailMessage = new MimeMessage())
                {
                    emailMessage.From.Add(new MailboxAddress(_mailSettings.SenderName, _mailSettings.SenderEmail));
                    emailMessage.To.Add(new MailboxAddress(mailData.EmailToName, mailData.EmailToId));
                    emailMessage.Subject = mailData.EmailSubject;

                    var bodyBuilder = new BodyBuilder { TextBody = mailData.EmailBody };
                    emailMessage.Body = bodyBuilder.ToMessageBody();

                    using (var client = new SmtpClient())
                    {
                        client.ServerCertificateValidationCallback = (s, c, h, e) => true; // Ignorar errores de validación del certificado

                        client.Connect(_mailSettings.Server, _mailSettings.Port, SecureSocketOptions.Auto);

                        // Note: only needed if the SMTP server requires authentication
                        client.Authenticate(_mailSettings.UserName, _mailSettings.Password);

                        client.Send(emailMessage);
                        client.Disconnect(true);
                    }
                }

                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}
