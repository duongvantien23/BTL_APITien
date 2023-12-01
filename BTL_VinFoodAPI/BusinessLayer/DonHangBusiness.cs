using BusinessLayer.Interface;
using DataAccessLayer.Interface;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLayer
{
    public class DonHangBusiness : IDonHangBusiness
    {
        private IDonHangRepository _res;
        public DonHangBusiness(IDonHangRepository res)
        {
            _res = res;
        }
        public DonHangALLModel GetDatabyID(string id)
        {
            return _res.GetDatabyID(id);
        }

        public List<DonHangModel> GetDataAll()
        {
            return _res.GetDataAll();
        }
        public List<TrangThaiDonHang> GetAllStatus()
        {
            return _res.GetAllStatus();
        }
        public List<PhuongThucThanhToan> GetAllMethod()
        {
            return _res.GetAllMethod();
        }
        public bool Create(DonHangModel model)
        {
            return _res.Create(model);
        }

        public bool Update(DonHangModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(int id)
        {
            return _res.Delete(id);
        }

        public List<DonHangModel> Search(int pageIndex, int pageSize, out long total, int maDonHang, int maKH, DateTime ngayDatHang, string phuongThucThanhToan, string tenTrangThai)
        {
            return _res.Search(pageIndex, pageSize, out total, maDonHang, maKH, ngayDatHang, phuongThucThanhToan, tenTrangThai);
        }
        public List<ThongKeDoanhThu> ThongKeDoanhThu(DateTime ngayBatDau, DateTime ngayKetThuc)
        {
            return _res.ThongKeDoanhThu(ngayBatDau, ngayKetThuc);
        }
        public List<DonHangTheoTrangThai> GetDonHangByTrangThai(int maTrangThai)
        {
            return _res.GetDonHangByTrangThai(maTrangThai);
        }
    }
}
