using BusinessLayer.Interface;
using DataModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace AdminVinfood_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TinTucController : ControllerBase
    {
        private ITinTucBusiness _tinTucBusiness;
        public TinTucController(ITinTucBusiness tinTucBusiness)
        {
            _tinTucBusiness = tinTucBusiness;
        }
        [Route("tintuc/get-by-id/{id}")]
        [HttpGet]
        public TinTucModel GetTinTucDatabyID(string id)
        {
            return _tinTucBusiness.GetDatabyID(id);
        }

        [Route("tintuc/get-all")]
        [HttpGet]
        public IEnumerable<TinTucModel> GetAllTinTuc()
        {
            return _tinTucBusiness.GetDataAll();
        }

        [Route("tintuc/create")]
        [HttpPost]
        public TinTucModel CreateTinTuc([FromBody] TinTucModel model)
        {
            _tinTucBusiness.Create(model);
            return model;
        }

        [Route("tintuc/update")]
        [HttpPut]
        public TinTucModel UpdateTinTuc([FromBody] TinTucModel model)
        {
            _tinTucBusiness.Update(model);
            return model;
        }

        [Route("delete-tintuc/{id}")]
        [HttpDelete]
        public IActionResult DeleteTinTuc([FromRoute] int id)
        {
            _tinTucBusiness.Delete(id);
            return Ok();
        }

        [Route("tintuc/search")]
        [HttpPost]
        public IActionResult SearchTinTuc([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                string tieude = "";
                if (formData.Keys.Contains("tieude") && !string.IsNullOrEmpty(Convert.ToString(formData["tieude"]))) { tieude = Convert.ToString(formData["tieude"]); }
                string noidung = "";
                if (formData.Keys.Contains("noidung") && !string.IsNullOrEmpty(Convert.ToString(formData["noidung"]))) { noidung = Convert.ToString(formData["noidung"]); }
                long total = 0;
                var data = _tinTucBusiness.Search(page, pageSize, out total, tieude, noidung);
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
