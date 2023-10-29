using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class SanPhamModel
    {
        public int MaSP { get; set; }
        public int MaDanhMuc { get; set; }
        public string TenDanhMuc { get; set; }
        public string TenSP { get; set; }
        public int MaNhaCC { get; set; }
        public int LuotXem { get; set; }
        public int Gia { get; set; }
        public string Mota { get; set; }
        public string HinhAnh { get; set; }
        public DateTime NgaySanXuat { get; set; }
    }
}
