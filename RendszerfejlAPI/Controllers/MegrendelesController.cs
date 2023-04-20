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
    public class MegrendelesController : ControllerBase
    {
        private readonly DotNetAppSqlDbDbContext _context;

        public MegrendelesController(DotNetAppSqlDbDbContext context)
        {
            _context = context;
        }

        // GET: api/Megrendeles
        [Authorize(Roles = "admin,szakember,raktarvezeto,raktaros")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Megrendele>>> GetMegrendeles()
        {
          if (_context.Megrendeles == null)
          {
              return NotFound();
          }
            return await _context.Megrendeles.ToListAsync();
        }

        // GET: api/Megrendeles/5
        [Authorize(Roles = "admin,szakember,raktarvezeto,raktaros")]
        [HttpGet("{id}")]
        public async Task<ActionResult<Megrendele>> GetMegrendele(int id)
        {
          if (_context.Megrendeles == null)
          {
              return NotFound();
          }
            var megrendele = await _context.Megrendeles.FindAsync(id);

            if (megrendele == null)
            {
                return NotFound();
            }

            return megrendele;
        }

        // PUT: api/Megrendeles/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [Authorize(Roles = "admin,szakember")]
        [HttpPut("{id}")]
        public async Task<IActionResult> PutMegrendele(int id, Megrendele megrendele)
        {
            if (id != megrendele.MegrendelesId)
            {
                return BadRequest();
            }

            _context.Entry(megrendele).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!MegrendeleExists(id))
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

        // POST: api/Megrendeles
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [Authorize(Roles = "admin,szakember")]
        [HttpPost]
        public async Task<ActionResult<Megrendele>> PostMegrendele(Megrendele megrendele)
        {
          if (_context.Megrendeles == null)
          {
              return Problem("Entity set 'DotNetAppSqlDbDbContext.Megrendeles'  is null.");
          }
            _context.Megrendeles.Add(megrendele);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetMegrendele", new { id = megrendele.MegrendelesId }, megrendele);
        }

        // DELETE: api/Megrendeles/5
        [Authorize(Roles = "admin,szakember")]
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteMegrendele(int id)
        {
            if (_context.Megrendeles == null)
            {
                return NotFound();
            }
            var megrendele = await _context.Megrendeles.FindAsync(id);
            if (megrendele == null)
            {
                return NotFound();
            }

            _context.Megrendeles.Remove(megrendele);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool MegrendeleExists(int id)
        {
            return (_context.Megrendeles?.Any(e => e.MegrendelesId == id)).GetValueOrDefault();
        }
    }
}
