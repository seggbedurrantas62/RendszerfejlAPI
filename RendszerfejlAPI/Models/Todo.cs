using System;
using System.Collections.Generic;

namespace RendszerfejlAPI.Models;

public partial class Todo
{
    public int Id { get; set; }

    public string? Description { get; set; }

    public DateTime CreatedDate { get; set; }
}
