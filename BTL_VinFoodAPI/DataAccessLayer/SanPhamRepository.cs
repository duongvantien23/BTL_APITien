using DataAccessLayer;
using DataAccessLayer.Interface;
using DataModel;
using Microsoft.Identity.Client;
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
        public bool Create(SanPhamModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_create_sanpham",
                "@MaDanhMuc", model.MaDanhMuc,
                "@TenSP", model.TenSP,
                "@MaNhaCC", model.MaNhaCC,
                "@LuotXem", model.LuotXem,
                "@Gia", model.Gia,
                "@MoTa", model.Mota,
                "@HinhAnh", model.HinhAnh,
                "@NgaySanXuat", model.NgaySanXuat,
                "@DonViTinh", model.DonViTinh);
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

        public bool Update(SanPhamModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_update_sanpham",
                "@MaSP", model.MaSP,
                "@MaDanhMuc", model.MaDanhMuc,
                "TenSP", model.TenSP,
                "@MaNhaCC", model.MaNhaCC,
                "@LuotXem", model.LuotXem,
                "@Gia", model.Gia,
                "@MoTa", model.Mota,
                "@HinhAnh", model.HinhAnh,
                "NgaySanXuat", model.NgaySanXuat,
                "@DonViTinh", model.DonViTinh);
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
        public SanPhamModel GetDatabyID(string id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_get_SanPhamByID",
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
        public List<SanPhamModel> GetDataAll()
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
        public List<Kho> GetLaySPSapHet()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_layrasanpham_saphet");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<Kho>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public List<SanPhamModel> GetSanPhamByPriceRange(int minPrice, int maxPrice)
        {
            try
            {
                // Tạo một danh sách để lưu trữ sản phẩm trong khoảng giá
                List<SanPhamModel> sanPhams = new List<SanPhamModel>();
                string msgError = ""; // Khai báo biến msgError

                // Gọi stored procedure để lấy dữ liệu từ cơ sở dữ liệu
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_get_sanpham_by_price_range",
                    "@MinPrice", minPrice,
                    "@MaxPrice", maxPrice);
                // Kiểm tra xem có lỗi không
                if (!string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(msgError);
                }

                // Chuyển đổi kết quả trả về thành danh sách sản phẩm
                sanPhams = dt.ConvertTo<SanPhamModel>().ToList();

                return sanPhams;
            }
            catch (Exception ex)
            {
                // Xử lý lỗi nếu có
                throw ex;
            }
        }
        public List<SanPhamModel> SearchSanPham(string TenSP)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError,"sp_timkiem_sp_theoten",
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
        public List<SanPhamModel> Search(int pageIndex, int pageSize, out long total, string TenSP, string TenDanhMuc, int Gia, string TenNhaCC)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_sanpham_search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@TenSP", TenSP,
                    "@TenDanhMuc", TenDanhMuc,
                    "@Gia", Gia,
                    "@TenNhaCC", TenNhaCC);
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
