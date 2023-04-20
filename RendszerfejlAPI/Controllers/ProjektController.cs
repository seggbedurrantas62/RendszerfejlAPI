using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using RendszerfejlAPI.Models;

namespace RendszerfejlAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProjektController : ControllerBase
    {
        private readonly DotNetAppSqlDbDbContext _context;

        public ProjektController(DotNetAppSqlDbDbContext context)
        {
            _context = context;
        }

        // GET: api/Projekt
        [Authorize(Roles = "admin,szakember,raktarvezeto,raktaros")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Projekt>>> GetProjekts()
        {
          if (_context.Projekts == null)
          {
              return NotFound();
          }
            return await _context.Projekts.ToListAsync();
        }

        // GET: api/Projekt/5
        [Authorize(Roles = "admin,szakember,raktarvezeto,raktaros")]
        [HttpGet("{id}")]
        public async Task<ActionResult<Projekt>> GetProjekt(int id)
        {
          if (_context.Projekts == null)
          {
              return NotFound();
          }
            var projekt = await _context.Projekts.FindAsync(id);

            if (projekt == null)
            {
                return NotFound();
            }

            return projekt;
        }

        // PUT: api/Projekt/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [Authorize(Roles = "admin,szakember,raktaros")]
        [HttpPut("{id}")]
        public async Task<IActionResult> PutProjekt(int id, Projekt projekt)
        {
            if (id != projekt.ProjektId)
            {
                return BadRequest();
            }

            _context.Entry(projekt).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ProjektExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Projekt
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [Authorize(Roles = "admin,szakember")]
        [HttpPost]
        public async Task<ActionResult<Projekt>> PostProjekt(Projekt projekt)
        {
          if (_context.Projekts == null)
          {
              return Problem("Entity set 'DotNetAppSqlDbDbContext.Projekts'  is null.");
          }
            _context.Projekts.Add(projekt);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetProjekt", new { id = projekt.ProjektId }, projekt);
        }

        // DELETE: api/Projekt/5
        [Authorize(Roles = "admin,szakember")]
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteProjekt(int id)
        {
            if (_context.Projekts == null)
            {
                return NotFound();
            }
            var projekt = await _context.Projekts.FindAsync(id);
            if (projekt == null)
            {
                return NotFound();
            }

            _context.Projekts.Remove(projekt);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool ProjektExists(int id)
        {
            return (_context.Projekts?.Any(e => e.ProjektId == id)).GetValueOrDefault();
        }
    }
}
