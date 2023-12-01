using DataAccessLayer.Interface;
using DataModel;
using DataModel.UserModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class SanPhamUserRepository : ISanPhamUserRepository
    {
        private IDatabaseHelper _dbHelper;
        public SanPhamUserRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }
        public List<SanPhamUserModel> GetAllSanPham()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getall_sanpham");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<SanPhamUserModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public List<SanPhamUserModel> SearchTenSP(string TenSP)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_timkiem_sp_theoten",
                    "@TenSP", TenSP);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<SanPhamUserModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public List<ThongKeSanPhamTopView> GetTopViewSanPham(int limit)
        {
            string msgError = "";
            try
            {
                List<ThongKeSanPhamTopView> topViewSanPham = new List<ThongKeSanPhamTopView>();

                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_get_top_view_sanpham",
                    "@Limit", limit);
                if (!string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(msgError);
                }

                topViewSanPham = dt.ConvertTo<ThongKeSanPhamTopView>().ToList();

                return topViewSanPham;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}
