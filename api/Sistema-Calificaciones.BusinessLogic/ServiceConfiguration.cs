﻿using Microsoft.Extensions.DependencyInjection;
using Sistema_Calificaciones.DataAccess;
using Sistema_Calificaciones.DataAccess.Repository;
using Sistema_Calificaciones.BusinessLogic.Services;
using System;
using System.Collections.Generic;
using System.Text;

namespace Sistema_Calificaciones.BusinessLogic.Services
{
    public static class ServiceConfiguration
    {
        public static void DataAccess(this IServiceCollection service, string conn)
        {
            service.AddScoped<UsuarioRepository>();
            service.AddScoped<ReporteRepository>();
            service.AddScoped<RolRepository>();





            Sistema_CalificacionesContex.BuildConnectionString(conn);
        }
        public static void BusinessLogic(this IServiceCollection service)
        {
            service.AddScoped<AccesoServices>();
            service.AddScoped<ReporteServices>();


        }
    }
}
