
using DataAccessLayer.Interface;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class SanPhamRepository : ISanPhamRepository
    {
        private IDatabaseHelper _dbHelper;
        public SanPhamRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }
        public List<SanPhamModel> GetAllSanPham()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getall_sanpham");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<SanPhamModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public List<SanPhamModel> SearchTenSP(string TenSP)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_timkiem_sp_theoten",
                    "@TenSP", TenSP);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<SanPhamModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public List<SanPhamModel> GetTopViewSanPham(int limit)
        {
            string msgError = "";
            try
            {
                List<SanPhamModel> topViewSanPham = new List<SanPhamModel>();

                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_get_top_view_sanpham",
                    "@Limit", limit);
                if (!string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(msgError);
                }

                topViewSanPham = dt.ConvertTo<SanPhamModel>().ToList();

                return topViewSanPham;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}
