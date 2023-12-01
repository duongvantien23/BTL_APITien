using BusinessLayer.Interface;
using DataAccessLayer.Interface;
using DataModel;
using DataModel.UserModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLayer
{
    public class TinTucUserBusiness : ITinTucUserBusiness
    {
        private ITinTucUserRepository _res;
        public TinTucUserBusiness(ITinTucUserRepository res)
        {
            _res = res;
        }
        public List<TinTucUserModel> GetAllTinTuc()
        {
            return _res.GetAllTinTuc();
        }
    }
}
