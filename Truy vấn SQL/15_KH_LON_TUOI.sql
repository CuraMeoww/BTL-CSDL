--Liệt kê khách hàng có tuổi lớn hơn ít nhất 5 khách hàng còn lại


SELECT * FROM KHACHHANG
WHERE NgaySinh < (
    SELECT MIN(NgaySinh)
    FROM (
        SELECT TOP 5 NgaySinh
        FROM KHACHHANG
        ORDER BY NgaySinh DESC
    ) AS Top5TreNhat
)
ORDER BY NgaySinh ASC;