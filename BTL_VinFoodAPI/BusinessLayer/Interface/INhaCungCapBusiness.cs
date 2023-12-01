using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLayer.Interface
{
    public partial interface INhaCungCapBusiness
    {
        bool Create(NhaCungCapModel model);
        bool Update(NhaCungCapModel model);
        bool Delete(int id);
        NhaCungCapModel GetDatabyID(string id);
        List<NhaCungCapModel> GetDataAll();
    }
}
 