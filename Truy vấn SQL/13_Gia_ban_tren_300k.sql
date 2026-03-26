--Xuất ra thông tin sản phẩm có xuất xứ từ nước ngoài với giá bán > 100000

SELECT MaSP, TenSP, LoaiSP, GiaBan, XuatXu 
FROM SANPHAM 
WHERE XuatXu <> N'Việt Nam' 
AND GiaBan > 100000;
