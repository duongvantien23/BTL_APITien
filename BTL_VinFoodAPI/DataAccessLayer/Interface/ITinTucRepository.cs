using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer.Interface
{
    public partial interface ITinTucRepository
    {
        bool Create(TinTucModel model);
        bool Update(TinTucModel model);
        bool Delete(int id);
        TinTucModel GetDatabyID(string id);
        List<TinTucModel> GetDataAll();
        List<TinTucModel> Search(int pageIndex, int pageSize, out long total, string tieude, string noidung);
    }
}
