﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Dtos.PostDtos
{
    public class FacturaDto
    {
        public string ID_Factura { get; set; }
        public decimal MontoTotal_Fa { get; set; }
        public DateOnly FechaEmision_Fa { get; set; }
        public string ID_EstadoPago { get; set; }
    }

}
