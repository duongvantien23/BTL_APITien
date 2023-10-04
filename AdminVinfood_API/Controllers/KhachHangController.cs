using BusinessLayer.Interfaces;
using DataModel;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace AdminVinfood_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class KhachHangController : ControllerBase
    {
        private IKhachHangBusiness _khachBusiness;
        private string _path;
        private IWebHostEnvironment _env;
        public KhachHangController(IKhachHangBusiness khachBusiness, IConfiguration configuration, IWebHostEnvironment env)
        {
            _khachBusiness = khachBusiness;
            _path = configuration["AppSettings:PATH"];
            _env = env;
        }
        [NonAction]
        public string CreatePathFile(string RelativePathFileName)
        {
            try
            {
                string serverRootPathFolder = _path;
                string fullPathFile = $@"{serverRootPathFolder}\{RelativePathFileName}";
                string fullPathFolder = System.IO.Path.GetDirectoryName(fullPathFile);
                if (!Directory.Exists(fullPathFolder))
                    Directory.CreateDirectory(fullPathFolder);
                return fullPathFile;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }

        [Route("upload")]
        [HttpPost, DisableRequestSizeLimit]
        public async Task<IActionResult> Upload(IFormFile file)
        {
            try
            {
                if (file.Length > 0)
                {
                    string filePath = $"upload/{file.FileName}";
                    var fullPath = CreatePathFile(filePath);
                    using (var fileStream = new FileStream(fullPath, FileMode.Create))
                    {
                        await file.CopyToAsync(fileStream);
                    }
                    return Ok(new { filePath });
                }
                else
                {
                    return BadRequest();
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Không tìm thây");
            }
        }

        [Route("download")]
        [HttpPost]
        public IActionResult DownloadData([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var webRoot = _env.ContentRootPath;
                string exportPath = Path.Combine(webRoot + @"\Export\DM.xlsx");
                var stream = new FileStream(exportPath, FileMode.Open, FileAccess.Read);
                return File(stream, "application/octet-stream");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [AllowAnonymous]
        [Route("get-by-id/{id}")]
        [HttpGet]
        public KhachHangModel GetDatabyID(string id)
        {
            return _khachBusiness.GetDatabyID(id);
        }
        [Route("get-all-khachhang")]
        [HttpGet]
        public IEnumerable<KhachHangModel> GetAllKhachHang()
        {
            return _khachBusiness.GetDataAll();
        }
        [Route("/create-khachhang")]
        [HttpPost]
        public KhachHangModel CreateKhachHang([FromBody] KhachHangModel model)
        {
            _khachBusiness.Create(model);
            return model;
        }

        [Route("/update-khachhang")]
        [HttpPut]
        public KhachHangModel UpdateKhachHang([FromBody] KhachHangModel model)
        {
            _khachBusiness.Update(model);
            return model;
        }

        [Route("/delete-khachhang")]
        [HttpDelete]
        public IActionResult DeleteKhachHang([FromBody] int id)
        {
            _khachBusiness.Delete(id);
            return Ok();
        }

        [Route("search-khach-hang")]
        [HttpPost]
        public IActionResult Search([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                string tenkh = "";
                if (formData.Keys.Contains("tenkh") && !string.IsNullOrEmpty(Convert.ToString(formData["tenkh"]))) { tenkh = Convert.ToString(formData["tenkh"]); }
                string diachi = "";
                if (formData.Keys.Contains("diachi") && !string.IsNullOrEmpty(Convert.ToString(formData["diachi"]))) { diachi = Convert.ToString(formData["diachi"]); }
                long total = 0;
                var data = _khachBusiness.Search(page, pageSize, out total, tenkh, diachi);
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
