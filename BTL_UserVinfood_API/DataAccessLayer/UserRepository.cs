using DataAccessLayer.Interface;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class UserRepository : IUserRepository
    {
        private IDatabaseHelper _dbhp;
        public UserRepository(IDatabaseHelper dbhp)
        {
            _dbhp = dbhp;
        }
        public UserModel Login(string taikhoan, string matkhau)
        {
            string msgError = "";
            try
            {
                var dt = _dbhp.ExecuteSProcedureReturnDataTable(out msgError, "sp_login",
                     "@taikhoan", taikhoan,
                     "@matkhau", matkhau
                     );
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<UserModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public bool Create(UserRegister model)
        {
            string msgError = "";
            try
            {
                var result = _dbhp.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_create_account",
                "@tenDangNhap", model.TenDangNhap,
                "@matKhau", model.MatKhau,
                "@email", model.Email,
                "@vaiTroId", model.VaiTro_Id);
                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
