using BusinessLayer.Interfaces;
using DataModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace AdminVinfood_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SanPhamController : ControllerBase
    {
        private ISanPhamBusinesss _sanPhamBUS;

        public SanPhamController(ISanPhamBusinesss sanPhamBUS)
        {
            _sanPhamBUS = sanPhamBUS;
        }

        [Route("get-by-id/{id}")]
        [HttpGet]
        public SanPhamModel GetSanPhamByID(string id)
        {
            return _sanPhamBUS.GetSanPhamByID(id);
        }
        [Route("get-all-sanpham")]
        [HttpGet]
        public IEnumerable<SanPhamModel> GetAllSanPham()
        {
            return _sanPhamBUS.GetAllSanPham();
        }

        [Route("create-sanpham")]
        [HttpPost]
        public SanPhamModel CreateSanpham([FromBody] SanPhamModel model)
        {
            _sanPhamBUS.Create(model);
            return model;
        }

        [Route("update-sanpham")]
        [HttpPut]
        public SanPhamModel UpdateSanpham([FromBody] SanPhamModel model)
        {
            _sanPhamBUS.Update(model);
            return model;
        }

        [Route("/delete-sanpham")]
        [HttpDelete]
        public IActionResult DeleteSanPham([FromBody] int id)
        {
            _sanPhamBUS.Delete(id);
            return Ok();
        }

        [Route("search-sanpham")]
        [HttpPost]
        public IActionResult Search([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                string TenSanPham = "";
                if (formData.Keys.Contains("TenSP") && !string.IsNullOrEmpty(Convert.ToString(formData["TenSP"]))) { TenSanPham = Convert.ToString(formData["TenSP"]); }
                long total = 0;
                var data = _sanPhamBUS.Search(page, pageSize, out total, TenSanPham);
                return Ok(
                   new
                   {
                       TotalItems = total,
                       Data = data,
                       Page = page,
                       PageSize = pageSize
                   }
                   );
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
