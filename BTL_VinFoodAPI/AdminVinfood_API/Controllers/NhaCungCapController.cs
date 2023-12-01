using BusinessLayer;
using BusinessLayer.Interface;
using DataModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace AdminVinfood_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NhaCungCapController : ControllerBase
    {
        private INhaCungCapBusiness _nhaCungCapBusiness;
        public NhaCungCapController(INhaCungCapBusiness nhaCungCapBusiness)
        {
            _nhaCungCapBusiness = nhaCungCapBusiness;
        }
        [Route("get-by-id/{id}")]
        [HttpGet]
        public NhaCungCapModel GetDatabyID(string id)
        {
            return _nhaCungCapBusiness.GetDatabyID(id);
        }
        [Route("sp_getall_nhacungcap")]
        [HttpGet]
        public IEnumerable<NhaCungCapModel> GetAllNhaCungCap()
        {
            return _nhaCungCapBusiness.GetDataAll();
        }
        [Route("/create-nhacungcap")]
        [HttpPost]
        public NhaCungCapModel CreateNhaCungCap([FromBody] NhaCungCapModel model)
        {
            _nhaCungCapBusiness.Create(model);
            return model;
        }

        [Route("/update-nhacungcap")]
        [HttpPut]
        public NhaCungCapModel UpdateNhaCungCap([FromBody] NhaCungCapModel model)
        {
            _nhaCungCapBusiness.Update(model);
            return model;
        }

        [Route("/delete-nhacungcap/{id}")]
        [HttpDelete]
        public IActionResult DeleteNhaCungCap([FromRoute] int id)
        {
            _nhaCungCapBusiness.Delete(id);
            return Ok();
        }
    }
}
