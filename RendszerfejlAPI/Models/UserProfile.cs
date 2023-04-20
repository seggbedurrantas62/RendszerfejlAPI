using System;
using System.Collections.Generic;

namespace RendszerfejlAPI.Models;

public partial class UserProfile
{
    public int UserId { get; set; }

    public string? UserName { get; set; }

    public string? Password { get; set; }

    public string? UserType { get; set; }

    public bool? IsActive { get; set; }
}
