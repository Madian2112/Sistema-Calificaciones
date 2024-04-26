using Microsoft.AspNetCore.Http;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Sistema_Calificaciones.API.Services;
using Sistema_Calificaciones.BusinessLogic.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Sistema_Calificaciones.Common.Models;
using Sistema_Calificaciones.Entities.Entities;

namespace Sistema_Calificaciones.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class MailController : ControllerBase
    {
        private readonly IMailService _mailService;
        private readonly AccesoServices _accesoServices;
        //injecting the IMailService into the constructor
        public MailController(IMailService _MailService, AccesoServices accesoServices)
        {
            _mailService = _MailService;
            _accesoServices = accesoServices;
        }

        [HttpPost]
        [Route("SendMail")]
        public bool SendMail(MailData mailData)
        {
            return _mailService.SendMail(mailData);
        }

        [HttpGet]
        [Route("EnviarCodigo")]
        public IActionResult EnviarCodigo(string usuario)
        {
            string email = "";
            string codigo = "";

            var lista = _accesoServices.EnviarCodigo(usuario);
            var list = lista.Data as IEnumerable<tbUsuarios>;

            foreach (var item in list)
            {
                email = item.Email;
                codigo = item.Codigo;
            }

            MailData mailData = new MailData();
            mailData.EmailToId = email;
            mailData.EmailSubject = "Codigo para restablecer contraseñia";
            mailData.EmailBody = codigo;

            SendMail(mailData);

            return Ok(lista);
        }

    }
}
