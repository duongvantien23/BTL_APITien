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
    public class NhaCungCapBusiness : INhaCungCapBusiness
    {
        private INhaCungCapRepository _res;
        public NhaCungCapBusiness(INhaCungCapRepository res)
        {
            _res = res;
        }
        public bool Create(NhaCungCapModel model)
        {
            return _res.Create(model);
        }
        public List<NhaCungCapModel> GetDataAll()
        {
            return _res.GetDataAll();
        }
        public NhaCungCapModel GetDatabyID(string id)
        {
            return _res.GetDatabyID(id);
        }
        public bool Update(NhaCungCapModel model)
        {
            return _res.Update(model);
        }
        public bool Delete(int id)
        {
            return _res.Delete(id);
        }

    }
}
