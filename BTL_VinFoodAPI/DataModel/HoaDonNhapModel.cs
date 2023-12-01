using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class HoaDonNhapModel
    {
        public int MaHDNhap { get; set; }
        public int MaNhaCC { get; set; }
        public DateTime NgayNhap { get; set; }
        public string GhiChu { get; set; }
        public string TenNhaCC {  get; set; }
        public List<ChiTietHoaDonNhapModel> list_json_chitiet_hdn { get; set; }
    }
    public class HoaDonNhapAllModel
    {
        public int MaHDNhap { get; set; }
        public int MaNhaCC { get; set; }
        public string TenNhaCC { get; set; }
        public string TenSP { get; set; }
        public DateTime NgayNhap { get; set; }
        public string GhiChu { get; set; }
        public int MaCTHDNhap { get; set; }
        public int MaSP { get; set; }
        public int SoLuong { get; set; }
        public int DonGia { get; set; }
        public int TongTien { get; set; }
    }
}
