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
        public List<SanPhamModel> GetSanPhamNews()
        {
            return _res.GetSanPhamNews();
        }
        public List<SanPhamModel> GetSanPhamBestSale()
        {
            return _res.GetSanPhamBestSale();
        }
        public List<SanPhamModel> SearchTenSP(string TenSP)
        {
            return _res.SearchTenSP(TenSP);
        }
        public List<SanPhamModel> GetTopViewSanPham(int limit)
        {
            return _res.GetTopViewSanPham(limit);
        }
        public SanPhamModel GetDatabyID(string id)
        {
            return _res.GetDatabyID(id);
        }
        public List<SanPhamModel> GetAllSanPhamByDanhMuc(string maDanhMuc)
        {
            return _res.GetAllSanPhamByDanhMuc(maDanhMuc);
        }
        public List<SanPhamModel> GetSPDanhMucTraiCay()
        {
            return _res.GetSPDanhMucTraiCay();
        }
        public List<SanPhamModel> GetSanPhamAZ()
        {
            return _res.GetSanPhamAZ();
        }
        public List<SanPhamModel> GetSanPhamZA()
        {
            return _res.GetSanPhamZA();
        }
        public List<SanPhamModel> GetSanPhamPriceASC()
        {
            return _res.GetSanPhamPriceASC();
        }
        public List<SanPhamModel> GetSanPhamPriceDESC()
        {
            return _res.GetSanPhamPriceDESC();
        }
        public List<SanPhamModel> SearchSanPham(string TimKiem)
        {
            return _res.SearchSanPham(TimKiem);
        }
    }
}
