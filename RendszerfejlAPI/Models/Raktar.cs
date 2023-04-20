using System;
using System.Collections.Generic;

namespace RendszerfejlAPI.Models;

public partial class Raktar
{
    public int RekeszId { get; set; }

    public int? ElemId { get; set; }

    public int? Sor { get; set; }

    public int? Oszlop { get; set; }

    public int? Szint { get; set; }

    public int? RekeszMeret { get; set; }

    public virtual Alkatresz? Elem { get; set; }
}
