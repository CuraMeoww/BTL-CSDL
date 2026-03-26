--Xuất ra tên khách hàng có tổng hóa đơn trên 1000000


SELECT KH.TenKH, 
SUM(HD.ThanhTien) AS TongChiTieu
FROM KHACHHANG KH JOIN HOADON HD
ON KH.MaKH = HD.MaKH
GROUP BY KH.MaKH, KH.TenKH
HAVING SUM(HD.ThanhTien) > 1000000;
