using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Sistema_Calificaciones.API.Services
{
    public interface IMailService
    {
        bool SendMail(MailData mailData);
    }
}
