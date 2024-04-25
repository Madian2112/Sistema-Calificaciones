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
    public class ReporteporMaestroController : Controller
    {
        private readonly ReporteServices _reporteServices;
        private readonly IMapper _mapper;
        public ReporteporMaestroController(ReporteServices reporteServices, IMapper mapper)
        {
            _reporteServices = reporteServices;
            _mapper = mapper;
        }



        [HttpGet("ReporteMestro/{id}")]
        public IActionResult reportemaestro(int id)
        {

            var list = _reporteServices.mestroreporte(id);
            return Json(list);
        }




        [HttpPost("CreateReporte")]
        public IActionResult Insert(ReportePorMaestroViewModel item)
        {
            var model = _mapper.Map<tbReportesPorMaestros>(item);
            var modelo = new tbReportesPorMaestros()
            {
                Repo_Id = item.Repo_Id,
                Mate_Id = item.Mate_Id,
                Alum_Id = item.Alum_Id,
                Repo_Causa = item.Repo_Causa,
              Rema_FechaCreacion = DateTime.Now,
            };
            var list = _reporteServices.InsertarReporte(modelo);
            return Ok(list);
        }

        [HttpGet("FillReportem")]

        public IActionResult Llenar(int id)
        {

            var list = _reporteServices.ListreporteM(id);
            return Json(list);
        }

        [HttpPut("Updatereportem")]
        public IActionResult Update(ReportePorMaestroViewModel item)
        {
            var model = _mapper.Map<tbReportesPorMaestros>(item);
            var modelo = new tbReportesPorMaestros()
            {
                Rema_Id = item.Rema_Id,

                Repo_Id = item.Repo_Id,
                Mate_Id = item.Mate_Id,
                Alum_Id = item.Alum_Id,
                Repo_Causa = item.Repo_Causa,
                Rema_Modificacion = 1,
                Rema_FechaModificacion = DateTime.Now,
            };
            var list = _reporteServices.ActualizarReporte(modelo);
            return Ok(list);
        }

        [HttpDelete("Deletereportem")]
        public IActionResult Delete(int rema_Id)
        {
            int usuario = 1;
            DateTime fecha = DateTime.Now;
            var list = _reporteServices.EliminarReporte(rema_Id, usuario, fecha);
            return Ok(list);
        }





        [HttpGet("ListadoMateriam")]
        public IActionResult MateriaIndex()
        {
            var list = _reporteServices.Listmateria();
            return Ok(list);
        }



        [HttpGet("ListadoAlumnom")]
        public IActionResult AlumnoIndex()
        {
            var list = _reporteServices.Listalumno();
            return Ok(list);
        }




        [HttpGet("ListadoReportem")]
        public IActionResult ReporteIndex()
        {
            var list = _reporteServices.Listreporte();
            return Ok(list);
        }





    }
}
