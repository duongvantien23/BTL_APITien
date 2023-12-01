using BussinessLayer.Interface;
using DataModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace UserVinfood_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrderController : ControllerBase
    {
        private IOrderBusiness _orderBusiness;
        public OrderController(IOrderBusiness orderBusiness)
        {
            _orderBusiness = orderBusiness;
        }
        [HttpPost]
        [Route("CreateOrder")]
        public IActionResult Create(OrderModel model)
        {
            return Ok(_orderBusiness.Create(model));
        }


        [Route("/ptthanhtoan-donhang-get-all")]
        [HttpGet]
        public IEnumerable<PTThanhToan> GetAllMethod()
        {
            return _orderBusiness.GetAllMethod();
        }
        [Route("/get-all-donhang-user")]
        [HttpGet]
        public IEnumerable<DonHangAllUser> GetAllDonHang()
        {
            return _orderBusiness.GetAllDonHang();
        }
    }
}
