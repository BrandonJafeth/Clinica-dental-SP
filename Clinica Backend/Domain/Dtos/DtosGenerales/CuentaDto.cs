﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Dtos.PostDtos
{
    public class CuentaDto
    {
        public string ID_Cuenta { get; set; }
        public decimal Saldo_Total { get; set; }
        public DateOnly Fecha_Apertura { get; set; }
        public DateOnly Fecha_Cierre { get; set; }
        public DateOnly Fecha_Ultima_Actualizacion { get; set; }
        public string Observaciones { get; set; }
        public string ID_Estado_Cuenta { get; set; }
        public string ID_Factura { get; set; }
        public string ID_Paciente { get; set; }
    }

}
