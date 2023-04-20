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
    public class RaktarController : ControllerBase
    {
        private readonly DotNetAppSqlDbDbContext _context;

        public RaktarController(DotNetAppSqlDbDbContext context)
        {
            _context = context;
        }

        // GET: api/Raktar
        [Authorize(Roles = "admin,szakember,raktarvezeto,raktaros")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Raktar>>> GetRaktars()
        {
          if (_context.Raktars == null)
          {
              return NotFound();
          }
            return await _context.Raktars.ToListAsync();
        }

        // GET: api/Raktar/5
        [Authorize(Roles = "admin,szakember,raktarvezeto,raktaros")]
        [HttpGet("{id}")]
        public async Task<ActionResult<Raktar>> GetRaktar(int id)
        {
          if (_context.Raktars == null)
          {
              return NotFound();
          }
            var raktar = await _context.Raktars.FindAsync(id);

            if (raktar == null)
            {
                return NotFound();
            }

            return raktar;
        }

        // PUT: api/Raktar/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [Authorize(Roles = "admin,raktarvezeto")]
        [HttpPut("{id}")]
        public async Task<IActionResult> PutRaktar(int id, Raktar raktar)
        {
            if (id != raktar.RekeszId)
            {
                return BadRequest();
            }

            _context.Entry(raktar).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!RaktarExists(id))
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

        // POST: api/Raktar
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [Authorize(Roles = "admin,raktarvezeto")]
        [HttpPost]
        public async Task<ActionResult<Raktar>> PostRaktar(Raktar raktar)
        {
          if (_context.Raktars == null)
          {
              return Problem("Entity set 'DotNetAppSqlDbDbContext.Raktars'  is null.");
          }
            _context.Raktars.Add(raktar);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetRaktar", new { id = raktar.RekeszId }, raktar);
        }

        // DELETE: api/Raktar/5
        [Authorize(Roles = "admin,raktarvezeto")]
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteRaktar(int id)
        {
            if (_context.Raktars == null)
            {
                return NotFound();
            }
            var raktar = await _context.Raktars.FindAsync(id);
            if (raktar == null)
            {
                return NotFound();
            }

            _context.Raktars.Remove(raktar);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool RaktarExists(int id)
        {
            return (_context.Raktars?.Any(e => e.RekeszId == id)).GetValueOrDefault();
        }
    }
}
