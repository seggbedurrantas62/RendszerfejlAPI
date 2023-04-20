using System;
using System.Collections.Generic;

namespace RendszerfejlAPI.Models;

public partial class Projekt
{
    public int ProjektId { get; set; }

    public string? Allapot { get; set; }

    public int? MegrendelesId { get; set; }

    public DateTime? Datum { get; set; }

    public int? Osszeg { get; set; }

    public virtual Megrendele? Megrendeles { get; set; }
}
