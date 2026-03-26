--Xuất ra tên và sđt khách hàng có địa chỉ ở Bắc Ninh hoặc Hà Nội mà có năm sinh >= 2006

SELECT TenKH, SDTKH, DiaChi, NgaySinh 
FROM KHACHHANG 
WHERE (DiaChi LIKE N'%Hà Nội%' 
OR DiaChi LIKE N'%Bắc Ninh%') 
AND YEAR(NgaySinh) >= 2006;