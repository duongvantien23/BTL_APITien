using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BussinessLayer.Interface
{
    public partial interface ISanPhamBusiness
    {
        List<SanPhamModel> GetAllSanPham();
        List<SanPhamModel> SearchTenSP(string TenSP);
        List<SanPhamModel> GetTopViewSanPham(int limit);
    }
}
