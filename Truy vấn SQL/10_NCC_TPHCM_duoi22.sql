--Xuất ra thông tin của nhà cung cấp ở TP HCM và có số điện thoại đuôi 22

SELECT MaNCC, TenNCC, SDTNCC, DiachiNCC 
FROM NHACUNGCAP 
WHERE DiachiNCC 
LIKE N'%TP HCM%' 
AND SDTNCC LIKE '%22';
