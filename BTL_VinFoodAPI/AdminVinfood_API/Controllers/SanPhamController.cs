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
    public class SanPhamController : ControllerBase
    {
        private ISanPhamBusiness _sanphamBusiness;
        public SanPhamController(ISanPhamBusiness sanPhamBusiness)
        {
            _sanphamBusiness = sanPhamBusiness;
        }
        [Route("/get-by-id/{id}")]
        [HttpGet]
        public SanPhamModel GetDatabyID(string id)
        {
            return _sanphamBusiness.GetDatabyID(id);
        }
        [Route("/get-all-sanpham")]
        [HttpGet]
        public IEnumerable<SanPhamModel> GetAllSanPham()
        {
            return _sanphamBusiness.GetDataAll();
        }
        [Route("/get-all-sanpham-sap-het")]
        [HttpGet]
        public IEnumerable<Kho> GetLaySPSapHet()
        {
            return _sanphamBusiness.GetLaySPSapHet();
        }
        [Route("/get-by-price-sp-range")]
        [HttpGet]
        public IActionResult GetSanPhamByPriceRange([FromQuery] int min, [FromQuery] int max)
        {
            var result = _sanphamBusiness.GetSanPhamByPriceRange(min, max);
            return Ok(result);
        }
        [Route("/get-top-view-sanpham")]
        [HttpGet]
        public IActionResult GetTopViewSanPham([FromQuery] int limit)
        {
            var result = _sanphamBusiness.GetTopViewSanPham(limit);
            return Ok(result);
        }
        [Route("/Search-SanPham")]
        [HttpGet]
        public IActionResult SearchSanPham(string TenSP)
        {
            var listsanpham = _sanphamBusiness.SearchSanPham(TenSP);
            return Ok(listsanpham);
        }
        [Route("/create-sanpham")]
        [HttpPost]
        public SanPhamModel CreateSanPham([FromBody] SanPhamModel model)
        {
            _sanphamBusiness.Create(model);
            return model;
        }

        [Route("/update-sanpham")]
        [HttpPut]
        public SanPhamModel UpdateSanPham([FromBody] SanPhamModel model)
        {
            _sanphamBusiness.Update(model);
            return model;
        }
        [Route("delete-sanpham/{id}")]
        [HttpDelete]
        public IActionResult DeleteSanPham([FromRoute] int id)
        {
            _sanphamBusiness.Delete(id);
            return Ok();
        }
        [Authorize] // Đánh dấu ở đây hoặc ở Action cụ thể
        [Route("search-sanpham")]
        [HttpPost]
        public IActionResult Search([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                string TenSP = "";
                if (formData.Keys.Contains("TenSP") && !string.IsNullOrEmpty(Convert.ToString(formData["TenSP"])))
                {
                    TenSP = Convert.ToString(formData["TenSP"]);
                }
                string TenDanhMuc = "";
                if (formData.Keys.Contains("TenDanhMuc") && !string.IsNullOrEmpty(Convert.ToString(formData["TenDanhMuc"])))
                {
                    TenDanhMuc = Convert.ToString(formData["TenDanhMuc"]);
                }
                int Gia = 0;
                if (formData.Keys.Contains("Gia") && !string.IsNullOrEmpty(Convert.ToString(formData["Gia"])))
                {
                    Gia = int.Parse(formData["Gia"].ToString());
                }
                string TenNhaCC = "";
                if (formData.Keys.Contains("TenNhaCC") && !string.IsNullOrEmpty(Convert.ToString(formData["TenNhaCC"])))
                {
                    TenNhaCC = Convert.ToString(formData["TenNhaCC"]);
                }
                long total = 0;
                var data = _sanphamBusiness.Search(page, pageSize, out total, TenSP, TenDanhMuc, Gia, TenNhaCC);
                return Ok(new
                {
                    TotalItems = total,
                    Data = data,
                    Page = page,
                    PageSize = pageSize
                });
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

    }
}

