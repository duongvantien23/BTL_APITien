using BusinessLayer.Interface;
using DataModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace AdminVinfood_API.Controllers
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
        [Route("get-by-id/{id}")]
        [HttpGet]
        public DanhMucModel GetDatabyID(string id)
        {
            return _danhMucBusiness.GetDatabyID(id);
        }

        [Route("get-all-danhmuc")]
        [HttpGet]
        public IEnumerable<DanhMucModel> GetAllDanhMuc()
        {
            return _danhMucBusiness.GetDataAll();
        }

        [Route("/create-danhmuc")]
        [HttpPost]
        public DanhMucModel CreateDanhMuc([FromBody] DanhMucModel model)
        {
            _danhMucBusiness.Create(model);
            return model;
        }

        [Route("/update-danhmuc")]
        [HttpPut]
        public DanhMucModel UpdateDanhMuc([FromBody] DanhMucModel model)
        {
            _danhMucBusiness.Update(model);
            return model;
        }

        [Route("/delete-sanpham/{id}")]
        [HttpDelete]
        public IActionResult DeleteDanhMuc([FromRoute] int id)
        {
            _danhMucBusiness.Delete(id);
            return Ok();
        }
    }
}
