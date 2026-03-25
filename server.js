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
    const sqlFile = fs.readFileSync('QuanLyCuaHangQuanAo.sql').toString();
    // Làm sạch SQL: thay GO bằng ;, hỗ trợ tiếng Việt N', GETDATE() sang SQLite
    const cleanSql = sqlFile.replace(/\bGO\b/g, ';').replace(/N'/g, "'").replace(/GETDATE\(\)/g, "CURRENT_TIMESTAMP");
    await db.exec(cleanSql);
    console.log("Database online đã sẵn sàng!");
}

// --- API SẢN PHẨM ---
app.get('/api/sp', async (req, res) => {
    try {
        const data = await db.all("SELECT * FROM SANPHAM");
        res.json(data);
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.post('/api/sp', async (req, res) => {
    const { MaSP, TenSP, LoaiSP, GiaNhap, GiaBan, SoLuongTon } = req.body;
    try {
        await db.run(`INSERT INTO SANPHAM VALUES (?, ?, ?, ?, ?, ?)`, [MaSP, TenSP, LoaiSP, GiaNhap, GiaBan, SoLuongTon]);
        res.json({ message: "Thêm thành công!" });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// --- API NHÂN VIÊN ---
app.get('/api/nv', async (req, res) => {
    try {
        const data = await db.all("SELECT * FROM NHANVIEN");
        res.json(data);
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.post('/api/nv', async (req, res) => {
    const { MaNV, TenNV, SDTNV, ChucVu, eMail } = req.body;
    try {
        await db.run(`INSERT INTO NHANVIEN VALUES (?, ?, ?, ?, ?)`, [MaNV, TenNV, SDTNV, ChucVu, eMail]);
        res.json({ message: "Thêm nhân viên thành công!" });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// --- API KHÁCH HÀNG ---
app.get('/api/kh', async (req, res) => {
    try {
        const data = await db.all("SELECT * FROM KHACHHANG");
        res.json(data);
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.post('/api/kh', async (req, res) => {
    const { MaKH, TenKH, SDTKH, DiaChi, GioiTinh } = req.body;
    try {
        await db.run(`INSERT INTO KHACHHANG VALUES (?, ?, ?, ?, ?)`, [MaKH, TenKH, SDTKH, DiaChi, GioiTinh]);
        res.json({ message: "Thêm khách hàng thành công!" });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// --- API HÓA ĐƠN ---
app.get('/api/hd', async (req, res) => {
    try {
        // Lấy tất cả các cột để index.html tự chọn NgayLap/NgayBan
        const data = await db.all("SELECT * FROM HOADON");
        res.json(data);
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.post('/api/hd', async (req, res) => {
    const { MaHD, NgayLap, TongTien, MaNV, MaKH } = req.body;
    try {
        // Lưu ý: Nếu trong SQL của bạn tên cột là NgayBan/TriGia thì vẫn chèn theo thứ tự bảng
        await db.run(`INSERT INTO HOADON VALUES (?, ?, ?, ?, ?)`, [MaHD, NgayLap, TongTien, MaNV, MaKH]);
        res.json({ message: "Thêm hóa đơn thành công!" });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// --- API XÓA CHUNG ---
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

// Trang chủ
app.get('/', (req, res) => {
    res.sendFile(__dirname + '/index.html');
});

// Chạy server
app.listen(5000, async () => {
    await initDB();
    console.log("Server đang chạy tại port 5000");
});