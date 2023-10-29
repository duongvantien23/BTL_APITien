using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BussinessLayer.Interface
{
    public partial interface IDanhMucBusiness
    {
        List<DanhMucModel> GetAll();
    }
}
