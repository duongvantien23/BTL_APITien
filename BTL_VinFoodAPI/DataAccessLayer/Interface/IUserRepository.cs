using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer.Interface
{
    public partial interface IUserRepository
    {
        LoginRequestModel Login(string taikhoan, string matkhau);
        bool Create(LoginRequestModel model);
    }
}
