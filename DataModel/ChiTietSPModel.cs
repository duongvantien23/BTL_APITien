using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class ChiTietSPModel
    {
        public int MaCTSP { get; set; }
        public int MaSP { get; set; }
        public int MaDanhMuc { get; set; }
        public string Mota { get; set; }
        public List<DanhMucModel> list_json_chitiet_danhmuc { get; set; }

    }
}
