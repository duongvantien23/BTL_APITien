using BusinessLayer.Interface;
using DataModel;
using DataModel.UserModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace UserVinfood_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SanPhamUserController : ControllerBase
    {
        private ISanPhamUserBusiness _sanphamBusiness;
        public SanPhamUserController(ISanPhamUserBusiness sanPhamBusiness)
        {
            _sanphamBusiness = sanPhamBusiness;
        }
        [Route("/get-all-sanpham-user")]
        [HttpGet]
        public IEnumerable<SanPhamUserModel> GetAllSanPham()
        {
            return _sanphamBusiness.GetAllSanPham();
        }
        [Route("/Search-TenSanPham")]
        [HttpGet]
        public IActionResult SearchTenSP(string TenSP)
        {
            var listsanpham = _sanphamBusiness.SearchTenSP(TenSP);
            return Ok(listsanpham);
        }
        [Route("/get-top-view-sanpham")]
        [HttpGet]
        public IActionResult GetTopViewSanPham([FromQuery] int limit)
        {
            var result = _sanphamBusiness.GetTopViewSanPham(limit);
            return Ok(result);
        }
    }
}
