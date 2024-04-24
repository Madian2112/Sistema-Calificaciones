using AutoMapper;
using Sistema_Calificaciones.Common.Models;
using Sistema_Calificaciones.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Sistema_Calificaciones.API.Extensions
{
    public class MappingProfileExtensions: Profile
    {
        public MappingProfileExtensions()
        {
            CreateMap<UsuarioViewModel, tbUsuarios>().ReverseMap();
            CreateMap<CalificacionesAlumnoViewModel, tbCalificacionPorAlumno>().ReverseMap();
            CreateMap<PadresporAlumnoViewModel, tbPadresPorAlumno>().ReverseMap();
            CreateMap<ReportePorMaestroViewModel, tbReportesPorMaestros>().ReverseMap();



        }
    }
}
