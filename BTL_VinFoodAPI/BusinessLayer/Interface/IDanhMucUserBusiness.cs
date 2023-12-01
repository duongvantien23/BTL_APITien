using DataModel;
using DataModel.UserModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLayer.Interface
{
    public partial interface IDanhMucUserBusiness
    {
        List<DanhMucUserModel> GetAll();
    }
}
