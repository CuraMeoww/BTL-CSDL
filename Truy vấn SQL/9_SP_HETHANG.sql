-- Xuất ra thông tin các sản phẩm hiện đang hết hàng trong kho

SELECT MaSP, TenSP, LoaiSP, MaNCC 
FROM SANPHAM 
WHERE SoLuongTon = 0;