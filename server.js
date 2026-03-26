const express = require('express');
const cors = require('cors');
const sqlite3 = require('sqlite3');
const { open } = require('sqlite');
const fs = require('fs');

const app = express();
app.use(cors());
app.use(express.json());
app.use(express.static(__dirname)); 

let db;

// Hàm khởi tạo Database
async function initDB() {
    db = await open({ filename: './database.db', driver: sqlite3.Database });
    
    // KÍCH HOẠT KHÓA NGOẠI (Foreign Keys) - Quan trọng để CASCADE hoạt động
    await db.get("PRAGMA foreign_keys = ON");
    
    // Đọc và thực thi file SQL khởi tạo
    const sqlFile = fs.readFileSync('QuanLyCuaHangQuanAo.sql').toString();
    const cleanSql = sqlFile.replace(/\bGO\b/g, ';').replace(/N'/g, "'").replace(/GETDATE\(\)/g, "CURRENT_TIMESTAMP");
    await db.exec(cleanSql);
    console.log("Database online & Ràng buộc liên kết đã sẵn sàng!");
}

// --- API LẤY DỮ LIỆU (GET) - Đã thêm ORDER BY để Mã luôn xếp đúng thứ tự ---
app.get('/api/sp', async (req, res) => { 
    try {
        const data = await db.all("SELECT * FROM SANPHAM ORDER BY MaSP ASC");
        res.json(data); 
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.get('/api/nv', async (req, res) => { 
    try {
        const data = await db.all("SELECT * FROM NHANVIEN ORDER BY MaNV ASC");
        res.json(data); 
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.get('/api/kh', async (req, res) => { 
    try {
        const data = await db.all("SELECT * FROM KHACHHANG ORDER BY MaKH ASC");
        res.json(data); 
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.get('/api/hd', async (req, res) => { 
    try {
        const data = await db.all("SELECT * FROM HOADON ORDER BY MaHD ASC");
        res.json(data); 
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// --- API THÊM MỚI (POST) ---
app.post('/api/sp', async (req, res) => {
    const { MaSP, TenSP, LoaiSP, GiaNhap, GiaBan, SoLuongTon, XuatXu, MaNCC } = req.body;
    try {
        await db.run(`INSERT INTO SANPHAM VALUES (?, ?, ?, ?, ?, ?, ?, ?)`, 
        [MaSP, TenSP, LoaiSP, GiaNhap, GiaBan, SoLuongTon, XuatXu, MaNCC]);
        res.json({ message: "Thêm sản phẩm thành công!" });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.post('/api/nv', async (req, res) => {
    const { MaNV, TenNV, SDTNV, ChucVu, GioiTinh, eMail, NgayVaoLam, MaLuong } = req.body;
    try {
        await db.run(`INSERT INTO NHANVIEN VALUES (?, ?, ?, ?, ?, ?, ?, ?)`, 
        [MaNV, TenNV, SDTNV, ChucVu, GioiTinh, eMail, NgayVaoLam, MaLuong]);
        res.json({ message: "Thêm nhân viên thành công!" });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.post('/api/kh', async (req, res) => {
    const { MaKH, TenKH, SDTKH, DiaChi, NgaySinh, GioiTinh, MaNV } = req.body;
    try {
        await db.run(`INSERT INTO KHACHHANG VALUES (?, ?, ?, ?, ?, ?, ?)`, 
        [MaKH, TenKH, SDTKH, DiaChi, NgaySinh, GioiTinh, MaNV]);
        res.json({ message: "Thêm khách hàng thành công!" });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.post('/api/hd', async (req, res) => {
    const { MaHD, NgayTao, ThanhTien, TienThua, MaNV, MaKH } = req.body;
    try {
        await db.run(`INSERT INTO HOADON (MaHD, NgayTao, ThanhTien, TienThua, MaNV, MaKH) VALUES (?, ?, ?, ?, ?, ?)`, 
        [MaHD, NgayTao, ThanhTien, TienThua, MaNV, MaKH]);
        res.json({ message: "Thêm hóa đơn thành công!" });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// --- API CẬP NHẬT (PUT) - Cho phép cập nhật cả Mã nhờ cơ chế UPDATE CASCADE trong SQL ---
app.put('/api/:table/:id', async (req, res) => {
    const { table, id } = req.params; // id là Mã cũ của bản ghi
    const b = req.body;
    try {
        let query = "";
        let params = [];
        if (table === 'sp') {
            query = `UPDATE SANPHAM SET MaSP=?, TenSP=?, LoaiSP=?, GiaNhap=?, GiaBan=?, SoLuongTon=?, XuatXu=?, MaNCC=? WHERE MaSP=?`;
            params = [b.MaSP, b.TenSP, b.LoaiSP, b.GiaNhap, b.GiaBan, b.SoLuongTon, b.XuatXu, b.MaNCC, id];
        } else if (table === 'nv') {
            query = `UPDATE NHANVIEN SET MaNV=?, TenNV=?, SDTNV=?, ChucVu=?, GioiTinh=?, eMail=?, NgayVaoLam=?, MaLuong=? WHERE MaNV=?`;
            params = [b.MaNV, b.TenNV, b.SDTNV, b.ChucVu, b.GioiTinh, b.eMail, b.NgayVaoLam, b.MaLuong, id];
        } else if (table === 'kh') {
            query = `UPDATE KHACHHANG SET MaKH=?, TenKH=?, SDTKH=?, DiaChi=?, NgaySinh=?, GioiTinh=?, MaNV=? WHERE MaKH=?`;
            params = [b.MaKH, b.TenKH, b.SDTKH, b.DiaChi, b.NgaySinh, b.GioiTinh, b.MaNV, id];
        } else if (table === 'hd') {
            query = `UPDATE HOADON SET MaHD=?, NgayTao=?, ThanhTien=?, TienThua=?, MaNV=?, MaKH=? WHERE MaHD=?`;
            params = [b.MaHD, b.NgayTao, b.ThanhTien, b.TienThua, b.MaNV, b.MaKH, id];
        }
        await db.run(query, params);
        res.json({ message: "Cập nhật dữ liệu thành công!" });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// --- API XÓA (DELETE) ---
app.delete('/api/:table/:id', async (req, res) => {
    const { table, id } = req.params;
    let query = "";
    if (table === 'sp') query = `DELETE FROM SANPHAM WHERE MaSP = ?`;
    else if (table === 'nv') query = `DELETE FROM NHANVIEN WHERE MaNV = ?`;
    else if (table === 'kh') query = `DELETE FROM KHACHHANG WHERE MaKH = ?`;
    else if (table === 'hd') query = `DELETE FROM HOADON WHERE MaHD = ?`;

    try {
        await db.run(query, [id]);
        res.json({ message: "Xóa thành công!" });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.get('/', (req, res) => { res.sendFile(__dirname + '/index.html'); });

// Khởi chạy server
app.listen(5000, async () => {
    await initDB();
    console.log("-----------------------------------------");
    console.log("Server đang chạy tại port 5000");
    console.log("Truy cập web tại link Codespaces của bạn");
    console.log("-----------------------------------------");
});