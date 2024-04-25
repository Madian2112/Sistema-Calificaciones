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
       

    public class AlumnoController : Controller
    {

     
            private readonly ReporteServices _reporteServices;
            private readonly IMapper _mapper;
            public AlumnoController(ReporteServices reporteServices, IMapper mapper)
            {
                _reporteServices = reporteServices;
                _mapper = mapper;
            }

            [HttpGet("CaliparcialAlumno/{id}")]
        public IActionResult CalificacioparcialAlumno(int id)
        {

            var list = _reporteServices.Cafiparcial(id);
            return Json(list);
        }

    }
}
