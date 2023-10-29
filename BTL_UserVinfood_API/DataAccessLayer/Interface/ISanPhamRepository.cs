using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer.Interface
{
    public partial interface ISanPhamRepository
    {
        List<SanPhamModel> GetAllSanPham();
        List<SanPhamModel> SearchTenSP(string TenSP);
        List<SanPhamModel> GetTopViewSanPham(int limit);
    }
}
