﻿using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Clinica_Dental.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class Factura_TratamientoController : ControllerBase
    {
        // GET: api/<Factura_TratamientoController>
        [HttpGet]
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/<Factura_TratamientoController>/5
        [HttpGet("{id}")]
        public string Get(int id)
        {
            return "value";
        }

        // POST api/<Factura_TratamientoController>
        [HttpPost]
        public void Post([FromBody] string value)
        {
        }

        // PUT api/<Factura_TratamientoController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/<Factura_TratamientoController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
