using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Sistema_Calificaciones.BusinessLogic.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Sistema_Calificaciones.API.Controllers
{
    [ApiController]
    [Route("/API/[controller]")]
    public class DashboardController : Controller
    {
       
       
            private readonly ReporteServices  _reporteServices;
            private readonly IMapper _mapper;
            public DashboardController(ReporteServices reporteServices , IMapper mapper)
         {
            _reporteServices = reporteServices;
                _mapper = mapper;
          }




        [HttpGet("AlumnosPorPadre/{id}")]
        public IActionResult alumnospadre(int id)
        {

            var list = _reporteServices.alumnoPadre(id);
            return Json(list);
        }


        [HttpGet("CaliAlumno/{id}")]
        public IActionResult CalificacionporAlumno(int id)
        {

            var list = _reporteServices.CafiAlumno(id);
            return Json(list);
        }


        [HttpGet("EstadocalificacionesAlumno/{id}")]
        public IActionResult EstadoCalificacionAlumno(int id)
        {

            var list = _reporteServices.EStadoCalificacion(id);
            return Json(list);
        }


        [HttpGet("ReportesAlumno/{id}")]
        public IActionResult Reporte(int id)
        {

            var list = _reporteServices.ReportesProfe(id);
            return Json(list);
        }


        [HttpGet("EstadisticasReporte/{id}")]
        public IActionResult EstadisticaReportes(int id)
        {

            var list = _reporteServices.estadisticaReporte(id);
            return Json(list);
        }

    }
}
