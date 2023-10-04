using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLayer.Interfaces
{
    public partial interface ISanPhamBusinesss
    {
        SanPhamModel GetSanPhamByID(string id);
        List<SanPhamModel> GetAllSanPham();
        bool Create(SanPhamModel model);
        bool Update(SanPhamModel model);
        bool Delete(int id);
        public List<SanPhamModel> Search(int pageIndex, int pageSize, out long total, string TenSanPham);
    }
}
