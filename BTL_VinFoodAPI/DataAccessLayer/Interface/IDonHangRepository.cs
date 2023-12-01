using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer.Interface
{
    public partial interface IDonHangRepository
    {
        bool Create(DonHangModel model);
        bool Update(DonHangModel model);
        bool Delete(int id);
        DonHangALLModel GetDatabyID(string id);
        List<DonHangModel> GetDataAll();
        List<TrangThaiDonHang> GetAllStatus();
        List<PhuongThucThanhToan> GetAllMethod();
        List<DonHangModel> Search(int pageIndex, int pageSize, out long total, int maDonHang, int maKH, DateTime ngayDatHang, string phuongThucThanhToan, string tenTrangThai);
        List<ThongKeDoanhThu> ThongKeDoanhThu(DateTime ngayBatDau, DateTime ngayKetThuc);
        List<DonHangTheoTrangThai> GetDonHangByTrangThai(int maTrangThai);
    }
}
