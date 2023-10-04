using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class DonHangModelcs
    {
        public int MaDonHang { get; set; }
        public int MaKH { get; set; }
        public DateTime NgayDatHang { get; set; }
        public string PhuongThucThanhToan { get; set; }
        public int MaTrangThai { get; set; }
        public List<ChiTietDonHangModel> list_json_chitiet_dh { get; set; }
    }
}
