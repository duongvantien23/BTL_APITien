using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BussinessLayer.Interface
{
    public partial interface IOrderBusiness
    {
        bool Create(OrderModel model);
        List<PTThanhToan> GetAllMethod();
        List<DonHangAllUser> GetAllDonHang();
    }
}
