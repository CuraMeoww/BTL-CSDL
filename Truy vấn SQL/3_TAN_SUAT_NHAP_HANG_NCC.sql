--Xuất ra tần suất nhập hàng của từng nhà cung cấp và tổng giá trị nhập

SELECT NCC.MaNCC, NCC.TenNCC, 
       COUNT(PN.MaPN) AS SoLanNhapHang, 
       SUM(PN.TongTienNhap) AS TongGiaTriNhap
FROM NHACUNGCAP NCC LEFT JOIN PHIEUNHAP PN 
ON NCC.MaNCC = PN.MaNCC
GROUP BY NCC.MaNCC, NCC.TenNCC
