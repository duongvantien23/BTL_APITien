using DataAccessLayer.Interfaces;
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
        public SanPhamModel GetSanPhamByID(string id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_get_SanPham_ByID",
                     "@MaSanPham", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<SanPhamModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public List<SanPhamModel>GetAllSanPham()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getallsanpham");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<SanPhamModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public bool Create(SanPhamModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_create_sanpham",
                    "@MaNhaCC", model.MaNhaCC,
                    "@LuotXem", model.LuotXem,
                    "@Gia", model.Gia,
                    "@HinhAnh", model.HinhAnh,
                    "@NgaySanXuat", model.NgaySanXuat,
                    "@TenSP", model.TenSP
                );
                if (result != null && result.ToString() != "0")
                {
                    throw new Exception("Tạo sản phẩm không thành công");
                }

                foreach (var chiTiet in model.list_json_chitiet_sp)
                {
                    var chiTietResult = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_create_chitietsanpham",
                        "@MaSP", model.MaSP,
                        "@MaDanhMuc", chiTiet.MaDanhMuc,
                        "@Mota", chiTiet.Mota
                    );

                    if (chiTietResult != null && chiTietResult.ToString() != "0")
                    {
                        throw new Exception("Tạo chi tiết sản phẩm không thành công");
                    }
                }

                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public bool Update(SanPhamModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_update_sanpham",
                    "@MaSP", model.MaSP,
                    "@MaNhaCC", model.MaNhaCC,
                    "@LuotXem", model.LuotXem,
                    "@Gia", model.Gia,
                    "@HinhAnh", model.HinhAnh,
                    "@NgaySanXuat", model.NgaySanXuat,
                    "@TenSP", model.TenSP
                );
                if (result != null && result.ToString() != "0")
                {
                    throw new Exception("Cập nhật sản phẩm không thành công");
                }

                // Xóa toàn bộ chi tiết sản phẩm cũ của sản phẩm
                var deleteChiTietResult = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_delete_all_chitietsanpham",
                    "@MaSP", model.MaSP
                );
                if (deleteChiTietResult != null && deleteChiTietResult.ToString() != "0")
                {
                    throw new Exception("Xóa chi tiết sản phẩm cũ không thành công");
                }
                foreach (var chiTiet in model.list_json_chitiet_sp)
                {
                    var chiTietResult = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_create_chitietsanpham",
                        "@MaSP", model.MaSP,
                        "@MaDanhMuc", chiTiet.MaDanhMuc,
                        "@Mota", chiTiet.Mota
                    );

                    if (chiTietResult != null && chiTietResult.ToString() != "0")
                    {
                        throw new Exception("Tạo chi tiết sản phẩm không thành công");
                    }
                }

                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public bool Delete(int id)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_delete_sanpham"
                    , "@MaSanPham", id);
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
        public List<SanPhamModel> Search(int pageIndex, int pageSize, out long total, string TenSanPham)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_sanpham_search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@TenSanPham", TenSanPham);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<SanPhamModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
