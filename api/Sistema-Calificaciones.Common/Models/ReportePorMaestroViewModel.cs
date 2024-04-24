using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sistema_Calificaciones.Common.Models
{
  public  class ReportePorMaestroViewModel
    {
        public int Rema_Id { get; set; }
        public int? Repo_Id { get; set; }
        public int? Mate_Id { get; set; }
        public int? Maes_Id { get; set; }
        public int? Alum_Id { get; set; }
        public int? Rema_Creacion { get; set; }
        public DateTime? Rema_FechaCreacion { get; set; }
        public int? Rema_Modificacion { get; set; }
        public DateTime? Rema_FechaModificacion { get; set; }
        public bool? Rema_Estado { get; set; }
        [NotMapped]
        public string Leve { get; set; }

        [NotMapped]
        public string Grave { get; set; }
        [NotMapped]
        public string MuyGrave { get; set; }
        [NotMapped]
        public string Expulsion { get; set; }


        [NotMapped]
        public string Alumno { get; set; }
        [NotMapped]
        public string Repo_Descripcion { get; set; }
        [NotMapped]
        public string Repo_Causa { get; set; }
        [NotMapped]
        public string Mate_Descripcion { get; set; }



    }
}
