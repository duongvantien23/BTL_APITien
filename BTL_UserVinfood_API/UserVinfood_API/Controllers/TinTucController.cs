using BussinessLayer.Interface;
using DataModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace UserVinfood_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TinTucController : ControllerBase
    {
        private ITinTucBusiness _tinTucBusiness;
        public TinTucController(ITinTucBusiness tinTucBusiness)
        {
            _tinTucBusiness = tinTucBusiness;
        }
        [Route("tintuc/get-all-user")]
        [HttpGet]
        public IEnumerable<TinTucModel> GetAllTinTuc()
        {
            return _tinTucBusiness.GetAllTinTuc();
        }
    }
}
