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
        bool Create(SanPhamModel model);

        bool Update(SanPhamModel model);
        bool Delete(int id);
        SanPhamModel GetDatabyID(string id);
        List<SanPhamModel> GetDataAll();
        List<Kho> GetLaySPSapHet();
        List<SanPhamModel> GetSanPhamByPriceRange(int min, int max);
        List<SanPhamModel> SearchSanPham(string TenSP);
        List<ThongKeSanPhamTopView> GetTopViewSanPham(int limit);
        List<SanPhamModel> Search(int pageIndex, int pageSize, out long total, string TenSP, string TenDanhMuc, int Gia, string TenNhaCC);
    }
}
