using BusinessLayer;
using BusinessLayer.Interface;
using DataModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace AdminVinfood_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HoaDonNhapController : ControllerBase
    {
        private IHoaDonNhapBusiness _hoadonnhapBusiness;
        public HoaDonNhapController(IHoaDonNhapBusiness hoadonnhapBusiness)
        {
            _hoadonnhapBusiness = hoadonnhapBusiness;
        }
        [Route("/hoadonnhap/get-by-id/{id}")]
        [HttpGet]
        public HoaDonNhapAllModel GetDonHangDatabyID(string id)
        {
            return _hoadonnhapBusiness.GetDatabyID(id);
        }

        [Route("/hoadonnhap-get-all")]
        [HttpGet]
        public IEnumerable<HoaDonNhapAllModel> GetAllDonHang()
        {
            return _hoadonnhapBusiness.GetDataAll();
        }

        [Route("hoadonnhap/create")]
        [HttpPost]
        public HoaDonNhapModel CreateHDNhap([FromBody] HoaDonNhapModel model)
        {
            _hoadonnhapBusiness.Create(model);
            return model;
        }

        [Route("hoadonnhap-update")]
        [HttpPut]
        public HoaDonNhapModel UpdateHDNhap([FromBody] HoaDonNhapModel model)
        {
            _hoadonnhapBusiness.Update(model);
            return model;
        }

        [Route("delete-hoadonnhap/{id}")]
        [HttpDelete]
        public IActionResult DeleteHDNhap([FromRoute] int id)
        {
            _hoadonnhapBusiness.Delete(id);
            return Ok();
        }
    }
}
