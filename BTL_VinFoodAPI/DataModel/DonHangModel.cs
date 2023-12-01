using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class DonHangModel
    {
        public int MaDonHang { get; set; }
        public int MaKH { get; set; }
        public int MaTrangThai { get; set; }
        public int MaPhuongThuc { get; set; }
        public DateTime NgayDatHang { get; set; }
        public string TenPhuongThuc { get; set; }
        public string TenKH { get; set; }
        public string TenTrangThai { get; set; }
        public string DiaChiGiaoHang { get; set; }
        public List<ChiTietDonHangModel> list_json_chitiet_dh { get; set; }
    }
    public class DonHangALLModel
    {
        public int MaDonHang { get; set; }
        public int MaKH { get; set; }
        public int MaTrangThai { get; set; }
        public int MaPhuongThuc { get; set; }
        public DateTime NgayDatHang { get; set; }
        public int SoLuong { get; set; }
        public string TenPhuongThuc { get; set; }
        public string TenKH { get; set; }
        public string TenTrangThai { get; set; }
        public string DiaChiGiaoHang { get; set; }
        public int MaCTDH { get; set; }
        public int MaSP { get; set; }
        public int TongGia { get; set; }
        public string MaGiamGia { get; set; }

    }

    public class TrangThaiDonHang
    {
        public int MaTrangThai { get; set; }
        public string TenTrangThai { get; set; }
    }
    public class PhuongThucThanhToan
    {
        public int MaPhuongThuc { get; set; }
        public string TenPhuongThuc { get; set; }
    }
    public class ThongKeDoanhThu
    {
        public int SoDonHang { get; set; }
        public int DoanhThu { get; set; }
    }
    public class DonHangTheoTrangThai
    {
        public int MaDonHang { get; set; }
        public int MaKH { get; set; }
        public int MaTrangThai { get; set; }
        public int MaPhuongThuc { get; set; }
        public DateTime NgayDatHang { get; set; }
        public int SoLuong { get; set; }
        public string TenPhuongThuc { get; set; }
        public string TenKH { get; set; }
        public string TenTrangThai { get; set; }
        public string DiaChiGiaoHang { get; set; }
        public int MaSP { get; set; }
        public int TongGia { get; set; }
    }
}
