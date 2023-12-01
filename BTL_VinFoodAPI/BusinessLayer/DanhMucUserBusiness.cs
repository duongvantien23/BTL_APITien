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
    public class DanhMucUserBusiness : IDanhMucUserBusiness
    {
        private IDanhMucUserRepository _res;
        public DanhMucUserBusiness(IDanhMucUserRepository res)
        {
            _res = res;
        }
        public List<DanhMucUserModel> GetAll()
        {
            return _res.GetAll();
        }
    }
}
