using DataAccessLayer.Interface;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class DonHangRepository : IDonHangRepository
    {
        private IDatabaseHelper _dbHelper;
        public DonHangRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }
        public bool Create(DonHangModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_create_donhang",
                    "@MaKH", model.MaKH,
                    "@MaTrangThai", model.MaTrangThai,
                    "@MaPhuongThuc", model.MaPhuongThuc,
                    "@NgayDatHang", model.NgayDatHang,
                    "@DiaChiGiaoHang", model.DiaChiGiaoHang,
                    "@list_json_chitiet_dh", model.list_json_chitiet_dh != null ? MessageConvert.SerializeObject(model.list_json_chitiet_dh) : null);

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
        public bool Update(DonHangModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_update_donhang",
                "@MaDonHang", model.MaDonHang,
                "@MaKH", model.MaKH,
                "@MaTrangThai", model.MaTrangThai,  
                "@MaPhuongThuc", model.MaPhuongThuc,  
                "@NgayDatHang", model.NgayDatHang,
                "@DiaChiGiaoHang", model.DiaChiGiaoHang,
                "@list_json_chitiet_dh", model.list_json_chitiet_dh != null ? MessageConvert.SerializeObject(model.list_json_chitiet_dh) : null);

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
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_delete_donhang"
                    , "@MaDonHang", id);
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

        public DonHangALLModel GetDatabyID(string id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "GetDonHangByID",
              "@MaDonHang", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<DonHangALLModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<DonHangModel> GetDataAll()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getall_donhang");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<DonHangModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public List<DonHangModel> Search(int pageIndex, int pageSize, out long total, int maDonHang, int maKH, DateTime ngayDatHang, string phuongThucThanhToan, string tenTrangThai)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_search_donhang",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@MaDonHang", maDonHang,
                    "@MaKH", maKH,
                    "@NgayDatHang", ngayDatHang,
                    "@PhuongThucThanhToan", phuongThucThanhToan,
                    "@TenTrangThai", tenTrangThai);

                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);

                if (dt.Rows.Count > 0)
                {
                    total = (long)dt.Rows[0]["RecordCount"];
                    return dt.ConvertTo<DonHangModel>().ToList();
                }
                else
                {
                    return new List<DonHangModel>();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public List<TrangThaiDonHang> GetAllStatus()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getall_trangthai_donhang");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<TrangThaiDonHang>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public List<PhuongThucThanhToan> GetAllMethod()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getall_ptthanhtoan_donhang");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<PhuongThucThanhToan>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public List<ThongKeDoanhThu> ThongKeDoanhThu(DateTime ngayBatDau, DateTime ngayKetThuc)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "ThongKeDoanhThu",
                    "@NgayBatDau", ngayBatDau,
                    "@NgayKetThuc", ngayKetThuc);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);

                return dt.ConvertTo<ThongKeDoanhThu>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public List<DonHangTheoTrangThai> GetDonHangByTrangThai(int trangThai)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "GetDonHangByTrangThai",
                    "@TrangThai", trangThai);

                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);

                return dt.ConvertTo<DonHangTheoTrangThai>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}
