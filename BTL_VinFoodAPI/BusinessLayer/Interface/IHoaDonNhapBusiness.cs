using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLayer.Interface
{
    public partial interface IHoaDonNhapBusiness
    {
        bool Create(HoaDonNhapModel model);
        bool Update(HoaDonNhapModel model);
        bool Delete(int id);
        HoaDonNhapAllModel GetDatabyID(string id);
        List<HoaDonNhapAllModel> GetDataAll();
    }
}
