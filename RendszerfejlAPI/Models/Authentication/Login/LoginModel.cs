using Microsoft.Build.Framework;
using System.ComponentModel.DataAnnotations;

namespace RendszerfejlAPI.Models.Authentication.Login
{
    public class LoginModel
    {
        [System.ComponentModel.DataAnnotations.Required(ErrorMessage = "Username is required")]
        public string Username { get; set; }

        [System.ComponentModel.DataAnnotations.Required(ErrorMessage = "Password is required")]
        public string Password { get; set; }

    }
}
