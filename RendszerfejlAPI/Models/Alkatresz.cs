using System;
using System.Collections.Generic;

namespace RendszerfejlAPI.Models;

public partial class Alkatresz
{
    public int ElemId { get; set; }

    public string? ElemNev { get; set; }

    public int? ElemAr { get; set; }

    public int? Meret { get; set; }

    public int? Keszlet { get; set; }

    public int? LefoglaltKeszlet { get; set; }

    public string? AlkatreszAllapot { get; set; }

    public virtual ICollection<Megrendele> Megrendeles { get; } = new List<Megrendele>();

    public virtual ICollection<Raktar> Raktars { get; } = new List<Raktar>();
}
