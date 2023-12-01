using DataAccessLayer.Interface;
using DataModel;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class OrderRepository : IOrderRepository
    {
        private IDatabaseHelper _dbHelper;
        public OrderRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }
        //public bool CreateOrder(OrderModel order)
        //{
        //    // Kiểm tra xem order và các thông tin cần thiết có hợp lệ không
        //    if (order == null || order.khachhang == null || order.list_json_chitiet_dh == null || !order.list_json_chitiet_dh.Any())
        //    {
        //        return false;
        //    }

        //    try
        //    {
        //        // Tạo danh sách chi tiết đơn hàng
        //        var orderDetailsList = order.list_json_chitiet_dh.Select(x => new
        //        {
        //            ProductID = x.MaSP,
        //            Quantity = x.SoLuong,
        //            Price = x.TongGia
        //        }).ToList();

        //        // Chuyển danh sách chi tiết đơn hàng thành chuỗi JSON
        //        var orderDetailsJson = JsonConvert.SerializeObject(orderDetailsList);

        //        // Khai báo biến lưu thông báo lỗi
        //        string errorMsg = "";

        //        // Thực hiện thêm đơn hàng bằng stored procedure
        //        var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out errorMsg, "sp_AddOrder",
        //            "@TenKH", order.khachhang.TenKH,
        //            "@SDT", order.khachhang.SDT,
        //            "@DiaChi", order.khachhang.DiaChi,
        //            "@Email", order.khachhang.Email,
        //            "@OrderDetailsList", orderDetailsJson
        //        );

        //        if (result != null && !string.IsNullOrEmpty(result.ToString()))
        //        {
        //            throw new Exception(Convert.ToString(result));
        //        }
        //        else if (!string.IsNullOrEmpty(errorMsg))
        //        {
        //            throw new Exception(errorMsg);
        //        }

        //        return true;
        //    }
        //    catch (Exception ex)
        //    {
        //        return false;
        //    }
        //}
        public bool Create(OrderModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_create_order",
                    "@TenKH", model.TenKH,
                    "@SDT", model.SDT,
                    "@Email", model.Email,
                    "@DiaChi", model.DiaChi,
                    "@list_json_dh", model.list_json_dh != null ? MessageConvert.SerializeObject(model.list_json_dh) : null,
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
        public List<PTThanhToan> GetAllMethod()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getall_ptthanhtoan_donhang");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<PTThanhToan>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public List<DonHangAllUser> GetAllDonHang()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getall_donhang_user");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<DonHangAllUser>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
