﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Sistema_Calificaciones.Entities.Entities
{
    public partial class tbCursos
    {
        public tbCursos()
        {
            tbAlumnos = new HashSet<tbAlumnos>();
            tbMaestrosPorCursos = new HashSet<tbMaestrosPorCursos>();
        }

        public int Curs_Id { get; set; }
        public string Curs_Descripcion { get; set; }
        public int? Curs_Creacion { get; set; }
        public DateTime? Curs_FechaCreacion { get; set; }
        public int? Curs_Modificacion { get; set; }
        public DateTime? Curs_FechaModificacion { get; set; }
        public bool? Curs_Estado { get; set; }

        public virtual tbUsuarios Curs_CreacionNavigation { get; set; }
        public virtual tbUsuarios Curs_ModificacionNavigation { get; set; }
        public virtual ICollection<tbAlumnos> tbAlumnos { get; set; }
        public virtual ICollection<tbMaestrosPorCursos> tbMaestrosPorCursos { get; set; }
    }
}