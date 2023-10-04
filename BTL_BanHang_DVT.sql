CREATE DATABASE BTL_BanHang_DVT_API
use BTL_BanHang_DVT_API
go
-- BẢNG LOẠI SẢN PHẨM
CREATE TABLE DanhMucs
(
   MaDanhMuc INT IDENTITY(1,1) PRIMARY KEY,
   TenDanhMuc NVARCHAR(100) NOT NULL,
);
CREATE TABLE NhaCungCaps
( 
    MaNhaCC INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TenNhaCC NVARCHAR(250),
    DiaChi NVARCHAR(MAX),
    SoDienThoai NVARCHAR(50),
);
-- BẢNG SẢN PHẨM
CREATE TABLE SanPhams
(
   MaSP INT IDENTITY(1,1) PRIMARY KEY,
   TenSP NVARCHAR(500) NOT NULL,
   MaNhaCC INT,
   LuotXem INT,
   Gia INT,
   HinhAnh NVARCHAR(MAX),
   NgaySanXuat DATETIME,
   FOREIGN KEY (MaNhaCC) REFERENCES NhaCungCaps(MaNhaCC) ON DELETE CASCADE ON UPDATE CASCADE
);
-- BẢNG ẢNH SẢN PHẨM
CREATE TABLE AnhSanPhams
(
  MaAnhSP INT IDENTITY(1,1) PRIMARY KEY,
  MaSP INT NOT NULL,
  DuongDanAnh NVARCHAR(MAX),
  FOREIGN KEY (MaSP) REFERENCES SanPhams(MaSP) ON DELETE CASCADE ON UPDATE CASCADE
);
-- BẢNG KHÁCH HÀNG
CREATE TABLE KhachHangs
(
   MaKH INT IDENTITY(1,1) PRIMARY KEY,
   TenKH NVARCHAR(100) NOT NULL,
   SoLanMuaHang INT,
   SDT NVARCHAR(12) NOT NULL,
   Email NVARCHAR(100) NOT NULL,
   DiaChi NVARCHAR(200) NOT NULL
);
-- BẢNG TRẠNG THÁI ĐƠN HÀNG
CREATE TABLE TrangThaiDonHangs
(
  MaTrangThai INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  TenTrangThai NVARCHAR(100) NOT NULL
);

-- BẢNG ĐƠN HÀNG
CREATE TABLE DonHangs
(
   MaDonHang INT IDENTITY(1,1) PRIMARY KEY,
   MaKH INT NOT NULL,
   NgayDatHang DATETIME NOT NULL,
   PhuongThucThanhToan NVARCHAR(100),
   MaTrangThai INT,
   FOREIGN KEY (MaKH) REFERENCES KhachHangs(MaKH) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY (MaTrangThai) REFERENCES TrangThaiDonHangs(MaTrangThai) ON DELETE CASCADE ON UPDATE CASCADE
);
-- BẢNG CHI TIẾT ĐƠN HÀNG
CREATE TABLE ChiTietDonHangs
(
  MaCTDH INT IDENTITY(1,1) PRIMARY KEY,
  MaDonHang INT NOT NULL,
  MaSP INT NOT NULL,
  SoLuong INT NOT NULL,
  TongGia INT NOT NULL,
  MaGiamGia NVARCHAR(100) NOT NULL,
  DiaChiGiaoHang NVARCHAR(200) NOT NULL,
  FOREIGN KEY (MaDonHang) REFERENCES DonHangs(MaDonHang) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (MaSP) REFERENCES SanPhams(MaSP) ON DELETE NO ACTION ON UPDATE CASCADE 
);
-- BẢNG CHI TIẾT SẢN PHẨM
CREATE TABLE ChiTietSanPhams
(
  MaCTSP INT IDENTITY(1,1) PRIMARY KEY,
  MaDanhMuc INT,
  MaSP INT NOT NULL,
  Mota NVARCHAR(MAX),
  FOREIGN KEY (MaDanhMuc) REFERENCES DanhMucs(MaDanhMuc) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (MaSP) REFERENCES SanPhams(MaSP) ON DELETE NO ACTION ON UPDATE CASCADE,
);
-- BẢNG ĐĂNG NHẬP
-- Tạo bảng VAITRO
CREATE TABLE VaiTros
(
    Id INT IDENTITY PRIMARY KEY,
    TenVaiTro NVARCHAR(50) NOT NULL
);
-- Tạo bảng NGUOIDUNG
CREATE TABLE NguoiDungs
(
   MaNguoiDung INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
   TenDangNhap NVARCHAR(100) UNIQUE NOT NULL,
   MatKhau NVARCHAR(30) NOT NULL,
   VaiTro_Id INT,
   FOREIGN KEY (VAITRO_Id) REFERENCES VaiTros(Id) ON DELETE CASCADE ON UPDATE CASCADE,
);
CREATE TABLE TinTucs
(
   MaTinTuc INT IDENTITY(1,1) PRIMARY KEY,
   TieuDe NVARCHAR(255) NOT NULL,
   NoiDung NVARCHAR(MAX) NOT NULL,
   NgayDang DATETIME NOT NULL,
   TacGia NVARCHAR(100),
   HinhAnh NVARCHAR(MAX)
);
--------------------------------------------------------------------------------------------
----chèn dữ liệu vào các bảng
--Bảng nhà cung cấp
INSERT INTO NhaCungCaps (TenNhaCC, DiaChi, SoDienThoai)
VALUES 
(N'Đại lộc phát', N'TP. Hồ Chí Minh', '0967839321'),
(N'VietGap', N'Hà Nội', '0376289012'),
(N'See The World', N'Hà Nội', '0987652419');
--Bảng khách hàng
INSERT INTO KhachHangs (TenKH, SDT, Email, DiaChi, SoLanMuaHang)
VALUES 
(N'Nguyễn Thị Hoa', '0988318198', 'nguyenhoa@gmail.com', N'Hưng Yên', 0),
(N'Trần Thị Bình', '0123456789', 'tranthibinh@gmail.com', N'Hà Nội', 5),
(N'Dương Văn Hải', '0214664622', 'haidv@gmail.com', N'Hưng Yên', 1),
(N'Nguyễn Thị Nhi', '0767572232', 'NTnhi@gmail.com', N'Hưng Yên', 2),
(N'Nguyễn Mai Hoa', '0757757522', 'hoanm@gmail.com', N'Hà Nội', 0);

--Bảng loại sản phẩm
INSERT INTO DanhMucs (TenDanhMuc)
VALUES 
(N'Trái cây - Rau củ quả'),
(N'Gạo'),
(N'Các loại thịt và hải sản'),
(N'Đặc sản vùng miền'),
(N'Hàng xách tay Mỹ - Nhật - Hàn');
--Bảng sản phẩm
-- Chèn dữ liệu vào bảng SanPhams
INSERT INTO SanPhams (TenSP, MaNhaCC, Gia, HinhAnh, NgaySanXuat, LuotXem)
VALUES (N'Cam Sành', 1, 100000, 'camsanh.jpg', '2023-09-29 12:00:00', 0);
INSERT INTO SanPhams (TenSP, MaNhaCC, Gia, HinhAnh, NgaySanXuat, LuotXem)
VALUES (N'Bắp cải trắng', 1, 120000, 'bapcaitrang.jpg', '2023-09-29 12:15:00', 0);
INSERT INTO SanPhams (TenSP, MaNhaCC, Gia, HinhAnh, NgaySanXuat, LuotXem)
VALUES (N'Gạo nàng thơm', 2, 80000, 'gaonangthonm.jpg', '2023-09-29 12:30:00', 0);
INSERT INTO SanPhams (TenSP, MaNhaCC, Gia, HinhAnh, NgaySanXuat, LuotXem)
VALUES (N'[PREMIUM] Ba rọi heo Đặc biệt', 3, 95000, N'baroiheodb.jpg', '2023-09-29 12:45:00', 0);
INSERT INTO SanPhams (TenSP, MaNhaCC, Gia, HinhAnh, NgaySanXuat, LuotXem)
VALUES (N'Cá lịch khô rim tỏi ớt', 3, 75000, 'calichkho.jpg', '2023-09-29 13:00:00', 0);
INSERT INTO SanPhams (TenSP, MaNhaCC, Gia, HinhAnh, NgaySanXuat, LuotXem)
VALUES (N'Tảo xoắn Spirulina Nhật Bản', 3, 100000, 'taoxoan.jpg', '2023-09-29 12:00:00', 0);
INSERT INTO SanPhams (TenSP, MaNhaCC, Gia, HinhAnh, NgaySanXuat, LuotXem)
VALUES (N'Mực nang Lagi Bình Thuận', 2, 120000, 'mucnang.jpg', '2023-09-29 12:15:00', 0);
INSERT INTO SanPhams (TenSP, MaNhaCC, Gia, HinhAnh, NgaySanXuat, LuotXem)
VALUES (N'Bơ ĐakLak', 2, 80000, 'bodaklak.jpg', '2023-09-29 12:30:00', 0);
INSERT INTO SanPhams (TenSP, MaNhaCC, Gia, HinhAnh, NgaySanXuat, LuotXem)
VALUES (N'Cải bó xôi', 3, 95000, 'caiboxoi.jpg', '2023-09-29 12:45:00', 0);
INSERT INTO SanPhams (TenSP, MaNhaCC, Gia, HinhAnh, NgaySanXuat, LuotXem)
VALUES (N'Gạo ST25', 1, 75000, 'gaost25.jpg', '2023-09-29 13:00:00', 0);
--Bảng chi tiết sản phẩm
INSERT INTO ChiTietSanPhams (MaSP, MaDanhMuc, Mota)
VALUES 
(1, 1, N'Cam Sành là một loại trái cây ngọt, thơm, và giàu vitamin C.'),
(2, 1, N'Bắp cải trắng là một loại rau củ sạch, giàu chất xơ và thích hợp cho các món ăn dinh dưỡng'),
(3, 2, N'Gạo nàng thơm là một loại gạo trắng, thơm ngon và dẻo'),
(4, 3, N'Ba rọi heo Đặc biệt là một loại thịt heo tươi ngon, chất lượng cao'),
(5, 1, N'Bắp cải trắng là một loại rau củ sạch, giàu chất xơ và thích hợp cho các món ăn dinh dưỡng'),
(6, 3, N'Cá lịch khô rim tỏi ớt là một loại hải sản khô ngon, cay cay và thơm mùi tỏi');
--Bảng người dùng
INSERT INTO NguoiDungs (TenDangNhap, MatKhau, VaiTro_Id)
VALUES 
('admin', '1', 1),
('user1', '1', 2),
('user2', '1', 1);
--Bảng vai trò
INSERT INTO VaiTros (TenVaiTro)
VALUES 
(N'Quản trị viên'),
(N'Người dùng'),
(N'Người dùng');
--Bảng trạng thái đơn hàng
INSERT INTO TrangThaiDonHangs (TenTrangThai)
VALUES 
(N'Đang xử lý'),
(N'Đã xác nhận'),
(N'Đã giao hàng'),
(N'Đã hủy'),
(N'Đang giao hàng');
--Bảng đơn hàng
INSERT INTO DonHangs (MaKH, NgayDatHang, PhuongThucThanhToan, MaTrangThai)
VALUES 
(1, '2023-09-29 10:00:00', N'Thanh toán bằng thẻ', 1),
(2, '2023-09-29 11:00:00', N'Thanh toán khi nhận hàng', 2),
(3, '2023-09-29 12:00:00', N'Thanh toán bằng thẻ', 5),
(4, '2023-09-29 13:00:00', N'Thanh toán qua ví điện tử', 3),
(5, '2023-09-29 14:00:00', N'Thanh toán khi nhận hàng', 5);
--Chi tiết đơn hàng
INSERT INTO ChiTietDonHangs (MaDonHang, MaSP, SoLuong, TongGia, MaGiamGia, DiaChiGiaoHang)
VALUES 
(1, 1, 1, 50000, 'MGG001', 'Lương Bằng - Kim Động - Hưng Yên'),
(2, 2, 1, 75000, 'MGG002', 'Địa chỉ giao hàng 2'),
(3, 3, 2, 120000, 'MGG003', 'Địa chỉ giao hàng 3'),
(4, 4, 3, 80000, 'MGG004', 'Địa chỉ giao hàng 4'),
(5, 5, 4, 95000, 'MGG005', 'Địa chỉ giao hàng 5');
--Bảng tin tức
INSERT INTO TinTucs (TieuDe, NoiDung, NgayDang, TacGia, HinhAnh)
VALUES (N'Khai trương cửa hàng tại Vinhomes Grand Park', N'Khai trương cửa hàng...', '2023-09-29 14:00:00', N'Đình Đỗ', 'tintuc1.jpg');
INSERT INTO TinTucs (TieuDe, NoiDung, NgayDang, TacGia, HinhAnh)
VALUES (N'Vai trò của thực phẩm sạch đối với đời sống con người', N'Vai trò của thực phẩm...', '2023-09-29 14:30:00', N'Đỗ Đình', 'tintuc2.jpg');
INSERT INTO TinTucs (TieuDe, NoiDung, NgayDang, TacGia, HinhAnh)
VALUES (N'Thực phẩm sạch và thực phẩm hữu cơ khác nhau như thế nào ?', N'Thực phẩm sạch...', '2023-09-29 14:30:00', N'Đỗ Đình', 'tintuc3.jpg');
--------------------------------------------------------------------------------------------------------------------------------------------------
--STORE PROC
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
CREATE PROCEDURE sp_create_sanpham
    @MaNhaCC INT,
    @LuotXem INT,
    @Gia INT,
    @HinhAnh NVARCHAR(MAX),
    @NgaySanXuat DATETIME,
    @TenSP NVARCHAR(500)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @MaSP INT;

    -- Chèn dữ liệu sản phẩm vào bảng SanPhams
    INSERT INTO SanPhams (MaNhaCC, LuotXem, Gia, HinhAnh, NgaySanXuat, TenSP)
    VALUES (@MaNhaCC, @LuotXem, @Gia, @HinhAnh, @NgaySanXuat, @TenSP);

    -- Lấy MaSP của sản phẩm vừa thêm
    SET @MaSP = SCOPE_IDENTITY();

    -- Trả về MaSP của sản phẩm vừa thêm
    SELECT @MaSP AS MaSP;
END
--Get Id Sản Phẩm
CREATE PROCEDURE sp_get_SanPhamByID
(
    @MaSanPham INT
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        S.MaSP,
        S.MaLoaiSP,
        S.MaNhaCC,
        S.TenSP,
        S.Gia,
        S.HinhAnh,
        S.NgaySanXuat
    FROM SanPhams AS S
    WHERE S.MaSP = @MaSanPham;
END;
--Get All Sản Phẩm
CREATE PROCEDURE sp_getall_sanpham
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        S.MaSP,
        S.MaLoaiSP,
        S.MaNhaCC,
        S.TenSP,
        S.Gia,
        S.HinhAnh,
        S.NgaySanXuat
    FROM SanPhams AS S;
END;
--Update Sản Phẩm
CREATE PROCEDURE sp_update_sanpham
(
    @MaSanPham INT,
    @MaLoaiSP INT,
    @MaNhaCC INT,
    @TenSanPham NVARCHAR(500),
    @Gia INT,
    @HinhAnh NVARCHAR(MAX),
    @NgaySanXuat DATETIME,
    @list_json_chitiet_sp NVARCHAR(MAX) = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    -- Cập nhật thông tin sản phẩm trong bảng SanPhams
    UPDATE SanPhams
    SET MaLoaiSP = @MaLoaiSP,
        MaNhaCC = @MaNhaCC,
        TenSP = @TenSanPham,
        Gia = @Gia,
        HinhAnh = @HinhAnh,
        NgaySanXuat = @NgaySanXuat
    WHERE MaSP = @MaSanPham;

    -- Xóa chi tiết sản phẩm hiện có
    DELETE FROM ChiTietSanPhams
    WHERE MaSP = @MaSanPham;

    -- Thêm chi tiết sản phẩm mới nếu có
    IF @list_json_chitiet_sp IS NOT NULL
    BEGIN
        INSERT INTO ChiTietSanPhams (MaSP, Mota)
        SELECT @MaSanPham, Mota
        FROM OPENJSON(@list_json_chitiet_sp)
        WITH (
            Mota NVARCHAR(MAX) '$.Mota'
        );
    END;
END;
--Xóa Sản Phẩm
CREATE PROCEDURE sp_delete_sanpham
(
    @MaSanPham INT
)
AS
BEGIN
    SET NOCOUNT ON;

    -- Xóa chi tiết sản phẩm liên quan đến sản phẩm cần xóa
    DELETE FROM ChiTietSanPhams
    WHERE MaSP = @MaSanPham;

    -- Xóa sản phẩm trong bảng SanPhams
    DELETE FROM SanPhams
    WHERE MaSP = @MaSanPham;
END;
--Tìm kiếm sản phẩm
CREATE PROCEDURE sp_sanpham_search
(
    @page_index INT,
    @page_size INT,
    @TenSanPham NVARCHAR(500)
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RecordCount BIGINT;

    IF (@page_size <> 0)
    BEGIN
        -- Trường hợp phân trang
        SELECT
            (ROW_NUMBER() OVER (ORDER BY MaSP ASC)) AS RowNumber,
            S.MaSP,
            S.MaNhaCC,
            S.TenSP,
            S.Gia,
            S.HinhAnh,
            S.NgaySanXuat
        INTO #Results
        FROM SanPhams AS S
        WHERE (@TenSanPham IS NULL OR S.TenSP LIKE N'%' + @TenSanPham + '%');

        SELECT @RecordCount = COUNT(*) FROM #Results;

        SELECT *,
            @RecordCount AS RecordCount
        FROM #Results
        WHERE RowNumber BETWEEN (@page_index - 1) * @page_size + 1 AND ((@page_index - 1) * @page_size + 1) + @page_size - 1;

        DROP TABLE #Results;
    END
    ELSE
    BEGIN
        -- Trường hợp không phân trang
        SELECT
            S.MaSP,
            S.MaNhaCC,
            S.TenSP,
            S.Gia,
            S.HinhAnh,
            S.NgaySanXuat
        FROM SanPhams AS S
        WHERE (@TenSanPham IS NULL OR S.TenSP LIKE N'%' + @TenSanPham + '%');
    END;
END;
