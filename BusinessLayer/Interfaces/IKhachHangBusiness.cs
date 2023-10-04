using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLayer.Interfaces
{
    public partial interface IKhachHangBusiness
    {
        bool Create(KhachHangModel khachHang);

        bool Update(KhachHangModel khachHang);
        bool Delete(int id);
        KhachHangModel GetDatabyID(string id);
        List<KhachHangModel> GetDataAll();

        List<KhachHangModel> Search(int pageIndex, int pageSize, out long total, string tenkh, string diachi);
    }
}
