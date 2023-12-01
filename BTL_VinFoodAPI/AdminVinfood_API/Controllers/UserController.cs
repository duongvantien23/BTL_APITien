using BusinessLayer;
using BusinessLayer.Interface;
using DataModel;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace AdminVinfood_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {

        private IUserBusiness _user;
        public UserController(IUserBusiness user)
        {
            _user = user;
        }

        [AllowAnonymous]
        [HttpPost("login")]
        public IActionResult Login([FromBody] AuthenticateModel model)
        {
            var user = _user.Login(model.Username, model.Password);
            if (user == null)
                return BadRequest(new { message = "Tài khoản hoặc mật khẩu không đúng!" });
            return Ok(new { taikhoan = user.TenDangNhap, email = user.Email, token = user.token });
        }
        [Route("user/create")]
        [HttpPost]
        public IActionResult CreateAccount([FromBody] LoginRequestModel model)
        {
            try
            {
                _user.Create(model);
                return Ok(new { message = "Tạo tài khoản thành công." });
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = $"Lỗi: {ex.Message}" });
            }
        }
    }
}
