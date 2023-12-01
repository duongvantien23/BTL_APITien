using DataModel;
using DataModel.UserModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer.Interface
{
    public partial interface ISanPhamUserRepository
    {
        List<SanPhamUserModel> GetAllSanPham();
        List<SanPhamUserModel> SearchTenSP(string TenSP);
        List<ThongKeSanPhamTopView> GetTopViewSanPham(int limit);
    }
}
