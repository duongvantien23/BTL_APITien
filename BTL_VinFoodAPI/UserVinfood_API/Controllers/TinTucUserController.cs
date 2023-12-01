using BusinessLayer.Interface;
using DataModel;
using DataModel.UserModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace UserVinfood_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TinTucUserController : ControllerBase
    {
        private ITinTucUserBusiness _tinTucBusiness;
        public TinTucUserController(ITinTucUserBusiness tinTucBusiness)
        {
            _tinTucBusiness = tinTucBusiness;
        }
        [Route("tintuc/get-all-user")]
        [HttpGet]
        public IEnumerable<TinTucUserModel> GetAllTinTuc()
        {
            return _tinTucBusiness.GetAllTinTuc();
        }
    }
}
