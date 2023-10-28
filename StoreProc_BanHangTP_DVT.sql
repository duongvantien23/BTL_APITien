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
Create PROCEDURE sp_create_sanpham
    @MaDanhMuc INT,
    @TenSP NVARCHAR(500),
    @MaNhaCC INT,
    @LuotXem INT,
    @Gia INT,
    @MoTa NVARCHAR(MAX),
    @HinhAnh NVARCHAR(MAX),
    @NgaySanXuat DATETIME
AS
BEGIN
    INSERT INTO SanPhams (MaDanhMuc, TenSP, MaNhaCC, LuotXem, Gia, Mota, HinhAnh, NgaySanXuat)
    VALUES (@MaDanhMuc, @TenSP, @MaNhaCC, @LuotXem, @Gia, @MoTa, @HinhAnh, @NgaySanXuat);
END
--Get Id Sản Phẩm
Create PROCEDURE sp_get_SanPhamByID
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
        S.Gia,
        S.Mota,
        S.HinhAnh,
        S.NgaySanXuat
    FROM SanPhams AS S
    INNER JOIN DanhMucs AS DM ON S.MaDanhMuc = DM.MaDanhMuc
    INNER JOIN NhaCungCaps AS NCC ON S.MaNhaCC = NCC.MaNhaCC
    WHERE S.MaSP = @MaSanPham;
END;
--Get All Sản Phẩm
Create PROCEDURE sp_getall_sanpham
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
        SP.NgaySanXuat
    FROM SanPhams SP
    JOIN DanhMucs DM ON SP.MaDanhMuc = DM.MaDanhMuc;
END;
--Update Sản Phẩm
Create PROCEDURE sp_update_sanpham
    @MaSP INT,
    @MaDanhMuc INT,
    @TenSP NVARCHAR(500),
    @MaNhaCC INT,
    @LuotXem INT,
    @Gia INT,
    @MoTa NVARCHAR(MAX),
    @HinhAnh NVARCHAR(MAX),
    @NgaySanXuat DATETIME
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
        NgaySanXuat = @NgaySanXuat
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
CREATE PROCEDURE sp_get_top_view_sanpham
    @Limit INT
AS
BEGIN
    SELECT TOP(@Limit)
        sp.MaSP,
        sp.TenSP,
        sp.LuotXem,
        sp.Gia,
        sp.Mota,
        sp.HinhAnh
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
-- Đơn hàng
-- Tạo stored procedure để chèn dữ liệu vào bảng DonHangs và ChiTietDonHangs
CREATE PROCEDURE sp_create_donhang
    @MaKH INT,
    @MaTrangThai INT,
    @MaPhuongThuc INT,
    @NgayDatHang DATETIME,
    @SoLuong INT,
    @DiaChiGiaoHang NVARCHAR(200),
    @list_json_chitiet_dh NVARCHAR(MAX)
AS
BEGIN
    DECLARE @MaDonHang INT;

    -- Chèn thông tin đơn hàng vào bảng DonHangs
    INSERT INTO DonHangs (MaKH, MaTrangThai, MaPhuongThuc, NgayDatHang, SoLuong, DiaChiGiaoHang)
    VALUES (@MaKH, @MaTrangThai, @MaPhuongThuc, @NgayDatHang, @SoLuong, @DiaChiGiaoHang);

    -- Lấy mã đơn hàng vừa chèn
    SET @MaDonHang = SCOPE_IDENTITY();

    -- Kiểm tra xem danh sách chi tiết đơn hàng có giá trị không rỗng
    IF (@list_json_chitiet_dh IS NOT NULL)
    BEGIN
        -- Chèn thông tin chi tiết đơn hàng vào bảng ChiTietDonHangs từ chuỗi JSON
        INSERT INTO ChiTietDonHangs (MaDonHang, MaSP, TongGia, MaGiamGia)
        SELECT @MaDonHang,
               JSON_VALUE(y.value, '$.maSP'),
               JSON_VALUE(y.value, '$.tongGia'),
               JSON_VALUE(y.value, '$.maGiamGia')
        FROM OPENJSON(@list_json_chitiet_dh) AS y;
    END;
END;

-- cập nhật đơn hàng
-- Tạo stored procedure để cập nhật dữ liệu trong bảng DonHangs và ChiTietDonHangs
CREATE PROCEDURE sp_update_donhang
    @MaDonHang INT,
    @MaKH INT,
    @MaTrangThai INT,
    @MaPhuongThuc INT,
    @NgayDatHang DATETIME,
    @SoLuong INT,
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
        SoLuong = @SoLuong,
        DiaChiGiaoHang = @DiaChiGiaoHang
    WHERE MaDonHang = @MaDonHang;

    -- Xóa các chi tiết đơn hàng cũ trước khi thêm các chi tiết mới
    DELETE FROM ChiTietDonHangs WHERE MaDonHang = @MaDonHang;

    -- Kiểm tra xem danh sách chi tiết đơn hàng có giá trị không rỗng
    IF (@list_json_chitiet_dh IS NOT NULL)
    BEGIN
        -- Chèn thông tin chi tiết đơn hàng vào bảng ChiTietDonHangs từ chuỗi JSON
        INSERT INTO ChiTietDonHangs (MaDonHang, MaSP, TongGia, MaGiamGia)
        SELECT @MaDonHang,
               JSON_VALUE(y.value, '$.maSP'),
               JSON_VALUE(y.value, '$.tongGia'),
               JSON_VALUE(y.value, '$.maGiamGia')
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
CREATE PROCEDURE sp_getall_donhang
AS
BEGIN
    SELECT
        DH.MaDonHang,
        DH.MaKH,
        DH.MaTrangThai,
        DH.MaPhuongThuc,
        DH.NgayDatHang,
        DH.SoLuong,
        DH.DiaChiGiaoHang,
        KH.TenKH,
        TTTD.TenTrangThai,
        PTTT.TenPhuongThuc
    FROM DonHangs DH
    INNER JOIN KhachHangs KH ON DH.MaKH = KH.MaKH
    INNER JOIN TrangThaiDonHangs TTTD ON DH.MaTrangThai = TTTD.MaTrangThai
    INNER JOIN PhuongThucThanhToan PTTT ON DH.MaPhuongThuc = PTTT.MaPhuongThuc;
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