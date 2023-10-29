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
        List<DanhMucModel> GetAll();
    }
}
