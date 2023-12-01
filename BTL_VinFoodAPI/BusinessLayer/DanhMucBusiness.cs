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
    public class DanhMucBusiness : IDanhMucBusiness
    {
        private IDanhMucRepository _res;
        public DanhMucBusiness(IDanhMucRepository res)
        {
            _res = res;
        }
        public bool Create(DanhMucModel model)
        {
            return _res.Create(model);
        }

        public List<DanhMucModel> GetDataAll()
        {
            return _res.GetDataAll();
        }

        public DanhMucModel GetDatabyID(string id)
        {
            return _res.GetDatabyID(id);
        }

        public bool Update(DanhMucModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(int id)
        {
            return _res.Delete(id);
        }
    }
}
