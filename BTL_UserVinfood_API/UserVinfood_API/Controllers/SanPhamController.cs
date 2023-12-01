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
        [Route("/get-all-sanpham-news")]
        [HttpGet]
        public IEnumerable<SanPhamModel> GetSanPhamNews()
        {
            return _sanphamBusiness.GetSanPhamNews();
        }
        [Route("/get-all-sanpham-bestsale")]
        [HttpGet]
        public IEnumerable<SanPhamModel> GetSanPhamBestSale()
        {
            return _sanphamBusiness.GetSanPhamBestSale();
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
        [Route("/get-by-id/{id}")]
        [HttpGet]
        public SanPhamModel GetDatabyID(string id)
        {
            return _sanphamBusiness.GetDatabyID(id);
        }
        [Route("/getall-sp-bydanhmuc")]
        [HttpGet]
        public IEnumerable<SanPhamModel> GetAllSanPhamByDanhMuc(string maDanhMuc)
        {
            return _sanphamBusiness.GetAllSanPhamByDanhMuc(maDanhMuc);
        }
        [Route("/getall-sp-spdanhmuc-traicay")]
        [HttpGet]
        public IEnumerable<SanPhamModel> GetSPDanhMucTraiCay()
        {
            return _sanphamBusiness.GetSPDanhMucTraiCay();
        }
        [Route("/getall-sp-sapxep-az")]
        [HttpGet]
        public IEnumerable<SanPhamModel> GetSanPhamAZ()
        {
            return _sanphamBusiness.GetSanPhamAZ();
        }
        [Route("/getall-sp-sapxep-za")]
        [HttpGet]
        public IEnumerable<SanPhamModel> GetSanPhamZA()
        {
            return _sanphamBusiness.GetSanPhamZA();
        }
        [Route("/getall-sp-sapxep-priceASC")]
        [HttpGet]
        public IEnumerable<SanPhamModel> GetSanPhamPriceASC()
        {
            return _sanphamBusiness.GetSanPhamPriceASC();
        }
        [Route("/getall-sp-sapxep-priceDESC")]
        [HttpGet]
        public IEnumerable<SanPhamModel> GetSanPhamPriceDESC()
        {
            return _sanphamBusiness.GetSanPhamPriceDESC();
        }
        [Route("/Search-SanPham-theoMavaTen")]
        [HttpGet]
        public IActionResult SearchSanPham(string TimKiem)
        {
            var listsanpham = _sanphamBusiness.SearchSanPham(TimKiem);
            return Ok(listsanpham);
        }
    }
}
