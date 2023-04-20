using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using RendszerfejlAPI.Models;

namespace RendszerfejlAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AlkatreszController : ControllerBase
    {
        private readonly DotNetAppSqlDbDbContext _context;

        public AlkatreszController(DotNetAppSqlDbDbContext context)
        {
            _context = context;
        }

        // GET: api/Alkatresz
        [Authorize(Roles = "admin,szakember,raktarvezeto,raktaros")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Alkatresz>>> GetAlkatreszs()
        {
          if (_context.Alkatreszs == null)
          {
              return NotFound();
          }
            return await _context.Alkatreszs.ToListAsync();
        }

        // GET: api/Alkatresz/5
        [Authorize(Roles = "admin,szakember,raktarvezeto,raktaros")]
        [HttpGet("{id}")]
        public async Task<ActionResult<Alkatresz>> GetAlkatresz(int id)
        {
          if (_context.Alkatreszs == null)
          {
              return NotFound();
          }
            var alkatresz = await _context.Alkatreszs.FindAsync(id);

            if (alkatresz == null)
            {
                return NotFound();
            }

            return alkatresz;
        }

        // PUT: api/Alkatresz/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [Authorize(Roles = "admin,raktarvezeto")]
        [HttpPut("{id}")]
        public async Task<IActionResult> PutAlkatresz(int id, Alkatresz alkatresz)
        {
            if (id != alkatresz.ElemId)
            {
                return BadRequest();
            }

            _context.Entry(alkatresz).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!AlkatreszExists(id))
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

        // POST: api/Alkatresz
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [Authorize(Roles = "admin,raktarvezeto")]
        [HttpPost]
        public async Task<ActionResult<Alkatresz>> PostAlkatresz(Alkatresz alkatresz)
        {
          if (_context.Alkatreszs == null)
          {
              return Problem("Entity set 'DotNetAppSqlDbDbContext.Alkatreszs'  is null.");
          }
            _context.Alkatreszs.Add(alkatresz);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetAlkatresz", new { id = alkatresz.ElemId }, alkatresz);
        }

        // DELETE: api/Alkatresz/5
        [Authorize(Roles = "admin,raktarvezeto")]
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteAlkatresz(int id)
        {
            if (_context.Alkatreszs == null)
            {
                return NotFound();
            }
            var alkatresz = await _context.Alkatreszs.FindAsync(id);
            if (alkatresz == null)
            {
                return NotFound();
            }

            _context.Alkatreszs.Remove(alkatresz);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool AlkatreszExists(int id)
        {
            return (_context.Alkatreszs?.Any(e => e.ElemId == id)).GetValueOrDefault();
        }
    }
}
