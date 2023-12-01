using BusinessLayer.Interface;
using DataAccessLayer;
using DataAccessLayer.Interface;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLayer
{
    public class SanPhamBusiness : ISanPhamBusiness
    {
        private ISanPhamRepository _res;
        public SanPhamBusiness(ISanPhamRepository res)
        {
            _res = res;
        }
        public bool Create(SanPhamModel model)
        {
            return _res.Create(model);
        }
        public List<SanPhamModel> GetDataAll()
        {
            return _res.GetDataAll();
        }
        public List<Kho> GetLaySPSapHet()
        {
            return _res.GetLaySPSapHet();
        }
        public SanPhamModel GetDatabyID(string id)
        {
            return _res.GetDatabyID(id);
        }
        public bool Update(SanPhamModel model)
        {
            return _res.Update(model);
        }
        public bool Delete(int id)
        {
            return _res.Delete(id);
        }
        public List<SanPhamModel> GetSanPhamByPriceRange(int min, int max)
        {
            // Triển khai logic lấy sản phẩm theo khoảng giá ở đây
            return _res.GetSanPhamByPriceRange(min, max);
        }
        public List<SanPhamModel> SearchSanPham(string TenSP)
        {
            return _res.SearchSanPham(TenSP);
        }
        public List<ThongKeSanPhamTopView> GetTopViewSanPham(int limit)
        {
            return _res.GetTopViewSanPham(limit);
        }
        public List<SanPhamModel> Search(int pageIndex, int pageSize, out long total, string TenSP, string TenDanhMuc, int Gia, string TenNhaCC)
        {
            return _res.Search(pageIndex, pageSize, out total, TenSP, TenDanhMuc, Gia, TenNhaCC);
        }
    }
}

