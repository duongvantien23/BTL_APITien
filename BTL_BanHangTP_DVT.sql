CREATE DATABASE BTL_BanHangTP_DVT
use BTL_BanHangTP_DVT
go
-- BẢNG LOẠI SẢN PHẨM
CREATE TABLE DanhMucs
(
   MaDanhMuc INT IDENTITY(1,1) PRIMARY KEY,
   TenDanhMuc NVARCHAR(100) NOT NULL,
)
CREATE TABLE NhaCungCaps
( 
    MaNhaCC INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TenNhaCC NVARCHAR(250),
    DiaChi NVARCHAR(MAX),
    SoDienThoai NVARCHAR(50),
)
-- BẢNG SẢN PHẨM
CREATE TABLE SanPhams
(
   MaSP INT IDENTITY(1,1) PRIMARY KEY,
   MaDanhMuc INT,
   TenSP NVARCHAR(500) NOT NULL,
   MaNhaCC INT,
   LuotXem INT,
   Gia INT,
   Mota NVARCHAR(MAX),
   HinhAnh NVARCHAR(MAX),
   NgaySanXuat DATETIME,
   FOREIGN KEY (MaDanhMuc) REFERENCES DanhMucs(MaDanhMuc) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY (MaNhaCC) REFERENCES NhaCungCaps(MaNhaCC) ON DELETE CASCADE ON UPDATE CASCADE
)
ALTER TABLE SanPhams
ADD DonViTinh NVARCHAR(100) NULL;
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
   SDT NVARCHAR(12) NOT NULL,
   Email NVARCHAR(100) NOT NULL,
   DiaChi NVARCHAR(200) NOT NULL
);
-- BẢNG ĐƠN HÀNG
CREATE TABLE PhuongThucThanhToan
(
   MaPhuongThuc INT IDENTITY(1,1) PRIMARY KEY,
   TenPhuongThuc NVARCHAR(100) NULL,
);
CREATE TABLE TrangThaiDonHangs
(
   MaTrangThai INT IDENTITY(1,1) PRIMARY KEY,
   TenTrangThai NVARCHAR(100) NULL,
);
CREATE TABLE DonHangs
(
   MaDonHang INT IDENTITY(1,1) PRIMARY KEY,
   MaKH INT NOT NULL,
   MaTrangThai INT NOT NULL,
   MaPhuongThuc INT NOT NULL,
   NgayDatHang DATETIME NOT NULL,
   DiaChiGiaoHang NVARCHAR(200) NOT NULL,
   FOREIGN KEY (MaKH) REFERENCES KhachHangs(MaKH) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY (MaTrangThai) REFERENCES TrangThaiDonHangs(MaTrangThai) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY (MaPhuongThuc) REFERENCES PhuongThucThanhToan(MaPhuongThuc) ON DELETE CASCADE ON UPDATE CASCADE
);
-- BẢNG CHI TIẾT ĐƠN HÀNG
CREATE TABLE ChiTietDonHangs
(
  MaCTDH INT IDENTITY(1,1) PRIMARY KEY,
  MaDonHang INT NOT NULL,
  MaSP INT NOT NULL,
  TongGia INT NOT NULL,
  SoLuong INT NOT NULL,
  MaGiamGia NVARCHAR(100) NOT NULL,
  FOREIGN KEY (MaDonHang) REFERENCES DonHangs(MaDonHang) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (MaSP) REFERENCES SanPhams(MaSP) ON DELETE NO ACTION ON UPDATE CASCADE 
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
   Email NVARCHAR(255) NULL,
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
-- BẢNG HÓA ĐƠN NHẬP
CREATE TABLE HoaDonNhaps
(
   MaHDNhap INT IDENTITY(1,1) PRIMARY KEY,
   MaNhaCC INT NOT NULL,
   NgayNhap DATETIME NOT NULL,
   GhiChu NVARCHAR(MAX) NULL,
   FOREIGN KEY (MaNhaCC) REFERENCES NhaCungCaps(MaNhaCC) ON DELETE CASCADE ON UPDATE CASCADE
);
-- BẢNG CHI TIẾT HÓA ĐƠN NHẬP
CREATE TABLE ChiTietHoaDonNhaps
(
   MaCTHDNhap INT IDENTITY(1,1) PRIMARY KEY,
   MaHDNhap INT NOT NULL,
   MaSP INT NOT NULL,
   SoLuong INT NOT NULL,
   DonGia INT NOT NULL,
   TongTien INT NOT NULL,
   FOREIGN KEY (MaHDNhap) REFERENCES HoaDonNhaps(MaHDNhap) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY (MaSP) REFERENCES SanPhams(MaSP) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE Kho
(
   MaKho INT IDENTITY(1,1) PRIMARY KEY,
   MaSP INT NOT NULL,
   SoLuong INT NOT NULL,
   FOREIGN KEY (MaSP) REFERENCES SanPhams(MaSP) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO Kho (MaSP, SoLuong)
VALUES 
(1, 20), 
(2, 10),
(3, 15) 

--chèn dữ liệu
INSERT INTO NhaCungCaps (TenNhaCC, DiaChi, SoDienThoai)
VALUES 
(N'Đại lộc phát', N'TP. Hồ Chí Minh', '0967839321'),
(N'VietGap', N'Hà Nội', '0376289012'),
(N'See The World', N'Hà Nội', '0987652419');
--Bảng khách hàng
INSERT INTO KhachHangs (TenKH, SDT, Email, DiaChi)
VALUES 
(N'Nguyễn Thị Hoa', '0988318198', 'nguyenhoa@gmail.com', N'Hưng Yên'),
(N'Trần Thị Bình', '0123456789', 'tranthibinh@gmail.com', N'Hà Nội'),
(N'Dương Văn Hải', '0214664622', 'haidv@gmail.com', N'Hưng Yên'),
(N'Nguyễn Thị Nhi', '0767572232', 'NTnhi@gmail.com', N'Hưng Yên'),
(N'Nguyễn Mai Hoa', '0757757522', 'hoanm@gmail.com', N'Hà Nội');

--Bảng loại sản phẩm
INSERT INTO DanhMucs (TenDanhMuc)
VALUES 
(N'Trái cây - Rau củ quả'),
(N'Gạo'),
(N'Các loại thịt và hải sản'),
(N'Đặc sản vùng miền'),
(N'Hàng xách tay Mỹ - Nhật - Hàn');
-- Chèn dữ liệu vào bảng PhuongThucThanhToan
INSERT INTO PhuongThucThanhToan (TenPhuongThuc)
VALUES (N'Tiền mặt'),
       (N'Thẻ tín dụng'),
       (N'Chuyển khoản'),
       (N'PayPal'),
       (N'Ví điện tử');
-- Chèn dữ liệu vào bảng TrangThaiDonHangs
INSERT INTO TrangThaiDonHangs (TenTrangThai)
VALUES (N'Chờ xác nhận'),
       (N'Đang xử lý'),
       (N'Đã giao hàng'),
       (N'Hoàn thành'),
       (N'Hủy đơn hàng'),
	   (N'Đang giao hàng');
	   --Bảng người dùng
INSERT INTO NguoiDungs (TenDangNhap, MatKhau, VaiTro_Id,Email)
VALUES 
('admin', '1', 1,'admin@example.com'),
('user1', '1', 2,'user1@example.com'),
('user2', '1', 1,'user2@example.com');
--Bảng vai trò
INSERT INTO VaiTros (TenVaiTro)
VALUES 
(N'Quản trị viên'),
(N'Người dùng');
