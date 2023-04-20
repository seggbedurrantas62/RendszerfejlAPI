using System.ComponentModel.DataAnnotations;

namespace RendszerfejlAPI.Models.Authentication.SignUp
{
    public class RegisterUser
    {
        [Required(ErrorMessage = "Username required")]
        public string UserName { get; set; }

        [Required(ErrorMessage = "Password required")]
        public string Password { get; set; }

        [EmailAddress]
        [Required(ErrorMessage = "Email required")]
        public string Email { get; set; }
    }
}
