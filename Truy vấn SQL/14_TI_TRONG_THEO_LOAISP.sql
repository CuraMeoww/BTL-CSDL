--Tỉ trọng doanh thu theo loại sản phẩm (%)

SELECT 
    SP.LoaiSP, 
    SUM(CTHD.ThanhTien) AS DoanhThuTungLoai,
    CAST(SUM(CTHD.ThanhTien) * 100.0 / SUM(SUM(CTHD.ThanhTien)) OVER() AS DECIMAL(18, 2)) AS PhanTram
FROM CHITIET_HOADON CTHD
JOIN SANPHAM SP ON CTHD.MaSP = SP.MaSP
GROUP BY SP.LoaiSP
ORDER BY PhanTram DESC;