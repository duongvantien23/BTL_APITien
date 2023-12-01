using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class UserModel
    {
        public int MaNguoiDung { get; set; }
        public string TenDangNhap { get; set; }
        public string MatKhau { get; set; }
        public int VaiTro_Id { get; set; }
        public string Email { get; set; }
        public string token { get; set; }
    }
    public class UserRegister
    {
        public int MaNguoiDung { get; set; }
        public string TenDangNhap { get; set; }
        public string MatKhau { get; set; }
        public int VaiTro_Id { get; set; }
        public string Email { get; set; }
    }
}
