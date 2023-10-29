using BussinessLayer.Interface;
using DataModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace UserVinfood_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SanPhamController : ControllerBase
    {
        private ISanPhamBusiness _sanphamBusiness;
        public SanPhamController(ISanPhamBusiness sanPhamBusiness)
        {
            _sanphamBusiness = sanPhamBusiness;
        }
        [Route("/get-all-sanpham-user")]
        [HttpGet]
        public IEnumerable<SanPhamModel> GetAllSanPham()
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
