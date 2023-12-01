using BusinessLayer.Interface;
using DataAccessLayer.Interface;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLayer
{
    public class KhachHangBusiness : IKhachHangBusiness
    {
        private IKhachHangRepository _res;
        public KhachHangBusiness(IKhachHangRepository res)
        {
            _res = res;
        }
        public KhachHangModel GetDatabyID(string id)
        {
            return _res.GetDatabyID(id);
        }
        public List<KhachHangModel> GetDataAll()
        {
            return _res.GetDataAll();
        }
        public bool Create(KhachHangModel model)
        {
            return _res.Create(model);
        }

        public bool Update(KhachHangModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(int id)
        {
            return _res.Delete(id);
        }

        public List<KhachHangModel> Search(int pageIndex, int pageSize, out long total, string tenkh, string diachi)
        {
            return _res.Search(pageIndex, pageSize, out total, tenkh, diachi);
        }
    }
}
