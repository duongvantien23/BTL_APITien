using BussinessLayer.Interface;
using DataAccessLayer.Interface;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BussinessLayer
{
    public class TinTucBusiness : ITinTucBusiness
    {
        private ITinTucRepository _res;
        public TinTucBusiness(ITinTucRepository res)
        {
            _res = res;
        }
        public List<TinTucModel> GetAllTinTuc()
        {
            return _res.GetAllTinTuc();
        }
        public List<TinTucModel> GetTinTucNews()
        {
            return _res.GetTinTucNews();
        }
    }
}
