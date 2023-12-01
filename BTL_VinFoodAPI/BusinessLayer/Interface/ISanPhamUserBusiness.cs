﻿using DataModel;
using DataModel.UserModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLayer.Interface
{
    public partial interface ISanPhamUserBusiness
    {
        List<SanPhamUserModel> GetAllSanPham();
        List<SanPhamUserModel> SearchTenSP(string TenSP);
        List<ThongKeSanPhamTopView> GetTopViewSanPham(int limit);
    }
}
