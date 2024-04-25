using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Sistema_Calificaciones.BusinessLogic.Services;
using Sistema_Calificaciones.Common.Models;
using Sistema_Calificaciones.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Sistema_Calificaciones.API.Controllers
{
    [ApiController]
    [Route("/API/[controller]")]
    public class UsuarioController : Controller
    {
        private readonly AccesoServices _accesoServices;
        private readonly IMapper _mapper;
        public UsuarioController(AccesoServices accesoServices, IMapper mapper)
        {
            _accesoServices = accesoServices;
            _mapper = mapper;
        }

        [HttpGet("ListadoUsuarios")]
        public IActionResult Index()
        {
            var list = _accesoServices.ListUsuarios();
            return Ok(list);
        }

        [HttpGet("ListadoRoles")]
        public IActionResult RolIndex()
        {
            var list = _accesoServices.ListRoless();
            return Ok(list);
        }

        [HttpGet("LoginHome")]
        public IActionResult Login(string Usuario, string Contra)
        {

            var list = _accesoServices.Login(Usuario, Contra);

            return Ok(list);
        }



        [HttpPost("CreateUsuarios")]
        public IActionResult Insert(UsuarioViewModel item)
        {
            var model = _mapper.Map<tbUsuarios>(item);
            var modelo = new tbUsuarios()
            {
                Usua_Usuario = item.Usua_Usuario,
                Usua_Clave = item.Usua_Clave,
                Role_Id = item.Role_Id,
                Usua_EsAdmin = item.Usua_EsAdmin,
                Usua_Creacion = item.Usua_Creacion,
                Usua_FechaCreacion = DateTime.Now,
            };
            var list = _accesoServices.InsertarUsuarios(modelo);
            return Ok(list);
        }

        [HttpGet("FillUsuarios")]

        public IActionResult Llenar(int id)
        {

            var list = _accesoServices.ListUsuar(id);
            return Json(list);
        }

        [HttpPut("UpdateUsuarios")]
        public IActionResult Update(UsuarioViewModel item)
        {
            var model = _mapper.Map<tbUsuarios>(item);
            var modelo = new tbUsuarios()
            {
                Usua_Id = item.Usua_Id,
                Usua_Usuario = item.Usua_Usuario,
                Role_Id = item.Role_Id,
                Usua_EsAdmin = item.Usua_EsAdmin,
                Usua_Modificacion = item.Usua_Modificacion,
                Usua_FechaModificacion = DateTime.Now,
            };
            var list = _accesoServices.ActualizarUsuarios(modelo);
            return Ok(list);
        }

        [HttpDelete("DeleteUsuarios")]
        public IActionResult Delete(int usua_Id)
        {
            int usuario = 1;
            DateTime fecha = DateTime.Now;
            var list = _accesoServices.EliminarUsuarios(usua_Id, usuario, fecha);
            return Ok(list);
        }




        [HttpPost("RestablecerUsuarios")]
        public IActionResult Restablecer(int Usua_Id, string Usua_Clave, int usuario, DateTime fecha)
        {
            var list = _accesoServices.Restablecer(Usua_Id, Usua_Clave, usuario, fecha);
            return Ok(list);
        }


    }
}
