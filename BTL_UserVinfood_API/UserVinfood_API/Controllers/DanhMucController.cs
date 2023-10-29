using BussinessLayer.Interface;
using DataModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace UserVinfood_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DanhMucController : ControllerBase
    {
        private IDanhMucBusiness _danhMucBusiness;
        public DanhMucController(IDanhMucBusiness danhMucBusiness)
        {
            _danhMucBusiness = danhMucBusiness;
        }
        [Route("get-all-danhmuc-user")]
        [HttpGet]
        public IEnumerable<DanhMucModel> GetAllDanhMuc()
        {
            return _danhMucBusiness.GetAll();
        }
    }
}
