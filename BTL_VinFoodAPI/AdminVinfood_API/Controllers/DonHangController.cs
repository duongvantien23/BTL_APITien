using BusinessLayer.Interface;
using DataModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace AdminVinfood_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DonHangController : ControllerBase
    {
        private IDonHangBusiness _donHangBusiness;
        public DonHangController(IDonHangBusiness donHangBusiness )
        {
            _donHangBusiness = donHangBusiness;
        }
        [Route("/donhang/get-by-id/{id}")]
        [HttpGet]
        public DonHangALLModel GetDonHangDatabyID(string id)
        {
            return _donHangBusiness.GetDatabyID(id);
        }

        [Route("/donhang-get-all")]
        [HttpGet]
        public IEnumerable<DonHangModel> GetAllDonHang()
        {
            return _donHangBusiness.GetDataAll();
        }

        [Route("/trangthai-donhang-get-all")]
        [HttpGet]
        public IEnumerable<TrangThaiDonHang> GetAllStatus()
        {
            return _donHangBusiness.GetAllStatus();
        }
        [Route("/ptthanhtoan-donhang-get-all")]
        [HttpGet]
        public IEnumerable<PhuongThucThanhToan> GetAllMethod()
        {
            return _donHangBusiness.GetAllMethod();
        }
        [Route("donhang/create")]
        [HttpPost]
        public DonHangModel CreateDonHang([FromBody] DonHangModel model)
        {
            _donHangBusiness.Create(model);
            return model;
        }

        [Route("donhang-update")]
        [HttpPut]
        public DonHangModel UpdateDonHang([FromBody] DonHangModel model)
        {
            _donHangBusiness.Update(model);
            return model;
        }

        [Route("delete-donhang/{id}")]
        [HttpDelete]
        public IActionResult DeleteDonHang([FromRoute] int id)
        {
            _donHangBusiness.Delete(id);
            return Ok();
        }

        [Route("donhang-search")]
        [HttpPost]
        public IActionResult SearchDonHang([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                int maDonHang = 0;
                if (formData.Keys.Contains("maDonHang") && !string.IsNullOrEmpty(Convert.ToString(formData["maDonHang"]))) { maDonHang = int.Parse(Convert.ToString(formData["maDonHang"])); }
                int maKH = 0;
                if (formData.Keys.Contains("maKH") && !string.IsNullOrEmpty(Convert.ToString(formData["maKH"]))) { maKH = int.Parse(Convert.ToString(formData["maKH"])); }
                DateTime ngayDatHang = DateTime.MinValue;
                if (formData.Keys.Contains("ngayDatHang") && !string.IsNullOrEmpty(Convert.ToString(formData["ngayDatHang"]))) { ngayDatHang = DateTime.Parse(Convert.ToString(formData["ngayDatHang"])); }
                string phuongThucThanhToan = "";
                if (formData.Keys.Contains("phuongThucThanhToan") && !string.IsNullOrEmpty(Convert.ToString(formData["phuongThucThanhToan"]))) { phuongThucThanhToan = Convert.ToString(formData["phuongThucThanhToan"]); }
                string tenTrangThai = "";
                if (formData.Keys.Contains("tenTrangThai") && !string.IsNullOrEmpty(Convert.ToString(formData["tenTrangThai"]))) { tenTrangThai = Convert.ToString(formData["tenTrangThai"]); }

                long total = 0;
                var data = _donHangBusiness.Search(page, pageSize, out total, maDonHang, maKH, ngayDatHang, phuongThucThanhToan, tenTrangThai);

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
        [Route("/donhang-thongke")]
        [HttpPost]
        public IActionResult ThongKeDonHang([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                DateTime ngayBatDau = DateTime.MinValue;
                if (formData.ContainsKey("NgayBatDau") && formData["NgayBatDau"] != null)
                {
                    ngayBatDau = DateTime.Parse(formData["NgayBatDau"].ToString());
                }

                DateTime ngayKetThuc = DateTime.MinValue;
                if (formData.ContainsKey("NgayKetThuc") && formData["NgayKetThuc"] != null)
                {
                    ngayKetThuc = DateTime.Parse(formData["NgayKetThuc"].ToString());
                }

                var result = _donHangBusiness.ThongKeDoanhThu(ngayBatDau, ngayKetThuc);

                return Ok(result);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }
        [Route("/donhang/get-by-trangthai/{maTrangThai}")]
        [HttpGet]
        public IEnumerable<DonHangTheoTrangThai> GetDonHangByTrangThai(int maTrangThai)
        {
            return _donHangBusiness.GetDonHangByTrangThai(maTrangThai);
        }
    }
}
