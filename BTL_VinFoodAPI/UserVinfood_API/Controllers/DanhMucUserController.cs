using BusinessLayer.Interface;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using DataModel.UserModel;
using DataModel;

namespace UserVinfood_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DanhMucUserController : ControllerBase
    {
        private IDanhMucUserBusiness _danhMucBusiness;
        public DanhMucUserController(IDanhMucUserBusiness danhMucBusiness)
        {
            _danhMucBusiness = danhMucBusiness;
        }
        [Route("get-all-danhmuc-user")]
        [HttpGet]
        public IEnumerable<DanhMucUserModel> GetAllDanhMuc()
        {
            return _danhMucBusiness.GetAll();
        }
    }
}
