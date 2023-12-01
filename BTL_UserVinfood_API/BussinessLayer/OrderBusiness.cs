using BussinessLayer.Interface;
using DataAccessLayer.Interface;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BussinessLayer
{
    public class OrderBusiness : IOrderBusiness
    {
        private IOrderRepository _res;
        public OrderBusiness(IOrderRepository res)
        {
            _res = res;
        }
        public bool Create(OrderModel model)
        {
            return _res.Create(model);
        }
        public List<PTThanhToan> GetAllMethod()
        {
            return _res.GetAllMethod();
        }
        public List<DonHangAllUser> GetAllDonHang()
        {
            return _res.GetAllDonHang();
        }
    }
}
