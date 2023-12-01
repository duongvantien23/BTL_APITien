using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLayer.Interface
{
    public partial interface IDanhMucBusiness
    {
        bool Create(DanhMucModel model);
        bool Update(DanhMucModel model);
        bool Delete(int id);
        DanhMucModel GetDatabyID(string id);
        List<DanhMucModel> GetDataAll();
    }
}
