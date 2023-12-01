using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BussinessLayer.Interface
{
    public partial interface IUserBusiness
    {
        UserModel Login(string taikhoan, string matkhau);
        bool Create(UserRegister model);
    }
}
