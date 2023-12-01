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
        List<SanPhamModel> GetSanPhamNews();
        List<SanPhamModel> GetSanPhamBestSale();
        SanPhamModel GetDatabyID(string id);
        List<SanPhamModel> GetAllSanPhamByDanhMuc(string maDanhMuc);
        List<SanPhamModel> GetSPDanhMucTraiCay();
        List<SanPhamModel> GetSanPhamAZ();
        List<SanPhamModel> GetSanPhamZA();
        List<SanPhamModel> GetSanPhamPriceASC();
        List<SanPhamModel> GetSanPhamPriceDESC();
        List<SanPhamModel> SearchSanPham(string TimKiem);
    }
}
