--STORE PROC
use BTL_BanHangTP_DVT
---Bảng User Login
CREATE PROCEDURE sp_login
    @taikhoan NVARCHAR(100),
    @matkhau NVARCHAR(30)
AS
BEGIN
    SET NOCOUNT ON;

    -- Tìm người dùng dựa trên tên đăng nhập và mật khẩu
    SELECT
        MaNguoiDung,
        TenDangNhap,
        MatKhau,
        VaiTro_Id,
        Email
    FROM
        NguoiDungs
    WHERE
        TenDangNhap = @taikhoan
        AND MatKhau = @matkhau;
END
--Bảng Khách Hàng
-- Tạo stored procedure để tạo mới khách hàng
CREATE PROCEDURE sp_create_khachhang
(
    @TenKH NVARCHAR(100),
    @SDT NVARCHAR(12),
    @Email NVARCHAR(100),
    @DiaChi NVARCHAR(200)
)
AS
BEGIN
    INSERT INTO KhachHangs (TenKH, DiaChi, SDT, Email)
    VALUES (@TenKH, @DiaChi, @SDT, @Email);
END;
-- Tạo stored procedure để lấy ra từng khách hàng
CREATE PROCEDURE GetKhachHangByID
(
    @MaKH INT
)
AS
BEGIN
    SELECT *
    FROM KhachHangs
    WHERE MaKH = @MaKH;
END;
-- Tạo stored procedure để cập nhật thông tin khách hàng
CREATE PROCEDURE sp_update_KhachHang
(
    @MaKH INT,
    @TenKH NVARCHAR(100),
    @SDT NVARCHAR(12),
    @Email NVARCHAR(100),
    @DiaChi NVARCHAR(200)
)
AS
BEGIN
    UPDATE KhachHangs
    SET TenKH = @TenKH,
        SDT = @SDT,
        Email = @Email,
        DiaChi = @DiaChi
    WHERE MaKH = @MaKH;
END;
-- Tạo stored procedure xóa thông tin khách hàng
create proc sp_delete_khachhang(@Id int)
as
begin
	delete from KhachHangs where MaKH = @Id
end
-- Tạo stored procedure lấy ra tất cả khách hàng
create proc sp_getall_khachhang
as
begin
	select*from KhachHangs
end
-- Tạo stored procedure tìm kiếm khách hàng
CREATE PROCEDURE sp_search_khach_hang
(
    @page_index INT,
    @page_size INT,
    @TenKH NVARCHAR(50),
    @DiaChi NVARCHAR(250)
)
AS
BEGIN
    DECLARE @RecordCount INT;

    IF (@page_size <> 0)
    BEGIN
        SET NOCOUNT ON;

        SELECT ROW_NUMBER() OVER (ORDER BY TenKH ASC) AS RowNumber,
               K.MaKH,
               K.TenKH,
               K.DiaChi
        INTO #Results1
        FROM KhachHangs AS K
        WHERE (@TenKH = '' OR K.TenKH LIKE N'%' + @TenKH + '%')
          AND (@DiaChi = '' OR K.DiaChi LIKE N'%' + @DiaChi + '%');

        SELECT @RecordCount = COUNT(*)
        FROM #Results1;

        SELECT *,
               @RecordCount AS RecordCount
        FROM #Results1
        WHERE RowNumber BETWEEN (@page_index - 1) * @page_size + 1 AND ((@page_index - 1) * @page_size + 1) + @page_size - 1
            OR @page_index = -1;

        DROP TABLE #Results1;
    END;
    ELSE
    BEGIN
        SET NOCOUNT ON;

        SELECT ROW_NUMBER() OVER (ORDER BY TenKH ASC) AS RowNumber,
               K.MaKH,
               K.TenKH,
               K.DiaChi
        INTO #Results2
        FROM KhachHangs AS K
        WHERE (@TenKH = '' OR K.TenKH LIKE N'%' + @TenKH + '%')
          AND (@DiaChi = '' OR K.DiaChi LIKE N'%' + @DiaChi + '%');

        SELECT @RecordCount = COUNT(*)
        FROM #Results2;

        SELECT *,
               @RecordCount AS RecordCount
        FROM #Results2;

        DROP TABLE #Results2;
    END;
END;
------------------------------------------------------------------------------------------------
--Store Proc Sản Phẩm
Alter PROCEDURE sp_create_sanpham
    @MaDanhMuc INT,
    @TenSP NVARCHAR(500),
    @MaNhaCC INT,
    @LuotXem INT,
    @Gia INT,
    @MoTa NVARCHAR(MAX),
    @HinhAnh NVARCHAR(MAX),
    @NgaySanXuat DATETIME,
	@DonViTinh NVARCHAR(100)
AS
BEGIN
    INSERT INTO SanPhams (MaDanhMuc, TenSP, MaNhaCC, LuotXem, Gia, Mota, HinhAnh, NgaySanXuat,DonViTinh)
    VALUES (@MaDanhMuc, @TenSP, @MaNhaCC, @LuotXem, @Gia, @MoTa, @HinhAnh, @NgaySanXuat,@DonViTinh);
END
--Get Id Sản Phẩm
Alter PROCEDURE sp_get_SanPhamByID
(
    @MaSanPham INT
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        S.MaSP,
        S.MaDanhMuc,
        DM.TenDanhMuc, -- Tên danh mục
        S.MaNhaCC,
        NCC.TenNhaCC, -- Tên nhà cung cấp
        S.TenSP,
		S.LuotXem,
        S.Gia,
        S.Mota,
		S.DonViTinh,
        S.HinhAnh,
        S.NgaySanXuat
    FROM SanPhams AS S
    INNER JOIN DanhMucs AS DM ON S.MaDanhMuc = DM.MaDanhMuc
    INNER JOIN NhaCungCaps AS NCC ON S.MaNhaCC = NCC.MaNhaCC
    WHERE S.MaSP = @MaSanPham;
END;
--Get All Sản Phẩm
Alter PROCEDURE sp_getall_sanpham
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        SP.MaSP,
        SP.MaDanhMuc,
        DM.TenDanhMuc,
        SP.TenSP,
        SP.MaNhaCC,
        SP.LuotXem,
        SP.Gia,
        SP.Mota,
        SP.HinhAnh,
        SP.NgaySanXuat,
		SP.DonViTinh
    FROM SanPhams SP
    JOIN DanhMucs DM ON SP.MaDanhMuc = DM.MaDanhMuc;
END;
--Update Sản Phẩm
Alter PROCEDURE sp_update_sanpham
    @MaSP INT,
    @MaDanhMuc INT,
    @TenSP NVARCHAR(500),
    @MaNhaCC INT,
    @LuotXem INT,
    @Gia INT,
    @MoTa NVARCHAR(MAX),
    @HinhAnh NVARCHAR(MAX),
    @NgaySanXuat DATETIME,
	@DonViTinh NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    -- Cập nhật thông tin sản phẩm trong bảng SanPhams
    UPDATE SanPhams
    SET
        MaDanhMuc = @MaDanhMuc,
        TenSP = @TenSP,
        MaNhaCC = @MaNhaCC,
        LuotXem = @LuotXem,
        Gia = @Gia,
        Mota = @MoTa,
        HinhAnh = @HinhAnh,
        NgaySanXuat = @NgaySanXuat,
		DonViTinh = @DonViTinh
    WHERE MaSP = @MaSP;
END;
--Xóa Sản Phẩm
CREATE PROCEDURE sp_delete_sanpham
(
    @MaSanPham INT
)
AS
BEGIN
    SET NOCOUNT ON;

    -- Xóa sản phẩm trong bảng SanPhams
    DELETE FROM SanPhams
    WHERE MaSP = @MaSanPham;
END;
------------------------------------------
go

CREATE PROCEDURE sp_timkiem_sp_theoten
    @TenSP NVARCHAR(500)
AS
BEGIN
    SELECT *
    FROM SanPhams
    WHERE TenSP LIKE '%' + @TenSP + '%'
END
---------------------------------------------
--lấy ra sản phẩm có nhiều lượt xem nhất
Alter PROCEDURE sp_get_top_view_sanpham
    @Limit INT
AS
BEGIN
    SELECT TOP(@Limit)
        sp.MaSP,
        sp.TenSP,
        sp.LuotXem,
        sp.Gia,
        sp.Mota,
        sp.HinhAnh,
		sp.DonViTinh
    FROM
        SanPhams sp
    ORDER BY
        sp.LuotXem DESC;
END;
-- Tạo stored procedure để lấy danh sách sản phẩm mới về
CREATE PROCEDURE sp_get_sanpham_moi_ve
AS
BEGIN
    SELECT TOP 10 * FROM SanPhams
    WHERE NgaySanXuat >= DATEADD(day, -7, GETDATE())
    ORDER BY NgaySanXuat DESC;
END
---------------------------------------------------------
ALTER PROCEDURE GetNewProducts
AS
BEGIN
    SELECT TOP 4
        sp.MaSP,
        sp.TenSP,
		sp.HinhAnh,
		sp.Gia,
        sp.NgaySanXuat,
		sp.DonViTinh
    FROM SanPhams sp
    WHERE sp.NgaySanXuat = (SELECT MAX(NgaySanXuat) FROM SanPhams)
    ORDER BY sp.NgaySanXuat DESC;
END
EXEC GetNewProducts;
------------------------------------------------------------
ALTER PROCEDURE sp_SanPhamBestSale
AS
BEGIN
    SELECT TOP 4
        SP.MaSP,
        SP.TenSP,
        SP.Gia AS Gia,
        SP.HinhAnh AS HinhAnh,
        SP.DonViTinh AS DonViTinh,
        SUM(CTDH.SoLuong) AS SoLuong -- Thêm cột SoLuong từ bảng ChiTietDonHangs
    FROM SanPhams AS SP
    INNER JOIN ChiTietDonHangs AS CTDH ON SP.MaSP = CTDH.MaSP
    INNER JOIN DonHangs AS DH ON CTDH.MaDonHang = DH.MaDonHang
    GROUP BY SP.MaSP, SP.TenSP, SP.Gia, SP.HinhAnh, SP.DonViTinh
    ORDER BY SUM(CTDH.SoLuong) DESC; -- Cập nhật SUM(CTDH.SoLuong) để tính tổng số lượng từ bảng ChiTietDonHangs
END;
EXEC sp_SanPhamBestSale;
-- Thủ tục sửa lỗi
CREATE PROCEDURE sp_sanpham_search
    @page_index INT,
    @page_size INT,
    @TenSP NVARCHAR(150),
    @TenDanhMuc NVARCHAR(50),
    @Gia INT,
    @TenNhaCC NVARCHAR(250)
AS
BEGIN
    DECLARE @RecordCount BIGINT;
    IF @page_size <> 0
    BEGIN
        SET NOCOUNT ON;

        SELECT
            (ROW_NUMBER() OVER (ORDER BY s.MaSP ASC)) AS RowNumber,
            s.MaSP,
            dm.MaDanhMuc,
            dm.TenDanhMuc,
            s.TenSP,
            s.HinhAnh,
            s.Gia,
            s.LuotXem,
            ncc.MaNhaCC,
            ncc.TenNhaCC,
            s.MoTa  -- Thêm cột MoTa từ bảng SanPhams
        INTO #Temp1
        FROM SanPhams AS s
        INNER JOIN NhaCungCaps ncc ON ncc.MaNhaCC = s.MaNhaCC
        INNER JOIN DanhMucs dm ON dm.MaDanhMuc = s.MaDanhMuc
        WHERE (@TenSP = '' OR s.TenSP LIKE '%' + @TenSP + '%')
            AND (@TenDanhMuc = '' OR dm.TenDanhMuc LIKE '%' + @TenDanhMuc + '%')
            AND (@Gia = 0 OR s.Gia = @Gia)
            AND (@TenNhaCC = '' OR ncc.TenNhaCC LIKE '%' + @TenNhaCC + '%');

        SELECT @RecordCount = COUNT(*)
        FROM #Temp1;

        SELECT *,
               @RecordCount AS RecordCount
        FROM #Temp1
        WHERE RowNumber BETWEEN (@page_index - 1) * @page_size + 1 AND ((@page_index - 1) * @page_size + 1) + @page_size - 1
              OR @page_index = -1;

        DROP TABLE #Temp1;
    END
    ELSE
    BEGIN
        SET NOCOUNT ON;

        SELECT
            (ROW_NUMBER() OVER (ORDER BY s.MaSP ASC)) AS RowNumber,
            s.MaSP,
            dm.MaDanhMuc,
            dm.TenDanhMuc,
            s.TenSP,
            s.HinhAnh,
            s.Gia,
            s.LuotXem,
            ncc.MaNhaCC,
            ncc.TenNhaCC,
            s.MoTa  -- Thêm cột MoTa từ bảng SanPhams
        INTO #Temp2
        FROM SanPhams AS s
        INNER JOIN NhaCungCaps ncc ON ncc.MaNhaCC = s.MaNhaCC
        INNER JOIN DanhMucs dm ON dm.MaDanhMuc = s.MaDanhMuc
        WHERE (@TenSP = '' OR s.TenSP LIKE '%' + @TenSP + '%')
            AND (@TenDanhMuc = '' OR dm.TenDanhMuc LIKE '%' + @TenDanhMuc + '%')
            AND (@Gia = 0 OR s.Gia = @Gia)
            AND (@TenNhaCC = '' OR ncc.TenNhaCC LIKE '%' + @TenNhaCC + '%');

        SELECT @RecordCount = COUNT(*)
        FROM #Temp2;

        SELECT *,
               @RecordCount AS RecordCount
        FROM #Temp2;

        DROP TABLE #Temp2;
    END;
END;
-- Tạo stored procedure để lấy sản phẩm liên quan dựa vào mã danh mục
ALTER PROCEDURE sp_SanPhamLienQuan
    @MaDanhMuc INT
AS
BEGIN
    SELECT TOP 4 *
    FROM SanPhams
    WHERE MaDanhMuc = @MaDanhMuc;
END
EXEC sp_SanPhamLienQuan @MaDanhMuc = 1;
-----------------------------------
--Danh Mục
create proc sp_getall_danhmuc
as
begin
	select*from DanhMucs
end
---Tạo danh mục
CREATE PROCEDURE sp_create_danhmuc
(
    @TenDanhMuc NVARCHAR(100)
)
AS
BEGIN
    INSERT INTO DanhMucs (TenDanhMuc)
    VALUES (@TenDanhMuc);
END;
--Cập nhật danh mục
CREATE PROCEDURE sp_update_danhmuc
(
    @MaDanhMuc INT,
    @TenDanhMuc NVARCHAR(100)
)
AS
BEGIN
    UPDATE DanhMucs
    SET TenDanhMuc = @TenDanhMuc
    WHERE MaDanhMuc = @MaDanhMuc;
END;
--Xóa danh mục
CREATE PROCEDURE sp_delete_danhmuc
(
    @MaDanhMuc INT
)
AS
BEGIN
    DELETE FROM DanhMucs
    WHERE MaDanhMuc = @MaDanhMuc;
END;
-- lấy id danh mục
CREATE PROCEDURE sp_get_DanhMucByID
(
    @MaDanhMuc INT
)
AS
BEGIN
    SELECT *
    FROM DanhMucs
    WHERE MaDanhMuc = @MaDanhMuc;
END;
ALTER PROCEDURE sp_get_SanPhamByDanhMucID
(
    @MaDanhMuc INT
)
AS
BEGIN
    SELECT TOP 4 *
    FROM SanPhams
    WHERE MaDanhMuc = @MaDanhMuc;
END;
EXEC sp_get_SanPhamByDanhMucID '1'
---------------------------------------
--Nhà cung cấp
create proc sp_getall_nhacungcap
as
begin
	select*from NhaCungCaps
end
-- tạo nhà cung cấp
CREATE PROCEDURE sp_create_nhacungcap
(
    @TenNhaCC NVARCHAR(250),
    @DiaChi NVARCHAR(MAX),
    @SoDienThoai NVARCHAR(50)
)
AS
BEGIN
    INSERT INTO NhaCungCaps (TenNhaCC, DiaChi, SoDienThoai)
    VALUES (@TenNhaCC, @DiaChi, @SoDienThoai);
END;
-- cập nhật nhà cung cấp
CREATE PROCEDURE sp_update_nhacungcap
(
    @MaNhaCC INT,
    @TenNhaCC NVARCHAR(250),
    @DiaChi NVARCHAR(MAX),
    @SoDienThoai NVARCHAR(50)
)
AS
BEGIN
    UPDATE NhaCungCaps
    SET
        TenNhaCC = @TenNhaCC,
        DiaChi = @DiaChi,
        SoDienThoai = @SoDienThoai
    WHERE MaNhaCC = @MaNhaCC;
END;
-- xóa nhà cung cấp
CREATE PROCEDURE sp_delete_nhacungcap
(
    @MaNhaCC INT
)
AS
BEGIN
    DELETE FROM NhaCungCaps
    WHERE MaNhaCC = @MaNhaCC;
END;
-- lấy ra id nhà cung cấp
CREATE PROCEDURE sp_get_NhaCungCapByID
(
    @MaNhaCC INT
)
AS
BEGIN
    SELECT * FROM NhaCungCaps WHERE MaNhaCC = @MaNhaCC;
END;
----------------------------------------------------------
-- Tin tức
-- tạo tin tức
CREATE PROCEDURE sp_create_tintuc
(
    @TieuDe NVARCHAR(255),
    @NoiDung NVARCHAR(MAX),
    @NgayDang DATETIME,
    @TacGia NVARCHAR(100),
    @HinhAnh NVARCHAR(MAX)
)
AS
BEGIN
    INSERT INTO TinTucs (TieuDe, NoiDung, NgayDang, TacGia, HinhAnh)
    VALUES (@TieuDe, @NoiDung, @NgayDang, @TacGia, @HinhAnh);
END;
-- cập nhật tin tức
CREATE PROCEDURE sp_update_tintuc
(
    @MaTinTuc INT,
    @TieuDe NVARCHAR(255),
    @NoiDung NVARCHAR(MAX),
    @NgayDang DATETIME,
    @TacGia NVARCHAR(100),
    @HinhAnh NVARCHAR(MAX)
)
AS
BEGIN
    UPDATE TinTucs
    SET
        TieuDe = @TieuDe,
        NoiDung = @NoiDung,
        NgayDang = @NgayDang,
        TacGia = @TacGia,
        HinhAnh = @HinhAnh
    WHERE MaTinTuc = @MaTinTuc;
END;
-- xóa tin tức
CREATE PROCEDURE sp_delete_tintuc
(
    @MaTinTuc INT
)
AS
BEGIN
    DELETE FROM TinTucs
    WHERE MaTinTuc = @MaTinTuc;
END;
-- lấy ra id tin tức
CREATE PROCEDURE GetTinTucByID
(
    @MaTinTuc INT
)
AS
BEGIN
    SELECT * FROM TinTucs
    WHERE MaTinTuc = @MaTinTuc;
END;
-- lấy ra tất cả tin tức
CREATE PROCEDURE sp_getall_tintuc
AS
BEGIN
    SELECT * FROM TinTucs;
END;
----------------------------------------
CREATE PROCEDURE sp_layraTinTucNews
AS
BEGIN
    SELECT TOP 3 * 
    FROM TinTucs
    ORDER BY NgayDang DESC;
END;
----------------------------------------
-- Đơn hàng
-- Tạo stored procedure để chèn dữ liệu vào bảng DonHangs và ChiTietDonHangs
Alter PROCEDURE sp_create_donhang
    @MaKH INT,
    @MaTrangThai INT,
    @MaPhuongThuc INT,
    @NgayDatHang DATETIME,
    @DiaChiGiaoHang NVARCHAR(200),
    @list_json_chitiet_dh NVARCHAR(MAX)
AS
BEGIN
    DECLARE @MaDonHang INT;

    -- Chèn thông tin đơn hàng vào bảng DonHangs
    INSERT INTO DonHangs (MaKH, MaTrangThai, MaPhuongThuc, NgayDatHang, DiaChiGiaoHang)
    VALUES (@MaKH, @MaTrangThai, @MaPhuongThuc, @NgayDatHang, @DiaChiGiaoHang);

    -- Lấy mã đơn hàng vừa chèn
    SET @MaDonHang = SCOPE_IDENTITY();

    -- Kiểm tra xem danh sách chi tiết đơn hàng có giá trị không rỗng
    IF (@list_json_chitiet_dh IS NOT NULL)
    BEGIN
        -- Chèn thông tin chi tiết đơn hàng vào bảng ChiTietDonHangs từ chuỗi JSON
        INSERT INTO ChiTietDonHangs (MaDonHang, MaSP, TongGia, MaGiamGia, SoLuong)
        SELECT @MaDonHang,
               JSON_VALUE(y.value, '$.maSP'),
               JSON_VALUE(y.value, '$.tongGia'),
               JSON_VALUE(y.value, '$.maGiamGia'),
               JSON_VALUE(y.value, '$.soLuong')
        FROM OPENJSON(@list_json_chitiet_dh) AS y;
    END;
END;
-- cập nhật đơn hàng
-- Tạo stored procedure để cập nhật dữ liệu trong bảng DonHangs và ChiTietDonHangs
ALter PROCEDURE sp_update_donhang
    @MaDonHang INT,
    @MaKH INT,
    @MaTrangThai INT,
    @MaPhuongThuc INT,
    @NgayDatHang DATETIME,
    @DiaChiGiaoHang NVARCHAR(200),
    @list_json_chitiet_dh NVARCHAR(MAX)
AS
BEGIN
    -- Cập nhật thông tin đơn hàng trong bảng DonHangs
    UPDATE DonHangs
    SET MaKH = @MaKH,
        MaTrangThai = @MaTrangThai,
        MaPhuongThuc = @MaPhuongThuc,
        NgayDatHang = @NgayDatHang,
        DiaChiGiaoHang = @DiaChiGiaoHang
    WHERE MaDonHang = @MaDonHang;

    -- Xóa các chi tiết đơn hàng cũ trước khi thêm các chi tiết mới
    DELETE FROM ChiTietDonHangs WHERE MaDonHang = @MaDonHang;

    -- Kiểm tra xem danh sách chi tiết đơn hàng có giá trị không rỗng
    IF (@list_json_chitiet_dh IS NOT NULL)
    BEGIN
        -- Chèn thông tin chi tiết đơn hàng vào bảng ChiTietDonHangs từ chuỗi JSON
        INSERT INTO ChiTietDonHangs (MaDonHang, MaSP, TongGia, MaGiamGia, SoLuong)
        SELECT @MaDonHang,
               JSON_VALUE(y.value, '$.maSP'),
               JSON_VALUE(y.value, '$.tongGia'),
               JSON_VALUE(y.value, '$.maGiamGia'),
               JSON_VALUE(y.value, '$.soLuong')
        FROM OPENJSON(@list_json_chitiet_dh) AS y;
    END;
END;
-- xóa đơn hàng
CREATE PROCEDURE sp_delete_donhang
(
    @MaDonHang INT
)
AS
BEGIN
    
    DELETE FROM ChiTietDonHangs WHERE MaDonHang = @MaDonHang;

    DELETE FROM DonHangs WHERE MaDonHang = @MaDonHang;
END;
-- lấy ra id đơn hàng
CREATE PROCEDURE GetDonHangByID
    @MaDonHang INT
AS
BEGIN
    SELECT D.*, C.*
    FROM DonHangs AS D
    LEFT JOIN ChiTietDonHangs AS C ON D.MaDonHang = C.MaDonHang
    WHERE D.MaDonHang = @MaDonHang;
END
-- lấy ra tất cả đơn hàng
Alter PROCEDURE sp_getall_donhang
AS
BEGIN
    SELECT
        DH.MaDonHang,
        DH.MaKH,
        DH.MaTrangThai,
        DH.MaPhuongThuc,
        DH.NgayDatHang,
        CTDH.SoLuong, -- Thêm cột SoLuong từ bảng ChiTietDonHangs
        DH.DiaChiGiaoHang,
        KH.TenKH,
        TTTD.TenTrangThai,
        PTTT.TenPhuongThuc
    FROM DonHangs DH
    INNER JOIN KhachHangs KH ON DH.MaKH = KH.MaKH
    INNER JOIN TrangThaiDonHangs TTTD ON DH.MaTrangThai = TTTD.MaTrangThai
    INNER JOIN PhuongThucThanhToan PTTT ON DH.MaPhuongThuc = PTTT.MaPhuongThuc
    LEFT JOIN ChiTietDonHangs CTDH ON DH.MaDonHang = CTDH.MaDonHang; -- Thực hiện LEFT JOIN với bảng ChiTietDonHangs
END;

--
CREATE PROCEDURE sp_getall_trangthai_donhang
AS
BEGIN
    SELECT * FROM TrangThaiDonHangs;
END
CREATE PROCEDURE sp_getall_ptthanhtoan_donhang
AS
BEGIN
    SELECT * FROM PhuongThucThanhToan;
END

---------------------------------------------------------------------
-- Hóa đơn nhập
CREATE PROCEDURE sp_create_hoadonnhap
    @MaNhaCC INT,
    @NgayNhap DATETIME,
    @GhiChu NVARCHAR(MAX),
    @list_json_chitiet_hdnhap NVARCHAR(MAX)
AS
BEGIN
    DECLARE @MaHDNhap INT;

    -- Chèn thông tin hóa đơn nhập vào bảng HoaDonNhaps
    INSERT INTO HoaDonNhaps (MaNhaCC, NgayNhap, GhiChu)
    VALUES (@MaNhaCC, @NgayNhap, @GhiChu);

    -- Lấy mã hóa đơn nhập vừa chèn
    SET @MaHDNhap = SCOPE_IDENTITY();

    -- Kiểm tra xem danh sách chi tiết hóa đơn nhập có giá trị không rỗng
    IF (@list_json_chitiet_hdnhap IS NOT NULL)
    BEGIN
        -- Chèn thông tin chi tiết hóa đơn nhập vào bảng ChiTietHoaDonNhaps từ chuỗi JSON
        INSERT INTO ChiTietHoaDonNhaps (MaHDNhap, MaSP, SoLuong, DonGia, TongTien)
        SELECT @MaHDNhap,
               JSON_VALUE(y.value, '$.maSP'),
               JSON_VALUE(y.value, '$.soLuong'),
               JSON_VALUE(y.value, '$.donGia'),
               JSON_VALUE(y.value, '$.tongTien')
        FROM OPENJSON(@list_json_chitiet_hdnhap) AS y;
    END;
END;
-- sửa hóa đơn nhập
ALTER PROCEDURE sp_update_hoadonnhap
    @MaHDNhap INT,
    @MaNhaCC INT,
    @NgayNhap DATETIME,
    @GhiChu NVARCHAR(MAX),
    @list_json_chitiet_hdnhap NVARCHAR(MAX)
AS
BEGIN
    -- Cập nhật thông tin hóa đơn nhập trong bảng HoaDonNhaps
    UPDATE HoaDonNhaps
    SET MaNhaCC = @MaNhaCC,
        NgayNhap = @NgayNhap,
        GhiChu = @GhiChu
    WHERE MaHDNhap = @MaHDNhap;

    -- Xóa các chi tiết hóa đơn nhập cũ trước khi thêm các chi tiết mới
    DELETE FROM ChiTietHoaDonNhaps WHERE MaHDNhap = @MaHDNhap;

    -- Kiểm tra xem danh sách chi tiết hóa đơn nhập có giá trị không rỗng
    IF (@list_json_chitiet_hdnhap IS NOT NULL)
    BEGIN
        -- Chèn thông tin chi tiết hóa đơn nhập vào bảng ChiTietHoaDonNhaps từ chuỗi JSON
        INSERT INTO ChiTietHoaDonNhaps (MaHDNhap, MaSP, SoLuong, DonGia, TongTien)
        SELECT @MaHDNhap,
               JSON_VALUE(y.value, '$.maSP'),
               JSON_VALUE(y.value, '$.soLuong'),
               JSON_VALUE(y.value, '$.donGia'),
               JSON_VALUE(y.value, '$.tongTien')
        FROM OPENJSON(@list_json_chitiet_hdnhap) AS y;
    END;
END;
-- xóa hóa đơn nhập
CREATE PROCEDURE sp_delete_hoadonnhap
(
    @MaHDNhap INT
)
AS
BEGIN
    DELETE FROM ChiTietHoaDonNhaps WHERE MaHDNhap = @MaHDNhap;

    DELETE FROM HoaDonNhaps WHERE MaHDNhap = @MaHDNhap;
END;
-- get id hóa đơn nhập
CREATE PROCEDURE GetHoaDonNhapByID
    @MaHDNhap INT
AS
BEGIN
    SELECT H.*, CN.*
    FROM HoaDonNhaps AS H
    LEFT JOIN ChiTietHoaDonNhaps AS CN ON H.MaHDNhap = CN.MaHDNhap
    WHERE H.MaHDNhap = @MaHDNhap;
END;
-- lấy ra tất cả hóa đơn nhập
Alter PROCEDURE sp_getall_hoadonnhap
AS
BEGIN
    SELECT
        HDN.MaHDNhap,
        HDN.MaNhaCC,
        HDN.NgayNhap,
        HDN.GhiChu,
        NCC.TenNhaCC,
        CTHDN.MaSP,  -- Mã sản phẩm trong chi tiết hóa đơn nhập
        SP.TenSP,  -- Tên sản phẩm
        CTHDN.SoLuong,  -- Số lượng
        CTHDN.DonGia,   -- Đơn giá
        CTHDN.TongTien  -- Tổng tiền
    FROM HoaDonNhaps HDN
    INNER JOIN NhaCungCaps NCC ON HDN.MaNhaCC = NCC.MaNhaCC
    INNER JOIN ChiTietHoaDonNhaps CTHDN ON HDN.MaHDNhap = CTHDN.MaHDNhap
    INNER JOIN SanPhams SP ON CTHDN.MaSP = SP.MaSP;
END;

-- Tạo stored procedure để thêm đơn hàng
CREATE PROCEDURE sp_AddOrder
    @TenKH NVARCHAR(100),
    @SDT NVARCHAR(12),
    @DiaChi NVARCHAR(200),
    @Email NVARCHAR(100),
    @OrderDetailsList NVARCHAR(MAX)
AS
BEGIN
    -- Bắt đầu giao dịch
    BEGIN TRANSACTION;

    -- Khai báo biến
    DECLARE @OrderID INT;

    -- Thêm thông tin khách hàng vào bảng KhachHangs
    INSERT INTO KhachHangs (TenKH, SDT, DiaChi, Email)
    VALUES (@TenKH, @SDT, @DiaChi, @Email);

    -- Lấy OrderID sau khi thêm khách hàng
    SET @OrderID = SCOPE_IDENTITY();

    -- Chuyển chuỗi JSON thành bảng tạm thời
    DECLARE @TempOrderDetails TABLE (
        ProductID INT,
        Quantity INT,
        Price INT
    );

    INSERT INTO @TempOrderDetails (ProductID, Quantity, Price)
    SELECT [ProductID], [Quantity], [Price]
    FROM OPENJSON(@OrderDetailsList)
    WITH (
        ProductID INT '$.ProductID',
        Quantity INT '$.Quantity',
        Price INT '$.Price'
    );

    -- Thêm chi tiết đơn hàng vào bảng ChiTietDonHangs
    INSERT INTO ChiTietDonHangs (MaDonHang, MaSP, TongGia, SoLuong, MaGiamGia)
    SELECT @OrderID, ProductID, Price, Quantity, NULL
    FROM @TempOrderDetails;

    -- COMMIT giao dịch nếu thành công
    COMMIT;

    -- Trả về OrderID của đơn hàng mới được tạo
    SELECT @OrderID AS NewOrderID;

END
select * from KhachHangs
Alter PROCEDURE sp_getspdanhmuc_traicay
AS
BEGIN
    SELECT SanPhams.MaSP, SanPhams.TenSP, SanPhams.Gia, SanPhams.Mota, SanPhams.HinhAnh
    FROM SanPhams
    INNER JOIN DanhMucs ON SanPhams.MaDanhMuc = DanhMucs.MaDanhMuc
    WHERE DanhMucs.TenDanhMuc = N'Trái cây - Rau củ quả'
END;

EXEC sp_getspdanhmuc_traicay;

ALTER PROCEDURE sp_sortSanPhamAZTraiCayRauCuQua
AS
BEGIN
    SELECT SanPhams.MaSP, SanPhams.TenSP, SanPhams.Gia, SanPhams.Mota, SanPhams.HinhAnh
    FROM SanPhams
    INNER JOIN DanhMucs ON SanPhams.MaDanhMuc = DanhMucs.MaDanhMuc
    WHERE DanhMucs.TenDanhMuc = N'Trái cây - Rau củ quả'
    ORDER BY SanPhams.TenSP ASC;
END;
exec sp_sortSanPhamAZTraiCayRauCuQua;

CREATE PROCEDURE sp_sortSanPhamZATraiCayRauCuQua
AS
BEGIN
    SELECT SanPhams.MaSP, SanPhams.TenSP, SanPhams.Gia, SanPhams.Mota, SanPhams.HinhAnh
    FROM SanPhams
    INNER JOIN DanhMucs ON SanPhams.MaDanhMuc = DanhMucs.MaDanhMuc
    WHERE DanhMucs.TenDanhMuc = N'Trái cây - Rau củ quả'
    ORDER BY SanPhams.TenSP DESC;
END;
exec sp_sortSanPhamZATraiCayRauCuQua;

CREATE PROCEDURE sp_sortSanPhamPriceAscTraiCay
AS
BEGIN
    SELECT SanPhams.MaSP, SanPhams.TenSP, SanPhams.Gia, SanPhams.Mota, SanPhams.HinhAnh
    FROM SanPhams
    INNER JOIN DanhMucs ON SanPhams.MaDanhMuc = DanhMucs.MaDanhMuc
    WHERE DanhMucs.TenDanhMuc = N'Trái cây - Rau củ quả'
    ORDER BY SanPhams.Gia ASC;
END;

EXEC sp_sortSanPhamPriceAscTraiCayRauCuQua;

CREATE PROCEDURE sp_sortSanPhamPriceDescTraiCay
AS
BEGIN
    SELECT SanPhams.MaSP, SanPhams.TenSP, SanPhams.Gia, SanPhams.Mota, SanPhams.HinhAnh
    FROM SanPhams
    INNER JOIN DanhMucs ON SanPhams.MaDanhMuc = DanhMucs.MaDanhMuc
    WHERE DanhMucs.TenDanhMuc = N'Trái cây - Rau củ quả'
    ORDER BY SanPhams.Gia DESC;
END;

EXEC sp_sortSanPhamPriceDescTraiCayRauCuQua;


ALTER PROCEDURE sp_searchSanPhamTraiCay
    @TimKiem NVARCHAR(500)
AS
BEGIN
    SELECT SanPhams.*
    FROM SanPhams
    INNER JOIN DanhMucs ON SanPhams.MaDanhMuc = DanhMucs.MaDanhMuc
    WHERE DanhMucs.TenDanhMuc = N'Trái cây - Rau củ quả' AND (SanPhams.TenSP LIKE '%' + @TimKiem + '%' OR CAST(SanPhams.MaSP AS NVARCHAR(50)) LIKE '%' + @TimKiem + '%')
END;
EXEC sp_searchSanPhamTraiCay @TimKiem = N'1';

-- CREATE PROCEDURE: sp_create_account
ALTER PROCEDURE sp_create_account
    @tenDangNhap NVARCHAR(100),
    @matKhau NVARCHAR(30),
    @email NVARCHAR(255),
    @vaiTroId INT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM dbo.NguoiDungs WHERE TenDangNhap = @tenDangNhap)
    BEGIN
        SELECT 'Tên đăng nhập đã tồn tại.' AS ErrorMessage;
        RETURN;
    END
    INSERT INTO NguoiDungs (TenDangNhap, MatKhau, VaiTro_Id, Email)
    VALUES (@tenDangNhap, @matKhau, @vaiTroId, @email);
END
EXEC sp_create_account
    @tenDangNhap = 'user1',
    @matKhau = '1',
    @email = 'newuser@example.com',
    @vaiTroId = 2; 


ALTER PROCEDURE sp_create_order
    @TenKH NVARCHAR(100),
    @SDT NVARCHAR(12),
    @Email NVARCHAR(100),
    @DiaChi NVARCHAR(100),
    @list_json_dh NVARCHAR(MAX),
    @list_json_chitiet_dh NVARCHAR(MAX)
AS
BEGIN
    BEGIN TRY
        -- Chèn thông tin khách hàng vào bảng KhachHangs
        INSERT INTO KhachHangs (TenKH, SDT, Email, DiaChi)
        VALUES (@TenKH, @SDT, @Email, @DiaChi);

        -- Lấy mã khách hàng vừa chèn
        DECLARE @MaKH INT = SCOPE_IDENTITY();

        -- Chèn thông tin đơn hàng từ chuỗi JSON vào bảng DonHangs
		if(@list_json_dh is not null )
		begin
			INSERT INTO DonHangs (MaKH, MaPhuongThuc, NgayDatHang, DiaChiGiaoHang, MaTrangThai)
			SELECT @MaKH,
          JSON_VALUE(y.value, '$.maPhuongThuc'),
          JSON_VALUE(y.value, '$.ngayDatHang'),
          JSON_VALUE(y.value, '$.diaChiGiaoHang'),
          JSON_VALUE(y.value, '$.maTrangThai')
		  FROM OPENJSON(@list_json_dh) as y;
		end
        

        -- Lấy mã đơn hàng vừa chèn
        DECLARE @MaDonHang INT = SCOPE_IDENTITY();

        -- Chèn thông tin chi tiết đơn hàng từ chuỗi JSON vào bảng ChiTietDonHangs
		if(@list_json_dh is not null )
		begin
		INSERT INTO ChiTietDonHangs (MaDonHang, MaSP, TongGia, SoLuong,MaGiamGia)
        SELECT @MaDonHang,
            JSON_VALUE(x.value, '$.maSP'),
            JSON_VALUE(x.value, '$.tongGia'),
            JSON_VALUE(x.value, '$.soLuong'),
			JSON_VALUE(x.value, '$.maGiamGia')
			FROM OPENJSON(@list_json_chitiet_dh) as x;
		end

        
    END TRY
    BEGIN CATCH

        PRINT ERROR_MESSAGE();
    END CATCH;
END;

select * from KhachHangs
select * from DonHangs
select * from ChiTietDonHangs


select * from KhachHangs
DECLARE @TenKH NVARCHAR(100) = N'Tên Khách Ok';
DECLARE @SDT NVARCHAR(12) = 'Số Điện Thoại';
DECLARE @Email NVARCHAR(100) = 'Email';
DECLARE @DiaChi NVARCHAR(100) = 'diachi';
DECLARE @list_json_dh NVARCHAR(MAX) = N'{"maPhuongThuc": 1,"maTrangThai": 1, "ngayDatHang": "2023-11-19T02:24:50.580Z", "diaChiGiaoHang": "Địa Chỉ Giao Hàng"}';
DECLARE @list_json_chitiet_dh NVARCHAR(MAX) = N'{"maSP": 2, "tongGia": 1000, "soLuong": 5,"maGiamGia": "MGGG" }';


-- Thực hiện gọi stored procedure
EXEC sp_create_order
    @TenKH= N'Tên Khách Ok',
    @SDT= 'Số Thoại',
    @Email= 'Email',
    @DiaChi= 'diachi',
    @list_json_dh= N'[{"maPhuongThuc": 1,"maTrangThai": 1, "ngayDatHang": "2023-11-19T02:24:50.580Z", "diaChiGiaoHang": "Địa Chỉ Giao Hàng"}]',
    @list_json_chitiet_dh= N'[{"maSP": 2, "tongGia": 1000, "soLuong": 5,"maGiamGia": "11" }]'

ALTER PROCEDURE sp_getall_donhang_user
AS
BEGIN
    SELECT TOP 1
        KH.MaKH,
        KH.TenKH,
        KH.SDT,
        KH.Email,
        KH.DiaChi,
		DH.MaDonHang,
        DH.MaPhuongThuc,
        DH.MaTrangThai,
        DH.NgayDatHang,
        PT.TenPhuongThuc,
        DH.DiaChiGiaoHang,
        SP.TenSP,
        CTDH.TongGia,
        CTDH.SoLuong,
        CTDH.MaGiamGia
    FROM
        DonHangs DH
    INNER JOIN KhachHangs KH ON DH.MaKH = KH.MaKH
    INNER JOIN PhuongThucThanhToan PT ON DH.MaPhuongThuc = PT.MaPhuongThuc
    INNER JOIN ChiTietDonHangs CTDH ON DH.MaDonHang = CTDH.MaDonHang
    INNER JOIN SanPhams SP ON CTDH.MaSP = SP.MaSP
    ORDER BY
        DH.NgayDatHang DESC;
END;

exec sp_getall_donhang_user

CREATE PROCEDURE GetSanPhamByInfo
    @TenDanhMuc NVARCHAR(100) = NULL,
    @TenNhaCC NVARCHAR(250) = NULL,
    @TenSanPham NVARCHAR(500) = NULL
AS
BEGIN
    IF @TenDanhMuc IS NOT NULL
    BEGIN
        SELECT 
            SP.*
        FROM 
            SanPhams SP
        JOIN 
            DanhMucs DM ON SP.MaDanhMuc = DM.MaDanhMuc
        WHERE 
            DM.TenDanhMuc = @TenDanhMuc;
    END
    ELSE IF @TenNhaCC IS NOT NULL
    BEGIN
        SELECT 
            SP.*
        FROM 
            SanPhams SP
        JOIN 
            NhaCungCaps NCC ON SP.MaNhaCC = NCC.MaNhaCC
        WHERE 
            NCC.TenNhaCC = @TenNhaCC;
    END
    ELSE IF @TenSanPham IS NOT NULL
    BEGIN
        SELECT 
            *
        FROM 
            SanPhams
        WHERE 
            TenSP = @TenSanPham;
    END
    ELSE
    BEGIN
        PRINT 'Vui lòng nhập thông tin danh mục, nhà cung cấp hoặc tên sản phẩm.';
    END
END


ALTER PROCEDURE ThongKeDoanhThu
    @NgayBatDau DATETIME,
    @NgayKetThuc DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        N'Tổng' AS Ngay,
        COUNT(DISTINCT DH.MaDonHang) AS SoDonHang,
        SUM(CTDH.TongGia) AS DoanhThu
    FROM 
        DonHangs DH
        INNER JOIN ChiTietDonHangs CTDH ON DH.MaDonHang = CTDH.MaDonHang
    WHERE 
        DH.NgayDatHang BETWEEN @NgayBatDau AND @NgayKetThuc;
END;

EXEC ThongKeDoanhThu '2023-11-1', '2023-11-29';

select * from DonHangs

ALTER PROCEDURE GetDonHangByTrangThai
    @TrangThai int
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        DH.MaDonHang,
        KH.TenKH,
        DH.NgayDatHang,
        DH.DiaChiGiaoHang,
        CTDH.MaSP,
        CTDH.SoLuong,
        CTDH.TongGia,
        TT.MaTrangThai
    FROM 
        DonHangs DH
        INNER JOIN KhachHangs KH ON DH.MaKH = KH.MaKH
        INNER JOIN TrangThaiDonHangs TT ON DH.MaTrangThai = TT.MaTrangThai
        INNER JOIN ChiTietDonHangs CTDH ON DH.MaDonHang = CTDH.MaDonHang
    WHERE 
        TT.MaTrangThai = @TrangThai;
END;

EXEC GetDonHangByTrangThai @TrangThai = 1;

-- Tạo stored procedure
CREATE PROCEDURE sp_layrasanpham_saphet
AS
BEGIN
    SELECT Kho.MaKho, SanPhams.TenSP, Kho.SoLuong
    FROM Kho
    JOIN SanPhams ON Kho.MaSP = SanPhams.MaSP;
END;

-- Thực thi stored procedure
EXEC sp_layrasanpham_saphet
