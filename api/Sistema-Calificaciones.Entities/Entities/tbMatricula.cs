﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Sistema_Calificaciones.Entities.Entities
{
    public partial class tbMatricula
    {
        public tbMatricula()
        {
            tbAlumnos = new HashSet<tbAlumnos>();
        }

        public int Matr_Id { get; set; }
        public DateTime? Matr_FechaInicio { get; set; }
        public DateTime? Matr_FechaFinalizacion { get; set; }
        public int? Matr_Creacion { get; set; }
        public DateTime? Matr_FechaCreacion { get; set; }
        public int? Matr_Modificacion { get; set; }
        public DateTime? Matr_FechaModificacion { get; set; }
        public bool? MatrPeri_Estado { get; set; }

        public virtual tbUsuarios Matr_CreacionNavigation { get; set; }
        public virtual tbUsuarios Matr_ModificacionNavigation { get; set; }
        public virtual ICollection<tbAlumnos> tbAlumnos { get; set; }
    }
}