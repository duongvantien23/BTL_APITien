using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer.Interface
{
   public partial interface IDanhMucRepository
    {
        bool Create(DanhMucModel model);
        bool Update(DanhMucModel model);
        bool Delete(int id);
        DanhMucModel GetDatabyID(string id);
        List<DanhMucModel> GetDataAll();
    }
}
