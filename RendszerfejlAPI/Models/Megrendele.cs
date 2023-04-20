using System;
using System.Collections.Generic;

namespace RendszerfejlAPI.Models;

public partial class Megrendele
{
    public int MegrendelesId { get; set; }

    public int? ElemId { get; set; }

    public int? ElemDb { get; set; }

    public int? SzuksegesKeszlet { get; set; }

    public int? ElofoglaltKeszlet { get; set; }

    public int? SzabadKeszlet { get; set; }

    public bool? Foglalt { get; set; }

    public int? LefoglalandoKeszlet { get; set; }

    public virtual Alkatresz? Elem { get; set; }

    public virtual ICollection<Projekt> Projekts { get; } = new List<Projekt>();
}
