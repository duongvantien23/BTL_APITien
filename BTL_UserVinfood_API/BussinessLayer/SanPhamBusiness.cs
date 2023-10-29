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
    public class SanPhamBusiness : ISanPhamBusiness
    {
        private ISanPhamRepository _res;
        public SanPhamBusiness(ISanPhamRepository res)
        {
            _res = res;
        }
        public List<SanPhamModel> GetAllSanPham()
        {
            return _res.GetAllSanPham();
        }
        public List<SanPhamModel> SearchTenSP(string TenSP)
        {
            return _res.SearchTenSP(TenSP);
        }
        public List<SanPhamModel> GetTopViewSanPham(int limit)
        {
            return _res.GetTopViewSanPham(limit);
        }
    }
}
