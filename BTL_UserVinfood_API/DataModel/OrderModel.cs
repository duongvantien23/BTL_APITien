using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    //public class OrderModel
    //{
    //    public KhachHangModel khachhang { get; set; }
    //    public List<ChiTietDonHangModel> list_json_chitiet_dh { get; set; }
    //}
    public class OrderModel
    {
        public int MaKH { get; set; }
        public string TenKH { get; set; }
        public string SDT { get; set; }
        public string Email { get; set; }
        public string DiaChi { get; set; }
        public List<DonHang2> list_json_dh { get; set; }
        public List<ChiTietDonHangModel> list_json_chitiet_dh { get; set; }
    }
    public class KhachHangModel
    {
        public int MaKH { get; set; }
        public string TenKH { get; set; }
        public string SDT { get; set; }
        public string Email { get; set; }
        public string DiaChi { get; set; }
    }
    public class DonHang
    {
        public int MaKH { get; set; }
        public int MaPhuongThuc { get; set; }
        public int MaTrangThai { get; set; }
        public DateTime NgayDatHang { get; set; }
        public string TenPhuongThuc { get; set; }
        public string TenKH { get; set; }
        public string DiaChiGiaoHang { get; set; }
    }

    public class DonHang2
    {
        public int MaPhuongThuc { get; set; }
        public int MaTrangThai { get; set; }
        public DateTime NgayDatHang { get; set; }
        public string DiaChiGiaoHang { get; set; }
    }
    public class ChiTietDonHangModel
    {
        public int MaSP { get; set; }
        public int TongGia { get; set; }
        public int SoLuong { get; set; }
        public string MaGiamGia {  get; set; }
    }
    public class PTThanhToan
    {
        public int MaPhuongThuc { get; set; }
        public string TenPhuongThuc { get; set; }
    }
    public class DonHangAllUser
    {
        public int MaKH { get; set; }
        public string TenKH { get; set; }
        public string SDT { get; set; }
        public string Email { get; set; }
        public string DiaChi { get; set; }
        public int MaDonHang {  get; set; }
        public int MaPhuongThuc { get; set; }
        public int MaTrangThai { get; set; }
        public DateTime NgayDatHang { get; set; }
        public string TenPhuongThuc { get; set; }
        public string DiaChiGiaoHang { get; set; }
        public int MaSP { get; set; }
        public string TenSP { get; set; }
        public int TongGia { get; set; }
        public int SoLuong { get; set; }
        public string MaGiamGia { get; set; }

    }
}
 
