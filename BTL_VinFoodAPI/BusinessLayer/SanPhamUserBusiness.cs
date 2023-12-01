using BusinessLayer.Interface;
using DataAccessLayer.Interface;
using DataModel;
using DataModel.UserModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLayer
{
    public class SanPhamUserBusiness : ISanPhamUserBusiness
    {
        private ISanPhamUserRepository _res;
        public SanPhamUserBusiness(ISanPhamUserRepository res)
        {
            _res = res;
        }
        public List<SanPhamUserModel> GetAllSanPham()
        {
            return _res.GetAllSanPham();
        }
        public List<SanPhamUserModel> SearchTenSP(string TenSP)
        {
            return _res.SearchTenSP(TenSP);
        }
        public List<ThongKeSanPhamTopView> GetTopViewSanPham(int limit)
        {
            return _res.GetTopViewSanPham(limit);
        }
    }
}
