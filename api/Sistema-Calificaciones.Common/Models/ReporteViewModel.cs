using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sistema_Calificaciones.Common.Models
{
    public class ReporteViewModel
    {
        public int Repo_Id { get; set; }
        public string Repo_Descripcion { get; set; }
        public int? Repo_Creacion { get; set; }
        public DateTime? Repo_FechaCreacion { get; set; }
        public int? Repo_Modificacion { get; set; }
        public DateTime? Repo_FechaModificacion { get; set; }
        public bool? Repo_Estado { get; set; }
        [NotMapped]
        public string Alumno { get; set; }
        [NotMapped]

        public string Materia { get; set; }
        [NotMapped]

        public string Calificacion { get; set; }
        [NotMapped]

        public string Estado { get; set; }
    }
}
