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
    public class TinTucUserRepository : ITinTucUserRepository
    {
        private IDatabaseHelper _dbHelper;
        public TinTucUserRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }
        public List<TinTucUserModel> GetAllTinTuc()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getall_tintuc");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<TinTucUserModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
