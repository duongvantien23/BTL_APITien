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
    public class TinTucBusiness : ITinTucBusiness
    {
        private ITinTucRepository _res;
        public TinTucBusiness(ITinTucRepository res)
        {
            _res = res;
        }
        public TinTucModel GetDatabyID(string id)
        {
            return _res.GetDatabyID(id);
        }

        public List<TinTucModel> GetDataAll()
        {
            return _res.GetDataAll();
        }

        public bool Create(TinTucModel model)
        {
            return _res.Create(model);
        }
        public bool Update(TinTucModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(int id)
        {
            return _res.Delete(id);
        }

        public List<TinTucModel> Search(int pageIndex, int pageSize, out long total, string tieude, string noidung)
        {
            return _res.Search(pageIndex, pageSize, out total, tieude, noidung);
        }

    }
}
