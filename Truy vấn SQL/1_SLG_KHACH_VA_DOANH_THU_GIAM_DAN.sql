--Thống kê số lượng khách và doanh thu khu vực theo thứ tự giảm dần

SELECT 
    KH.DiaChi, 
    COUNT(DISTINCT KH.MaKH) AS SoLuongKhach,
    SUM(HD.ThanhTien) AS TongDoanhThuKhuVuc
FROM KHACHHANG KH
JOIN HOADON HD ON KH.MaKH = HD.MaKH
GROUP BY KH.DiaChi
ORDER BY TongDoanhThuKhuVuc DESC;