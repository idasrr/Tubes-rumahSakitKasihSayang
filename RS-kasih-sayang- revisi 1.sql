use rsks

CREATE TABLE Poli (
    ID_Poli VARCHAR(10) PRIMARY KEY,
    Deskripsi TEXT,
    NamaPoli VARCHAR(100) NOT NULL,
    LokasiPoli VARCHAR(100) not null
) engine = innoDB

CREATE TABLE Pasien (
    NIK_Pasien VARCHAR(20) PRIMARY KEY,
    Nama VARCHAR(100) NOT NULL,
    Alamat TEXT,
    Email VARCHAR(100),
    JenisKelamin ENUM('L', 'P') NOT NULL,
    NomorHP VARCHAR(15),
    Password VARCHAR(10) not null,
    tempatTanggalLahir VARCHAR(100) not null,
    GolonganDarah ENUM ('A', 'B', 'AB', 'O', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-') DEFAULT null
) engine = innoDB

CREATE TABLE Dokter (
    NIK_Dokter VARCHAR(20) PRIMARY KEY,
    ID_Poli VARCHAR(10),
    Nama VARCHAR(100) NOT NULL,
    Alamat TEXT,
    Email VARCHAR(100),
    JenisKelamin ENUM('L', 'P') NOT NULL,
    NomorHP VARCHAR(15),
    tempatTanggalLahir varchar(100),
    StatusDokter ENUM('Aktif', 'Tidak Aktif') DEFAULT 'Aktif',
    TahunPengalaman INT,
      FOREIGN KEY (ID_Poli) REFERENCES Poli(ID_Poli)
) engine = innoDB

CREATE TABLE Spesialisasi (
    ID_Spesialisasi VARCHAR(10) PRIMARY KEY,
    NIK_Dokter VARCHAR(20),
    Nama VARCHAR(100) NOT NULL,
    JenisSpesialisasi VARCHAR(100) not null,
    FOREIGN KEY (NIK_Dokter) REFERENCES Dokter(NIK_Dokter)
) engine = innoDB

CREATE TABLE Jadwal_Praktek (
    ID_Jadwal VARCHAR(10) PRIMARY KEY,
    NIK_Dokter VARCHAR(20),
    Hari VARCHAR(10) NOT NULL,
    JamMulai TIME,
    JamSelesai TIME,
    MaksimalPasien INT,
    Status ENUM('Aktif', 'Tidak Aktif') DEFAULT 'Aktif',
    FOREIGN KEY (NIK_Dokter) REFERENCES Dokter(NIK_Dokter)
) engine = innoDB


CREATE TABLE Pendaftaran (
    ID_Pendaftaran VARCHAR(10) PRIMARY KEY,
    NIK_Pasien VARCHAR(20),
    ID_Jadwal VARCHAR(10),
    NomorAntrian INT,
    TanggalDaftar DATE,
    StatusDaftar ENUM('Pending', 'Confirmed', 'Cancelled') DEFAULT 'Pending',
    KeluhanAwal TEXT,
    FOREIGN KEY (NIK_Pasien) REFERENCES Pasien(NIK_Pasien),
    FOREIGN KEY (ID_Jadwal) REFERENCES Jadwal_Praktek(ID_Jadwal)
) engine = innoDB

CREATE TABLE Pembayaran (
    ID_Pembayaran VARCHAR(10) PRIMARY KEY,
    ID_Pendaftaran VARCHAR(10),
    RincianBiaya DECIMAL(10,2),
    TanggalBayar DATE,
    MetodeBayar ENUM('Cash', 'Transfer', 'Kartu Kredit', 'BPJS'),
    FOREIGN KEY (ID_Pendaftaran) REFERENCES Pendaftaran(ID_Pendaftaran)
) engine = innoDB

CREATE TABLE Rekam_Medis (
    ID_Rekam_Medis VARCHAR(10) PRIMARY KEY,
    ID_Pendaftaran VARCHAR(10),
    Diagnosis TEXT,
    TindakanMedis TEXT,
    ResepObat TEXT,
    FOREIGN KEY (ID_Pendaftaran) REFERENCES Pendaftaran(ID_Pendaftaran)
) engine = innoDB

CREATE TABLE Resep_Obat (
    ID_Resep_Obat VARCHAR(10) PRIMARY KEY,
    ID_Rekam_Medis VARCHAR(10),
    NamaObat VARCHAR(100) NOT NULL,
    DosisObat VARCHAR(50),
    FrekuensiPemakaian VARCHAR(50),
    DurasiPemakaian VARCHAR(50),
    JumlahObatDiresepkan INT,
    InstruksiTambahan TEXT,
    FOREIGN KEY (ID_Rekam_Medis) REFERENCES Rekam_Medis(ID_Rekam_Medis)
) engine = innoDB

show tables

INSERT INTO Poli (ID_Poli, Deskripsi, NamaPoli, LokasiPoli) VALUES
('P001', 'Poli untuk pemeriksaan umum dan konsultasi kesehatan dasar', 'Poli Umum', 'Lantai 1 Gedung A'),
('P002', 'Poli untuk pemeriksaan dan perawatan anak', 'Poli Anak', 'Lantai 2 Gedung A'),
('P003', 'Poli untuk pemeriksaan mata dan gangguan penglihatan', 'Poli Mata', 'Lantai 1 Gedung B'),
('P004', 'Poli untuk pemeriksaan jantung dan pembuluh darah', 'Poli Jantung', 'Lantai 3 Gedung B'),
('P005', 'Poli untuk pemeriksaan kulit dan kelamin', 'Poli Kulit', 'Lantai 2 Gedung B'),
('P006', 'Pemeriksaan mata dan pengobatan.', 'Poli Mata', 'Lantai 1 - Gedung B'),
('P007', 'Pemeriksaan telinga, hidung, tenggorokan.', 'Poli THT', 'Lantai 2 - Gedung C'),
('P008', 'Pelayanan dan konsultasi kejiwaan.', 'Poli Psikiatri', 'Lantai 4 - Gedung D'),
('P009', 'Pemeriksaan kulit dan kelamin.', 'Poli Kulit dan Kelamin', 'Lantai 3 - Gedung B'),
('P010', 'Pelayanan kesehatan lansia.', 'Poli Geriatri', 'Lantai 1 - Gedung A'),
('P011', 'Konsultasi dan terapi untuk nyeri.', 'Poli Nyeri', 'Lantai 2 - Gedung C'),
('P012', 'Pelayanan kesehatan paru-paru.', 'Poli Paru', 'Lantai 3 - Gedung D'),
('P013', 'Pelayanan rawat luka dan perawatan umum.', 'Poli Luka', 'Lantai 1 - Gedung B'),
('P014', 'Konsultasi kesehatan reproduksi.', 'Poli Reproduksi', 'Lantai 3 - Gedung C'),
('P015', 'Pelayanan untuk pasien dengan kebutuhan khusus.', 'Poli Rehabilitasi Medis', 'Lantai 2 - Gedung A'),
('P016', 'Konsultasi gizi dan nutrisi.', 'Poli Gizi', 'Lantai 1 - Gedung D'),
('P017', 'Pemeriksaan dan terapi alergi.', 'Poli Alergi', 'Lantai 2 - Gedung B'),
('P018', 'Pengobatan tradisional dan akupuntur.', 'Poli Akupuntur', 'Lantai 3 - Gedung A'),
('P019', 'Deteksi dini dan pencegahan penyakit.', 'Poli Promkes', 'Lantai 4 - Gedung B'),
('P020', 'Kontrol tekanan darah tinggi.', 'Poli Hipertensi', 'Lantai 1 - Gedung C'),
('P021', 'Penanganan diabetes.', 'Poli Diabetes', 'Lantai 1 - Gedung D'),
('P022', 'Pemeriksaan jantung dan pembuluh darah.', 'Poli Jantung', 'Lantai 2 - Gedung A'),
('P023', 'Pemeriksaan kelainan darah.', 'Poli Hematologi', 'Lantai 3 - Gedung B'),
('P024', 'Pemeriksaan ginjal dan saluran kemih.', 'Poli Urologi', 'Lantai 3 - Gedung C'),
('P025', 'Pelayanan bedah ringan.', 'Poli Bedah', 'Lantai 2 - Gedung D'),
('P026', 'Konsultasi tumbuh kembang anak.', 'Poli Tumbuh Kembang', 'Lantai 1 - Gedung A'),
('P027', 'Pemeriksaan penyakit menular.', 'Poli Infeksi', 'Lantai 4 - Gedung C'),
('P028', 'Gangguan hormonal.', 'Poli Endokrin', 'Lantai 2 - Gedung B'),
('P029', 'Pemeriksaan sistem pencernaan.', 'Poli Gastroenterologi', 'Lantai 3 - Gedung D'),
('P030', 'Kesehatan remaja.', 'Poli Remaja', 'Lantai 1 - Gedung B'),
('P031', 'Tulang dan sendi.', 'Poli Orthopedi', 'Lantai 2 - Gedung C'),
('P032', 'Sistem saraf.', 'Poli Saraf', 'Lantai 3 - Gedung A'),
('P033', 'Pemeriksaan kanker wanita.', 'Poli Onkologi', 'Lantai 4 - Gedung D'),
('P034', 'Terapi autisme.', 'Poli Autisme', 'Lantai 2 - Gedung B'),
('P035', 'Konsultasi laboratorium.', 'Poli Laboratorium', 'Lantai 1 - Gedung C'),
('P036', 'Penanganan luka bakar.', 'Poli Luka Bakar', 'Lantai 3 - Gedung B'),
('P037', 'Evaluasi radiologi.', 'Poli Radiologi', 'Lantai 1 - Gedung A'),
('P038', 'Gangguan tidur.', 'Poli Tidur', 'Lantai 2 - Gedung D'),
('P039', 'Pelayanan HIV/AIDS.', 'Poli VCT', 'Lantai 4 - Gedung B'),
('P040', 'Pemeriksaan kehamilan.', 'Poli Kehamilan', 'Lantai 3 - Gedung C'),
('P041', 'Kesehatan seksual.', 'Poli Seksologi', 'Lantai 2 - Gedung A'),
('P042', 'Manajemen nyeri tulang belakang.', 'Poli Spine', 'Lantai 3 - Gedung D'),
('P043', 'Kesehatan kerja.', 'Poli Kesehatan Kerja', 'Lantai 1 - Gedung B'),
('P044', 'Vaksinasi dan imunisasi.', 'Poli Imunisasi', 'Lantai 1 - Gedung D'),
('P045', 'Keluarga berencana.', 'Poli KB', 'Lantai 1 - Gedung A'),
('P046', 'Konseling sosial dan psikologi.', 'Poli Konseling', 'Lantai 4 - Gedung C'),
('P047', 'Disfungsi seksual pria.', 'Poli Andrologi', 'Lantai 2 - Gedung B'),
('P048', 'Gangguan bicara.', 'Poli Terapi Wicara', 'Lantai 3 - Gedung A'),
('P049', 'Pelayanan keperawatan.', 'Poli Keperawatan', 'Lantai 1 - Gedung C'),
('P050', 'Layanan kesehatan digital.', 'Poli Telemedis', 'Lantai 4 - Gedung D');


INSERT INTO Pasien (NIK_Pasien, Nama, Alamat, Email, JenisKelamin, NomorHP, Password, tempatTanggalLahir, GolonganDarah) VALUES
('3201012801900001', 'Ahmad Fauzi', 'Jl. Merdeka No. 123, Bandung', 'ahmad.fauzi@gmail.com', 'L', '081234567890', 'pass123', '1990-01-28', 'A-'),
('3201012802850002', 'Siti Nurhaliza', 'Jl. Sudirman No. 456, Malang', 'siti.nurhaliza@gmail.com', 'P', '081234567891', 'pass456', '1985-02-28', 'B'),
('3201012803920003', 'Budi Santoso', 'Jl. Gatot Subroto No. 789, Surabaya', 'budi.santoso@gmail.com', 'L', '081234567892', 'pass789', '1992-03-28', 'O'),
('3201012804880004', 'Rina Wulandari', 'Jl. Thamrin No. 321, Yogyakarta', 'rina.wulandari@gmail.com', 'P', '081234567893', 'pass321', '1988-04-28', 'AB'),
('3201012805750005', 'Hendra Gunawan', 'Jl. Kuningan No. 654, Jakarta', 'hendra.gunawan@gmail.com', 'L', '081234567894', 'pass654', '2000-05-28', 'A'),
('3174010101010001', 'Ahmad Fauzi', 'Jl. Merdeka No. 1, Jakarta', 'ahmad.fauzi@mail.com', 'L', '081234567001', 'pass123', 'Jakarta, 01-01-1990', 'A'),
('3174010101010002', 'Siti Aminah', 'Jl. Mawar No. 2, Bandung', 'siti.aminah@mail.com', 'P', '081234567002', 'pass123', 'Bandung, 02-02-1991', 'B'),
('3174010101010003', 'Budi Santoso', 'Jl. Melati No. 3, Surabaya', 'budi.santoso@mail.com', 'L', '081234567003', 'pass123', 'Surabaya, 03-03-1992', 'O'),
('3174010101010004', 'Rina Kartika', 'Jl. Kenanga No. 4, Medan', 'rina.kartika@mail.com', 'P', '081234567004', 'pass123', 'Medan, 04-04-1993', 'AB'),
('3174010101010005', 'Dedi Hermawan', 'Jl. Sakura No. 5, Yogyakarta', 'dedi.hermawan@mail.com', 'L', '081234567005', 'pass123', 'Yogyakarta, 05-05-1994', 'A'),
('3174010101010006', 'Lina Agustina', 'Jl. Teratai No. 6, Semarang', 'lina.agustina@mail.com', 'P', '081234567006', 'pass123', 'Semarang, 06-06-1995', 'B'),
('3174010101010007', 'Eko Prasetyo', 'Jl. Flamboyan No. 7, Malang', 'eko.prasetyo@mail.com', 'L', '081234567007', 'pass123', 'Malang, 07-07-1996', 'O'),
('3174010101010008', 'Rani Putri', 'Jl. Cemara No. 8, Depok', 'rani.putri@mail.com', 'P', '081234567008', 'pass123', 'Depok, 08-08-1997', 'AB'),
('3174010101010009', 'Agus Wibowo', 'Jl. Anggrek No. 9, Bekasi', 'agus.wibowo@mail.com', 'L', '081234567009', 'pass123', 'Bekasi, 09-09-1998', 'A'),
('3174010101010010', 'Yulianti', 'Jl. Dahlia No. 10, Bogor', 'yulianti@mail.com', 'P', '081234567010', 'pass123', 'Bogor, 10-10-1999', 'B'),
('3174010101010011', 'Hadi Susanto', 'Jl. Kamboja No. 11, Jakarta', 'hadi.susanto@mail.com', 'L', '081234567011', 'pass123', 'Jakarta, 11-01-1990', 'O'),
('3174010101010012', 'Nina Septiani', 'Jl. Mawar No. 12, Bandung', 'nina.septiani@mail.com', 'P', '081234567012', 'pass123', 'Bandung, 12-02-1991', 'AB'),
('3174010101010013', 'Rizky Andika', 'Jl. Melati No. 13, Surabaya', 'rizky.andika@mail.com', 'L', '081234567013', 'pass123', 'Surabaya, 13-03-1992', 'A'),
('3174010101010014', 'Intan Permata', 'Jl. Kenanga No. 14, Medan', 'intan.permata@mail.com', 'P', '081234567014', 'pass123', 'Medan, 14-04-1993', 'B'),
('3174010101010015', 'Ari Wibisono', 'Jl. Sakura No. 15, Yogyakarta', 'ari.wibisono@mail.com', 'L', '081234567015', 'pass123', 'Yogyakarta, 15-05-1994', 'O'),
('3174010101010016', 'Salsa Amelia', 'Jl. Teratai No. 16, Semarang', 'salsa.amelia@mail.com', 'P', '081234567016', 'pass123', 'Semarang, 16-06-1995', 'AB'),
('3174010101010017', 'Hendra Gunawan', 'Jl. Flamboyan No. 17, Malang', 'hendra.gunawan@mail.com', 'L', '081234567017', 'pass123', 'Malang, 17-07-1996', 'A'),
('3174010101010018', 'Desi Marlina', 'Jl. Cemara No. 18, Depok', 'desi.marlina@mail.com', 'P', '081234567018', 'pass123', 'Depok, 18-08-1997', 'B'),
('3174010101010019', 'Wawan Setiawan', 'Jl. Anggrek No. 19, Bekasi', 'wawan.setiawan@mail.com', 'L', '081234567019', 'pass123', 'Bekasi, 19-09-1998', 'O'),
('3174010101010020', 'Dewi Sartika', 'Jl. Dahlia No. 20, Bogor', 'dewi.sartika@mail.com', 'P', '081234567020', 'pass123', 'Bogor, 20-10-1999', 'AB'),
('3174010101010021', 'Tommy Saputra', 'Jl. Cemara No. 21, Jakarta', 'tommy.saputra@mail.com', 'L', '081234567021', 'pass123', 'Jakarta, 21-01-1985', 'A'),
('3174010101010022', 'Ayu Lestari', 'Jl. Merpati No. 22, Bandung', 'ayu.lestari@mail.com', 'P', '081234567022', 'pass123', 'Bandung, 22-02-1986', 'B'),
('3174010101010023', 'Ilham Rizki', 'Jl. Elang No. 23, Surabaya', 'ilham.rizki@mail.com', 'L', '081234567023', 'pass123', 'Surabaya, 23-03-1987', 'O'),
('3174010101010024', 'Citra Melinda', 'Jl. Rajawali No. 24, Medan', 'citra.melinda@mail.com', 'P', '081234567024', 'pass123', 'Medan, 24-04-1988', 'AB'),
('3174010101010025', 'Reza Fadillah', 'Jl. Cendrawasih No. 25, Yogyakarta', 'reza.fadillah@mail.com', 'L', '081234567025', 'pass123', 'Yogyakarta, 25-05-1989', 'A'),
('3174010101010026', 'Tina Mawarni', 'Jl. Jambu No. 26, Semarang', 'tina.mawarni@mail.com', 'P', '081234567026', 'pass123', 'Semarang, 26-06-1990', 'B'),
('3174010101010027', 'Fajar Nugroho', 'Jl. Mangga No. 27, Malang', 'fajar.nugroho@mail.com', 'L', '081234567027', 'pass123', 'Malang, 27-07-1991', 'O'),
('3174010101010028', 'Mega Sari', 'Jl. Durian No. 28, Depok', 'mega.sari@mail.com', 'P', '081234567028', 'pass123', 'Depok, 28-08-1992', 'AB'),
('3174010101010029', 'Andi Rahman', 'Jl. Rambutan No. 29, Bekasi', 'andi.rahman@mail.com', 'L', '081234567029', 'pass123', 'Bekasi, 29-09-1993', 'A'),
('3174010101010030', 'Nur Aini', 'Jl. Kedondong No. 30, Bogor', 'nur.aini@mail.com', 'P', '081234567030', 'pass123', 'Bogor, 30-10-1994', 'B'),
('3174010101010031', 'Galih Pramana', 'Jl. Apel No. 31, Jakarta', 'galih.pramana@mail.com', 'L', '081234567031', 'pass123', 'Jakarta, 31-01-1980', 'O'),
('3174010101010032', 'Shinta Dewi', 'Jl. Pepaya No. 32, Bandung', 'shinta.dewi@mail.com', 'P', '081234567032', 'pass123', 'Bandung, 01-02-1981', 'AB'),
('3174010101010033', 'Dian Saputra', 'Jl. Pisang No. 33, Surabaya', 'dian.saputra@mail.com', 'L', '081234567033', 'pass123', 'Surabaya, 02-03-1982', 'A'),
('3174010101010034', 'Tari Oktaviani', 'Jl. Sawo No. 34, Medan', 'tari.oktaviani@mail.com', 'P', '081234567034', 'pass123', 'Medan, 03-04-1983', 'B'),
('3174010101010035', 'Yusuf Ibrahim', 'Jl. Nangka No. 35, Yogyakarta', 'yusuf.ibrahim@mail.com', 'L', '081234567035', 'pass123', 'Yogyakarta, 04-05-1984', 'O'),
('3174010101010036', 'Nadya Kamila', 'Jl. Duku No. 36, Semarang', 'nadya.kamila@mail.com', 'P', '081234567036', 'pass123', 'Semarang, 05-06-1985', 'AB'),
('3174010101010037', 'Rafi Maulana', 'Jl. Salak No. 37, Malang', 'rafi.maulana@mail.com', 'L', '081234567037', 'pass123', 'Malang, 06-07-1986', 'A'),
('3174010101010038', 'Yuni Rahmawati', 'Jl. Belimbing No. 38, Depok', 'yuni.rahmawati@mail.com', 'P', '081234567038', 'pass123', 'Depok, 07-08-1987', 'B'),
('3174010101010039', 'Oka Pratama', 'Jl. Kelapa No. 39, Bekasi', 'oka.pratama@mail.com', 'L', '081234567039', 'pass123', 'Bekasi, 08-09-1988', 'O'),
('3174010101010040', 'Fitriani Nur', 'Jl. Pinang No. 40, Bogor', 'fitriani.nur@mail.com', 'P', '081234567040', 'pass123', 'Bogor, 09-10-1989', 'AB'),
('3174010101010041', 'Bayu Saputro', 'Jl. Alpukat No. 41, Jakarta', 'bayu.saputro@mail.com', 'L', '081234567041', 'pass123', 'Jakarta, 10-11-1985', 'A'),
('3174010101010042', 'Nina Kartika', 'Jl. Ceri No. 42, Bandung', 'nina.kartika@mail.com', 'P', '081234567042', 'pass123', 'Bandung, 11-12-1986', 'B'),
('3174010101010043', 'Taufik Hidayat', 'Jl. Kedondong No. 43, Surabaya', 'taufik.hidayat@mail.com', 'L', '081234567043', 'pass123', 'Surabaya, 12-01-1987', 'O'),
('3174010101010044', 'Mira Widya', 'Jl. Beringin No. 44, Medan', 'mira.widya@mail.com', 'P', '081234567044', 'pass123', 'Medan, 13-02-1988', 'AB'),
('3174010101010045', 'Herman Wijaya', 'Jl. Pala No. 45, Yogyakarta', 'herman.wijaya@mail.com', 'L', '081234567045', 'pass123', 'Yogyakarta, 14-03-1989', 'A'),
('3174010101010046', 'Rosa Marlina', 'Jl. Jengkol No. 46, Semarang', 'rosa.marlina@mail.com', 'P', '081234567046', 'pass123', 'Semarang, 15-04-1990', 'B'),
('3174010101010047', 'Dimas Nugraha', 'Jl. Pete No. 47, Malang', 'dimas.nugraha@mail.com', 'L', '081234567047', 'pass123', 'Malang, 16-05-1991', 'O'),
('3174010101010048', 'Eva Meilani', 'Jl. Pare No. 48, Depok', 'eva.meilani@mail.com', 'P', '081234567048', 'pass123', 'Depok, 17-06-1992', 'AB'),
('3174010101010049', 'Angga Wirawan', 'Jl. Asam No. 49, Bekasi', 'angga.wirawan@mail.com', 'L', '081234567049', 'pass123', 'Bekasi, 18-07-1993', 'A'),
('3174010101010050', 'Yasmin Salsabila', 'Jl. Kweni No. 50, Bogor', 'yasmin.salsabila@mail.com', 'P', '081234567050', 'pass123', 'Bogor, 19-08-1994', 'B');

INSERT INTO Dokter (NIK_Dokter, ID_Poli, Nama, Alamat, Email, JenisKelamin, NomorHP, tempatTanggalLahir, StatusDokter, TahunPengalaman) VALUES
(3706728410708460, 'P003', 'Dr. Safina Halim', 'Jl. Ronggowarsito No. 803, Magelang, GO 30401', 'safina.halim@gmail.com', 'P', '+6287458450914', '1987-01-26', 'Aktif', 8),
(4438763380778257, 'P003', 'Dr. Dasa Latupono, S.E.I', 'Gang K.H. Wahid Hasyim No. 5, Probolinggo, BT 21370', 'dasa.latupono.s.e.i@gmail.com', 'L', '+62823922870', '1980-07-14', 'Aktif', 15),
(2299771729589752, 'P001', 'Dr. Lanjar Budiman', 'Gang Rumah Sakit No. 213, Yogyakarta, Kepulauan Bangka Belitung 78524', 'lanjar.budiman@gmail.com', 'P', '+6287630535', '1993-01-09', 'Aktif', 2),
(6068254841174653, 'P004', 'Dr. R.A. Shania Puspasari', 'Gang Cihampelas No. 398, Banjarbaru, LA 37016', 'r.a..shania.puspasari@gmail.com', 'L', '+6289078286', '1993-11-21', 'Aktif', 2),
(6307133663178831, 'P009', 'Dr. Azalea Wulandari', 'Jalan Jayawijaya No. 113, Salatiga, JT 76008', 'azalea.wulandari@gmail.com', 'L', '+6203179357867', '1991-11-28', 'Aktif', 4),
(9180284501531566, 'P004', 'Dr. drg. Cecep Wahyudin, M.Kom.', 'Jl. Ir. H. Djuanda No. 31, Sungai Penuh, GO 52936', 'drg..cecep.wahyudin.m.kom.@gmail.com', 'P', '0877125046', '1988-06-25', 'Aktif', 7),
(1603567409361384, 'P005', 'Dr. Ir. Kala Agustina', 'Jalan Kendalsari No. 578, Probolinggo, Banten 18711', 'ir..kala.agustina@gmail.com', 'P', '+629772876871', '1994-03-31', 'Aktif', 1),
(4518357744305768, 'P004', 'Dr. Cengkal Firgantoro', 'Jalan Veteran No. 768, Binjai, MU 70194', 'cengkal.firgantoro@gmail.com', 'P', '+628767002', '1993-11-10', 'Aktif', 2),
(3643051835755287, 'P008', 'Dr. Kania Nugroho', 'Jalan Rajiman No. 5, Banjarbaru, BE 15891', 'kania.nugroho@gmail.com', 'P', '+628664308290', '1990-03-17', 'Aktif', 5),
(3859839121583230, 'P003', 'Dr. Violet Kuswoyo', 'Gg. Dipenogoro No. 750, Palangkaraya, RI 12918', 'violet.kuswoyo@gmail.com', 'L', '0866097722', '1991-09-23', 'Aktif', 4),
(1821762107954240, 'P002', 'Dr. Hj. Talia Pangestu', 'Gang Cihampelas No. 7, Pematangsiantar, Kepulauan Bangka Belitung 56445', 'hj..talia.pangestu@gmail.com', 'P', '+6280220841680', '1988-03-09', 'Aktif', 7),
(9978301743844647, 'P003', 'Dr. Legawa Wulandari', 'Gang HOS. Cokroaminoto No. 5, Kota Administrasi Jakarta Selatan, MU 34532', 'legawa.wulandari@gmail.com', 'L', '+62871034984', '1991-01-27', 'Aktif', 4),
(2132994531219016, 'P007', 'Dr. Laila Setiawan', 'Jl. Pasirkoja No. 02, Banjarbaru, Papua Barat 86109', 'laila.setiawan@gmail.com', 'P', '+6289486192025', '1986-08-29', 'Tidak Aktif', 9),
(6220208464172846, 'P005', 'Dr. Nadine Sitorus', 'Gang Pacuan Kuda No. 651, Tasikmalaya, MA 30408', 'nadine.sitorus@gmail.com', 'P', '+628270541102', '1994-02-11', 'Aktif', 1),
(7665166417101356, 'P010', 'Dr. Aswani Wahyuni', 'Jl. Kutisari Selatan No. 92, Tidore Kepulauan, SU 12438', 'aswani.wahyuni@gmail.com', 'P', '+628786939836', '1980-08-18', 'Tidak Aktif', 15),
(2309225084677651, 'P008', 'Dr. Lidya Rajata', 'Jl. Suryakencana No. 07, Pontianak, KU 01960', 'lidya.rajata@gmail.com', 'P', '0822478218', '1986-02-11', 'Aktif', 9),
(2422469142282030, 'P007', 'Dr. T. Ozy Sinaga', 'Gg. Tubagus Ismail No. 03, Salatiga, Jawa Timur 19116', 't..ozy.sinaga@gmail.com', 'P', '0867607860', '1986-09-28', 'Aktif', 9),
(3192134544452200, 'P005', 'Dr. Zelaya Mulyani', 'Jalan Gegerkalong Hilir No. 33, Mataram, Sulawesi Barat 58788', 'zelaya.mulyani@gmail.com', 'P', '08535923367', '1990-04-10', 'Aktif', 5),
(2067064571558421, 'P008', 'Dr. Karsa Waskita, S.I.Kom', 'Jl. Ronggowarsito No. 852, Parepare, Maluku Utara 72371', 'karsa.waskita.s.i.kom@gmail.com', 'L', '+6285768542', '1992-02-22', 'Aktif', 3),
(3722899513977542, 'P003', 'Dr. Rizki Oktaviani', 'Gg. Cihampelas No. 3, Madiun, KU 96859', 'rizki.oktaviani@gmail.com', 'L', '08341983717', '1990-07-26', 'Aktif',5),
(3561054070799984, 'P008', 'Dr. R.A. Hani Hasanah', 'Jl. Dipatiukur No. 93, Cilegon, Papua Barat 76735', 'r.a..hani.hasanah@gmail.com', 'L', '+6287974230', '1984-12-30', 'Aktif', 11),
(5491320015149600, 'P007', 'Dr. drg. Najwa Wibowo', 'Gg. Kapten Muslihat No. 03, Palangkaraya, Jawa Timur 79906', 'drg..najwa.wibowo@gmail.com', 'L', '+62837594399', '1987-11-14', 'Aktif', 8),
(3236874597445544, 'P004', 'Dr. Karja Waluyo, S.Kom', 'Jl. Moch. Ramdan No. 0, Sukabumi, Nusa Tenggara Timur 64859', 'karja.waluyo.s.kom@gmail.com', 'L', '0890727410', '1983-10-19', 'Tidak Aktif', 12),
(1360159815088780, 'P009', 'Dr. Hana Sudiati', 'Jalan Antapani Lama No. 72, Tarakan, Aceh 98826', 'hana.sudiati@gmail.com', 'L', '+6287223363', '1990-10-28', 'Aktif', 5),
(8478807080465322, 'P001', 'Dr. Harja Wijaya, S.Sos', 'Gang Moch. Toha No. 791, Pekanbaru, KS 08840', 'harja.wijaya.s.sos@gmail.com', 'L', '+6281677470139', '1980-08-18', 'Tidak Aktif', 15),
(3736491059387433, 'P008', 'Dr. Melinda Kusumo', 'Jalan Ciumbuleuit No. 744, Tangerang, Kalimantan Timur 50960', 'melinda.kusumo@gmail.com', 'P', '+6283990732', '1980-08-15', 'Aktif', 15),
(6208153221385389, 'P010', 'Dr. Drs. Ade Handayani, M.Pd', 'Gg. Kutai No. 38, Batu, Banten 44273', 'drs..ade.handayani.m.pd@gmail.com', 'P', '0816351545', '1987-08-20', 'Aktif', 8),
(2414865760986573, 'P007', 'Dr. Yunita Saptono', 'Jl. Raya Ujungberung No. 2, Sukabumi, Kalimantan Barat 33821', 'yunita.saptono@gmail.com', 'P', '+62876998154', '1983-02-05', 'Tidak Aktif', 12),
(6281153986692990, 'P003', 'Dr. Hj. Dinda Marpaung', 'Jalan Yos Sudarso No. 1, Manado, KR 53484', 'hj..dinda.marpaung@gmail.com', 'L', '+62893161445', '1992-06-03', 'Aktif', 3),
(9627909439392755, 'P001', 'Dr. Dt. Harsaya Sihotang', 'Gg. Medokan Ayu No. 2, Bontang, GO 29314', 'dt..harsaya.sihotang@gmail.com', 'L', '+6281611109', '1988-01-13', 'Aktif', 7),
(6743552279200699, 'P001', 'Dr. Wulan Maryati', 'Jl. Sadang Serang No. 6, Bandar Lampung, Sulawesi Tenggara 02079', 'wulan.maryati@gmail.com', 'L', '086626661', '1990-05-30', 'Aktif', 5),
(5129068825753730, 'P006', 'Dr. Genta Permata', 'Gg. Wonoayu No. 1, Depok, LA 60014', 'genta.permata@gmail.com', 'P', '+6286545012', '1982-07-22', 'Aktif', 13),
(2284493192906774, 'P008', 'Dr. Rahman Laksmiwati', 'Jalan Suryakencana No. 59, Surakarta, Nusa Tenggara Timur 85533', 'rahman.laksmiwati@gmail.com', 'P', '+62853468245', '1982-12-26', 'Tidak Aktif', 13),
(6948439348797963, 'P003', 'Dr. Yulia Sinaga', 'Gang Cihampelas No. 6, Palu, BE 43106', 'yulia.sinaga@gmail.com', 'L', '085346598', '1992-06-07', 'Aktif', 3),
(6902252520786465, 'P008', 'Dr. Cornelia Budiyanto', 'Gg. Medokan Ayu No. 80, Batu, MA 03521', 'cornelia.budiyanto@gmail.com', 'L', '0871302702', '1987-01-07', 'Aktif', 8),
(1954900446085735, 'P007', 'Dr. Eva Mayasari, M.TI.', 'Jl. Cikapayang No. 03, Banjarmasin, Lampung 24996', 'eva.mayasari.m.ti.@gmail.com', 'L', '+6287650028', '1993-09-18', 'Aktif', 2),
(9508063623971414, 'P010', 'Dr. Jail Waluyo', 'Jalan Waringin No. 2, Tegal, Jawa Tengah 88776', 'jail.waluyo@gmail.com', 'P', '+62892818103', '1987-07-29', 'Aktif', 8),
(4894529552802774, 'P006', 'Dr. dr. Paulin Setiawan, M.Ak', 'Gang Lembong No. 717, Tasikmalaya, PA 58464', 'paulin.setiawan.m.ak@gmail.com', 'L', '+62863570411', '1981-10-02', 'Aktif', 14),
(9651576011074704, 'P001', 'Dr. Zizi Najmudin', 'Gg. Veteran No. 4, Pekanbaru, JA 61581', 'zizi.najmudin@gmail.com', 'P', '+6287211863', '1981-04-02', 'Tidak Aktif', 14),
(9183191447489863, 'P003', 'Dr. Satya Widodo', 'Jl. Cihampelas No. 12, Subulussalam, GO 64932', 'satya.widodo@gmail.com', 'L', '+6286543162', '1989-02-02', 'Aktif', 6),
(7274174256919996, 'P009', 'Dr. Hj. Devi Padmasari, S.E.', 'Jalan Astana Anyar No. 027, Ternate, Kepulauan Riau 66557', 'hj..devi.padmasari.s.e.@gmail.com', 'P', '0871359077', '1993-07-11', 'Aktif', 2),
(5072854386333782, 'P005', 'Dr. Dalima Andriani', 'Gg. Laswi No. 9, Bekasi, BE 36823', 'dalima.andriani@gmail.com', 'L', '0893557232', '1987-06-03', 'Aktif', 8),
(6455376804072226, 'P004', 'Dr. Salimah Ramadan', 'Gg. Erlangga No. 37, Bogor, SS 57800', 'salimah.ramadan@gmail.com', 'P', '+6287617648', '1990-10-28', 'Aktif', 5),
(4715835249771642, 'P007', 'Dr. Yuliana Tamba', 'Gg. Suryakencana No. 8, Kupang, Nusa Tenggara Timur 92726', 'yuliana.tamba@gmail.com', 'P', '08317007', '1987-07-02', 'Aktif', 8),
(7606864379996648, 'P010', 'Dr. Devi Situmorang, S.Sos', 'Gg. Bangka Raya No. 51, Surabaya, KU 70831', 'devi.situmorang.s.sos@gmail.com', 'L', '+62878130877', '1983-04-28', 'Tidak Aktif', 12),
(7938061304154830, 'P004', 'Dr. Kartika Nasyidah', 'Jl. BKR No. 782, Pagaralam, BE 57968', 'kartika.nasyidah@gmail.com', 'L', '+6287131977', '1993-08-30', 'Aktif', 2),
(9192766826189351, 'P006', 'Dr. dr. Uda Nasyidah', 'Jl. Pelajar Pejuang No. 13, Sawahlunto, Aceh 67044', 'uda.nasyidah@gmail.com', 'L', '08628007588', '1986-01-18', 'Aktif', 9),
(4794288249119747, 'P001', 'Dr. dr. Azalea Wahyuni, S.Pd', 'Jl. Moch. Ramdan No. 4, Banjar, Kalimantan Barat 52720', 'azalea.wahyuni.s.pd@gmail.com', 'L', '+6204521416325', '1986-04-20', 'Aktif', 9),
(6247399602493504, 'P008', 'Dr. Dt. Cawuk Suartini, M.Ak', 'Gang Waringin No. 65, Serang, JI 03718', 'dt..cawuk.suartini.m.ak@gmail.com', 'L', '+623853698131', '1980-11-08', 'Aktif', 15),
(1052934044853137, 'P010', 'Dr. Elisa Mandala', 'Jl. Asia Afrika No. 2, Tomohon, SU 95045', 'elisa.mandala@gmail.com', 'L', '+62813320085', '1980-11-04', 'Aktif', 15);

INSERT INTO Spesialisasi (ID_Spesialisasi, NIK_Dokter, Nama, JenisSpesialisasi) VALUES
('S001', 3706728410708460, 'Dr. Safina Halim', 'Anak'),
('S002', 4438763380778257, 'Dr. Dasa Latupono, S.E.I', 'Penyakit Dalam'),
('S003', 2299771729589752, 'Dr. Lanjar Budiman', 'Bedah Umum'),
('S004', 6068254841174653, 'Dr. R.A. Shania Puspasari', 'Orthopedi'),
('S005', 6307133663178831, 'Dr. Azalea Wulandari', 'Geriatri'),
('S006', 9180284501531566, 'Dr. drg. Cecep Wahyudin, M.Kom.', 'Saraf'),
('S007', 1603567409361384, 'Dr. Ir. Kala Agustina', 'Saraf'),
('S008', 4518357744305768, 'Dr. Cengkal Firgantoro', 'THT'),
('S009', 3643051835755287, 'Dr. Kania Nugroho', 'Jantung'),
('S010', 3859839121583230, 'Dr. Violet Kuswoyo', 'Gigi dan Mulut'),
('S011', 1821762107954240, 'Dr. Hj. Talia Pangestu', 'Orthopedi'),
('S012', 9978301743844647, 'Dr. Legawa Wulandari', 'Gizi Klinik'),
('S013', 2132994531219016, 'Dr. Laila Setiawan', 'Anak'),
('S014', 6220208464172846, 'Dr. Nadine Sitorus', 'Penyakit Dalam'),
('S015', 7665166417101356, 'Dr. Aswani Wahyuni', 'Kandungan'),
('S016', 2309225084677651, 'Dr. Lidya Rajata', 'Kandungan'),
('S017', 2422469142282030, 'Dr. T. Ozy Sinaga', 'Orthopedi'),
('S018', 3192134544452200, 'Dr. Zelaya Mulyani', 'Geriatri'),
('S019', 2067064571558421, 'Dr. Karsa Waskita, S.I.Kom', 'Saraf'),
('S020', 3722899513977542, 'Dr. Rizki Oktaviani', 'THT'),
('S021', 3561054070799984, 'Dr. R.A. Hani Hasanah', 'Kandungan'),
('S022', 5491320015149600, 'Dr. drg. Najwa Wibowo', 'Jantung'),
('S023', 3236874597445544, 'Dr. Karja Waluyo, S.Kom', 'Gizi Klinik'),
('S024', 1360159815088780, 'Dr. Hana Sudiati', 'Kulit dan Kelamin'),
('S025', 8478807080465322, 'Dr. Harja Wijaya, S.Sos', 'Saraf'),
('S026', 3736491059387433, 'Dr. Melinda Kusumo', 'Paru'),
('S027', 6208153221385389, 'Dr. Drs. Ade Handayani, M.Pd', 'Penyakit Dalam'),
('S028', 2414865760986573, 'Dr. Yunita Saptono', 'Orthopedi'),
('S029', 6281153986692990, 'Dr. Hj. Dinda Marpaung', 'Mata'),
('S030', 9627909439392755, 'Dr. Dt. Harsaya Sihotang', 'Paru'),
('S031', 6743552279200699, 'Dr. Wulan Maryati', 'Gizi Klinik'),
('S032', 5129068825753730, 'Dr. Genta Permata', 'Gigi dan Mulut'),
('S033', 2284493192906774, 'Dr. Rahman Laksmiwati', 'Kandungan'),
('S034', 6948439348797963, 'Dr. Yulia Sinaga', 'Bedah Umum'),
('S035', 6902252520786465, 'Dr. Cornelia Budiyanto', 'Kulit dan Kelamin'),
('S036', 1954900446085735, 'Dr. Eva Mayasari, M.TI.', 'Gigi dan Mulut'),
('S037', 9508063623971414, 'Dr. Jail Waluyo', 'Orthopedi'),
('S038', 4894529552802774, 'Dr. dr. Paulin Setiawan, M.Ak', 'Orthopedi'),
('S039', 9651576011074704, 'Dr. Zizi Najmudin', 'Paru'),
('S040', 9183191447489863, 'Dr. Satya Widodo', 'Paru'),
('S041', 7274174256919996, 'Dr. Hj. Devi Padmasari, S.E.', 'Paru'),
('S042', 5072854386333782, 'Dr. Dalima Andriani', 'THT'),
('S043', 6455376804072226, 'Dr. Salimah Ramadan', 'Gizi Klinik'),
('S044', 4715835249771642, 'Dr. Yuliana Tamba', 'Kandungan'),
('S045', 7606864379996648, 'Dr. Devi Situmorang, S.Sos', 'Mata'),
('S046', 7938061304154830, 'Dr. Kartika Nasyidah', 'Mata'),
('S047', 9192766826189351, 'Dr. dr. Uda Nasyidah', 'Mata'),
('S048', 4794288249119747, 'Dr. dr. Azalea Wahyuni, S.Pd', 'Gigi dan Mulut'),
('S049', 6247399602493504, 'Dr. Dt. Cawuk Suartini, M.Ak', 'Gigi dan Mulut'),
('S050', 1052934044853137, 'Dr. Elisa Mandala', 'Kulit dan Kelamin');

INSERT INTO Jadwal_Praktek (ID_Jadwal, NIK_Dokter, Hari, JamMulai, JamSelesai, MaksimalPasien, Status) VALUES
('J001', 3706728410708460, 'Rabu', '08:00:00', '12:00:00', 20, 'Aktif'),
('J002', 4438763380778257, 'Rabu', '08:00:00', '12:00:00', 30, 'Tidak Aktif'),
('J003', 2299771729589752, 'Jumat', '08:00:00', '12:00:00', 25, 'Tidak Aktif'),
('J004', 6068254841174653, 'Rabu', '08:00:00', '12:00:00', 15, 'Tidak Aktif'),
('J005', 6307133663178831, 'Selasa', '08:00:00', '12:00:00', 25, 'Aktif'),
('J006', 9180284501531566, 'Senin', '08:00:00', '12:00:00', 15, 'Tidak Aktif'),
('J007', 1603567409361384, 'Sabtu', '08:00:00', '12:00:00', 15, 'Tidak Aktif'),
('J008', 4518357744305768, 'Jumat', '08:00:00', '12:00:00', 30, 'Aktif'),
('J009', 3643051835755287, 'Senin', '08:00:00', '12:00:00', 25, 'Aktif'),
('J010', 3859839121583230, 'Jumat', '08:00:00', '12:00:00', 25, 'Tidak Aktif'),
('J011', 1821762107954240, 'Selasa', '08:00:00', '12:00:00', 30, 'Aktif'),
('J012', 9978301743844647, 'Selasa', '08:00:00', '12:00:00', 15, 'Tidak Aktif'),
('J013', 2132994531219016, 'Kamis', '08:00:00', '12:00:00', 15, 'Tidak Aktif'),
('J014', 6220208464172846, 'Jumat', '08:00:00', '12:00:00', 15, 'Aktif'),
('J015', 7665166417101356, 'Senin', '08:00:00', '12:00:00', 30, 'Tidak Aktif'),
('J016', 2309225084677651, 'Sabtu', '08:00:00', '12:00:00', 25, 'Aktif'),
('J017', 2422469142282030, 'Selasa', '08:00:00', '12:00:00', 20, 'Tidak Aktif'),
('J018', 3192134544452200, 'Rabu', '08:00:00', '12:00:00', 30, 'Aktif'),
('J019', 2067064571558421, 'Kamis', '08:00:00', '12:00:00', 30, 'Tidak Aktif'),
('J020', 3722899513977542, 'Minggu', '08:00:00', '12:00:00', 20, 'Tidak Aktif'),
('J021', 3561054070799984, 'Senin', '08:00:00', '12:00:00', 25, 'Aktif'),
('J022', 5491320015149600, 'Sabtu', '08:00:00', '12:00:00', 15, 'Aktif'),
('J023', 3236874597445544, 'Selasa', '08:00:00', '12:00:00', 25, 'Aktif'),
('J024', 1360159815088780, 'Sabtu', '08:00:00', '12:00:00', 30, 'Aktif'),
('J025', 8478807080465322, 'Senin', '08:00:00', '12:00:00', 25, 'Tidak Aktif'),
('J026', 3736491059387433, 'Selasa', '08:00:00', '12:00:00', 25, 'Aktif'),
('J027', 6208153221385389, 'Jumat', '08:00:00', '12:00:00', 30, 'Tidak Aktif'),
('J028', 2414865760986573, 'Kamis', '08:00:00', '12:00:00', 15, 'Aktif'),
('J029', 6281153986692990, 'Kamis', '08:00:00', '12:00:00', 30, 'Aktif'),
('J030', 9627909439392755, 'Kamis', '08:00:00', '12:00:00', 30, 'Tidak Aktif'),
('J031', 6743552279200699, 'Jumat', '08:00:00', '12:00:00', 30, 'Aktif'),
('J032', 5129068825753730, 'Sabtu', '08:00:00', '12:00:00', 15, 'Tidak Aktif'),
('J033', 2284493192906774, 'Minggu', '08:00:00', '12:00:00', 25, 'Tidak Aktif'),
('J034', 6948439348797963, 'Rabu', '08:00:00', '12:00:00', 30, 'Tidak Aktif'),
('J035', 6902252520786465, 'Selasa', '08:00:00', '12:00:00', 30, 'Tidak Aktif'),
('J036', 1954900446085735, 'Rabu', '08:00:00', '12:00:00', 20, 'Aktif'),
('J037', 9508063623971414, 'Senin', '08:00:00', '12:00:00', 30, 'Tidak Aktif'),
('J038', 4894529552802774, 'Minggu', '08:00:00', '12:00:00', 20, 'Tidak Aktif'),
('J039', 9651576011074704, 'Jumat', '08:00:00', '12:00:00', 15, 'Aktif'),
('J040', 9183191447489863, 'Senin', '08:00:00', '12:00:00', 25, 'Tidak Aktif'),
('J041', 7274174256919996, 'Jumat', '08:00:00', '12:00:00', 15, 'Aktif'),
('J042', 5072854386333782, 'Selasa', '08:00:00', '12:00:00', 25, 'Aktif'),
('J043', 6455376804072226, 'Sabtu', '08:00:00', '12:00:00', 15, 'Tidak Aktif'),
('J044', 4715835249771642, 'Rabu', '08:00:00', '12:00:00', 20, 'Tidak Aktif'),
('J045', 7606864379996648, 'Kamis', '08:00:00', '12:00:00', 15, 'Aktif'),
('J046', 7938061304154830, 'Jumat', '08:00:00', '12:00:00', 20, 'Tidak Aktif'),
('J047', 9192766826189351, 'Jumat', '08:00:00', '12:00:00', 15, 'Tidak Aktif'),
('J048', 4794288249119747, 'Jumat', '08:00:00', '12:00:00', 15, 'Aktif'),
('J049', 6247399602493504, 'Senin', '08:00:00', '12:00:00', 15, 'Aktif'),
('J050', 1052934044853137, 'Rabu', '08:00:00', '12:00:00', 25, 'Aktif');

INSERT INTO Pendaftaran (ID_Pendaftaran, NIK_Pasien, ID_Jadwal, NomorAntrian, TanggalDaftar, StatusDaftar, KeluhanAwal) VALUES
('P001', '3174010101010001', 'J001', 1, '2025-05-02', 'Confirmed', 'Keluhan dummy 1'),
('P002', '3174010101010002', 'J002', 2, '2025-05-03', 'Cancelled', 'Keluhan dummy 2'),
('P003', '3174010101010003', 'J003', 3, '2025-05-04', 'Pending', 'Keluhan dummy 3'),
('P004', '3174010101010004', 'J004', 4, '2025-05-05', 'Confirmed', 'Keluhan dummy 4'),
('P005', '3174010101010005', 'J005', 5, '2025-05-06', 'Cancelled', 'Keluhan dummy 5'),
('P006', '3174010101010006', 'J006', 6, '2025-05-07', 'Pending', 'Keluhan dummy 6'),
('P007', '3174010101010007', 'J007', 7, '2025-05-08', 'Confirmed', 'Keluhan dummy 7'),
('P008', '3174010101010008', 'J008', 8, '2025-05-09', 'Cancelled', 'Keluhan dummy 8'),
('P009', '3174010101010009', 'J009', 9, '2025-05-10', 'Pending', 'Keluhan dummy 9'),
('P010', '3174010101010010', 'J010', 10, '2025-05-11', 'Confirmed', 'Keluhan dummy 10'),
('P011', '3174010101010011', 'J011', 11, '2025-05-12', 'Cancelled', 'Keluhan dummy 11'),
('P012', '3174010101010012', 'J012', 12, '2025-05-13', 'Pending', 'Keluhan dummy 12'),
('P013', '3174010101010013', 'J013', 13, '2025-05-14', 'Confirmed', 'Keluhan dummy 13'),
('P014', '3174010101010014', 'J014', 14, '2025-05-15', 'Cancelled', 'Keluhan dummy 14'),
('P015', '3174010101010015', 'J015', 15, '2025-05-16', 'Pending', 'Keluhan dummy 15'),
('P016', '3174010101010016', 'J016', 16, '2025-05-17', 'Confirmed', 'Keluhan dummy 16'),
('P017', '3174010101010017', 'J017', 17, '2025-05-18', 'Cancelled', 'Keluhan dummy 17'),
('P018', '3174010101010018', 'J018', 18, '2025-05-19', 'Pending', 'Keluhan dummy 18'),
('P019', '3174010101010019', 'J019', 19, '2025-05-20', 'Confirmed', 'Keluhan dummy 19'),
('P020', '3174010101010020', 'J020', 20, '2025-05-21', 'Cancelled', 'Keluhan dummy 20'),
('P021', '3174010101010021', 'J021', 21, '2025-05-22', 'Pending', 'Keluhan dummy 21'),
('P022', '3174010101010022', 'J022', 22, '2025-05-23', 'Confirmed', 'Keluhan dummy 22'),
('P023', '3174010101010023', 'J023', 23, '2025-05-24', 'Cancelled', 'Keluhan dummy 23'),
('P024', '3174010101010024', 'J024', 24, '2025-05-25', 'Pending', 'Keluhan dummy 24'),
('P025', '3174010101010025', 'J025', 25, '2025-05-26', 'Confirmed', 'Keluhan dummy 25'),
('P026', '3174010101010026', 'J026', 26, '2025-05-27', 'Cancelled', 'Keluhan dummy 26'),
('P027', '3174010101010027', 'J027', 27, '2025-05-28', 'Pending', 'Keluhan dummy 27'),
('P028', '3174010101010028', 'J028', 28, '2025-05-29', 'Confirmed', 'Keluhan dummy 28'),
('P029', '3174010101010029', 'J029', 29, '2025-05-30', 'Cancelled', 'Keluhan dummy 29'),
('P030', '3174010101010030', 'J030', 30, '2025-05-01', 'Pending', 'Keluhan dummy 30'),
('P031', '3174010101010031', 'J031', 1, '2025-05-02', 'Confirmed', 'Keluhan dummy 31'),
('P032', '3174010101010032', 'J032', 2, '2025-05-03', 'Cancelled', 'Keluhan dummy 32'),
('P033', '3174010101010033', 'J033', 3, '2025-05-04', 'Pending', 'Keluhan dummy 33'),
('P034', '3174010101010034', 'J034', 4, '2025-05-05', 'Confirmed', 'Keluhan dummy 34'),
('P035', '3174010101010035', 'J035', 5, '2025-05-06', 'Cancelled', 'Keluhan dummy 35'),
('P036', '3174010101010036', 'J036', 6, '2025-05-07', 'Pending', 'Keluhan dummy 36'),
('P037', '3174010101010037', 'J037', 7, '2025-05-08', 'Confirmed', 'Keluhan dummy 37'),
('P038', '3174010101010038', 'J038', 8, '2025-05-09', 'Cancelled', 'Keluhan dummy 38'),
('P039', '3174010101010039', 'J039', 9, '2025-05-10', 'Pending', 'Keluhan dummy 39'),
('P040', '3174010101010040', 'J040', 10, '2025-05-11', 'Confirmed', 'Keluhan dummy 40'),
('P041', '3174010101010041', 'J041', 11, '2025-05-12', 'Cancelled', 'Keluhan dummy 41'),
('P042', '3174010101010042', 'J042', 12, '2025-05-13', 'Pending', 'Keluhan dummy 42'),
('P043', '3174010101010043', 'J043', 13, '2025-05-14', 'Confirmed', 'Keluhan dummy 43'),
('P044', '3174010101010044', 'J044', 14, '2025-05-15', 'Cancelled', 'Keluhan dummy 44'),
('P045', '3174010101010045', 'J045', 15, '2025-05-16', 'Pending', 'Keluhan dummy 45'),
('P046', '3174010101010046', 'J046', 16, '2025-05-17', 'Confirmed', 'Keluhan dummy 46'),
('P047', '3174010101010047', 'J047', 17, '2025-05-18', 'Cancelled', 'Keluhan dummy 47'),
('P048', '3174010101010048', 'J048', 18, '2025-05-19', 'Pending', 'Keluhan dummy 48'),
('P049', '3174010101010049', 'J049', 19, '2025-05-20', 'Confirmed', 'Keluhan dummy 49'),
('P050', '3174010101010050', 'J050', 20, '2025-05-21', 'Cancelled', 'Keluhan dummy 50');


INSERT INTO Rekam_Medis (ID_Rekam_Medis, ID_Pendaftaran, Diagnosis, TindakanMedis, ResepObat) VALUES
('RM001', 'P001', 'Demam Berdarah', 'Pemberian cairan infus dan istirahat', 'Paracetamol, Cairan Elektrolyt'),
('RM002', 'P002', 'Migrain', 'Pemberian obat penghilang nyeri', 'Ibuprofen'),
('RM003', 'P003', 'Angina', 'Pemberian obat vasodilator', 'Nitrogliserin'),
('RM004', 'P004', 'Dermatitis', 'Penggunaan salep steroid', 'Hydrocortisone cream'),
('RM005', 'P005', 'Asma', 'Pemberian inhaler dan bronkodilator', 'Salbutamol inhaler'),
('RM006', 'P006', 'Otitis Media', 'Pemberian antibiotik', 'Amoxicillin'),
('RM007', 'P007', 'Arthritis', 'Fisioterapi dan pemberian analgesik', 'Naproxen'),
('RM008', 'P008', 'Gingivitis', 'Pembersihan karang gigi dan antiseptik', 'Chlorhexidine mouthwash'),
('RM009', 'P009', 'Gastritis', 'Pemberian antasida dan diet khusus', 'Ranitidine'),
('RM010', 'P010', 'Bronkitis', 'Pemberian ekspektoran dan antibiotik', 'Ambroxol, Amoxicillin'),
('RM011', 'P011', 'Konjungtivitis', 'Pemberian tetes mata antibiotik', 'Tobramycin eye drops'),
('RM012', 'P012', 'Faringitis', 'Pemberian analgesik dan antibiotik', 'Paracetamol, Amoxicillin'),
('RM013', 'P013', 'Vertigo', 'Pemberian obat anti-vertigo', 'Betahistine'),
('RM014', 'P014', 'Dismenore', 'Pemberian analgesik dan relaksasi', 'Ibuprofen'),
('RM015', 'P015', 'Lumbago', 'Fisioterapi dan analgesik', 'Diclofenac'),
('RM016', 'P016', 'Edema', 'Pemberian diuretik', 'Furosemide'),
('RM017', 'P017', 'Hemoptisis', 'Investigasi lebih lanjut dan pemberian antibiotik', 'Amoxicillin'),
('RM018', 'P018', 'Luka Kronis', 'Perawatan luka dan antibiotik topikal', 'Mupirocin cream'),
('RM019', 'P019', 'Infark Miokard', 'Pemberian terapi trombolitik', 'Aspirin, Clopidogrel'),
('RM020', 'P020', 'Ulkus Peptikum', 'Pemberian inhibitor pompa proton', 'Omeprazole'),
('RM021', 'P021', 'Bronkospasme', 'Pemberian bronkodilator', 'Salbutamol inhaler'),
('RM022', 'P022', 'Demam Tinggi', 'Pemberian antipiretik', 'Paracetamol'),
('RM023', 'P023', 'Cervicalgia', 'Fisioterapi dan analgesik', 'Ibuprofen'),
('RM024', 'P024', 'Migrain', 'Pemberian obat pencegah dan analgesik', 'Propranolol, Paracetamol'),
('RM025', 'P025', 'Gastroenteritis', 'Rehidrasi dan antibiotik', 'ORS, Ciprofloxacin'),
('RM026', 'P026', 'Eksim', 'Penggunaan salep steroid', 'Hydrocortisone cream'),
('RM027', 'P027', 'Flu', 'Pemberian antivirus dan symptomatik', 'Oseltamivir'),
('RM028', 'P028', 'Karies Gigi', 'Pembersihan dan penambalan', 'Fluoride toothpaste'),
('RM029', 'P029', 'Mialgia', 'Pemberian analgesik dan fisioterapi', 'Paracetamol'),
('RM030', 'P030', 'Ruam Kulit', 'Pemberian antihistamin dan steroid', 'Cetirizine, Hydrocortisone cream'),
('RM031', 'P031', 'Lumbago', 'Fisioterapi dan analgesik', 'Diclofenac'),
('RM032', 'P032', 'Gastritis', 'Pemberian antasida dan diet khusus', 'Ranitidine'),
('RM033', 'P033', 'Asma', 'Pemberian inhaler dan bronkodilator', 'Salbutamol inhaler'),
('RM034', 'P034', 'Faringitis', 'Pemberian analgesik dan antibiotik', 'Paracetamol, Amoxicillin'),
('RM035', 'P035', 'Sakit Kepala', 'Pemberian analgesik', 'Ibuprofen'),
('RM036', 'P036', 'Arthritis', 'Fisioterapi dan analgesik', 'Naproxen'),
('RM037', 'P037', 'Dermatitis', 'Penggunaan salep steroid', 'Hydrocortisone cream'),
('RM038', 'P038', 'Angina', 'Pemberian obat vasodilator', 'Nitrogliserin'),
('RM039', 'P039', 'Vertigo', 'Pemberian obat anti-vertigo', 'Betahistine'),
('RM040', 'P040', 'Batuk Berdahak', 'Pemberian ekspektoran', 'Ambroxol'),
('RM041', 'P041', 'Demam', 'Pemberian antipiretik', 'Paracetamol'),
('RM042', 'P042', 'Nyeri Otot', 'Pemberian analgesik', 'Ibuprofen'),
('RM043', 'P043', 'Sakit Perut', 'Pemberian antasida', 'Ranitidine'),
('RM044', 'P044', 'Sesak Napas', 'Pemberian bronkodilator', 'Salbutamol inhaler'),
('RM045', 'P045', 'Mual', 'Pemberian antiemetik', 'Metoclopramide'),
('RM046', 'P046', 'Luka', 'Perawatan luka', 'Antiseptik'),
('RM047', 'P047', 'Sakit Kepala', 'Pemberian analgesik', 'Paracetamol'),
('RM048', 'P048', 'Batuk Berdahak', 'Pemberian ekspektoran', 'Ambroxol'),
('RM049', 'P049', 'Demam Tinggi', 'Pemberian antipiretik', 'Paracetamol'),
('RM050', 'P050', 'Sakit Perut Akut', 'Pemeriksaan lanjutan dan pengobatan', 'Omeprazole');


INSERT INTO Resep_Obat (ID_Resep_Obat, ID_Rekam_Medis, NamaObat, DosisObat, FrekuensiPemakaian, DurasiPemakaian, JumlahObatDiresepkan, InstruksiTambahan) VALUES
('RO001', 'RM001', 'Paracetamol', '500mg', '3x sehari', '5 hari', 15, 'Minum setelah makan'),
('RO002', 'RM001', 'Cairan Elektrolyt', '100ml', '2x sehari', '3 hari', 6, 'Diminum perlahan'),
('RO003', 'RM002', 'Ibuprofen', '400mg', '3x sehari', '7 hari', 21, 'Jangan diminum saat perut kosong'),
('RO004', 'RM003', 'Nitrogliserin', '0.3mg', '1x saat nyeri', 'Sesudah nyeri hilang', 10, 'Letakkan di bawah lidah'),
('RO005', 'RM004', 'Hydrocortisone cream', 'Salep 1%', '2x sehari', '7 hari', 1, 'Oles tipis pada area yang sakit'),
('RO006', 'RM005', 'Salbutamol inhaler', '100mcg', '4x sehari', '14 hari', 1, 'Gunakan sesuai kebutuhan'),
('RO007', 'RM006', 'Amoxicillin', '500mg', '3x sehari', '7 hari', 21, 'Minum sampai habis'),
('RO008', 'RM007', 'Naproxen', '250mg', '2x sehari', '5 hari', 10, 'Minum dengan air putih'),
('RO009', 'RM008', 'Chlorhexidine mouthwash', '10ml', '2x sehari', '7 hari', 140, 'Berkumur selama 30 detik'),
('RO010', 'RM009', 'Ranitidine', '150mg', '2x sehari', '14 hari', 28, 'Minum 30 menit sebelum makan'),
('RO011', 'RM010', 'Ambroxol', '30mg', '3x sehari', '7 hari', 21, 'Minum dengan air putih'),
('RO012', 'RM010', 'Amoxicillin', '500mg', '3x sehari', '7 hari', 21, 'Minum sampai habis'),
('RO013', 'RM011', 'Tobramycin eye drops', '0.3%', '4x sehari', '10 hari', 1, 'Teteskan ke mata yang sakit'),
('RO014', 'RM012', 'Paracetamol', '500mg', '3x sehari', '5 hari', 15, 'Minum setelah makan'),
('RO015', 'RM012', 'Amoxicillin', '500mg', '3x sehari', '7 hari', 21, 'Minum sampai habis'),
('RO016', 'RM013', 'Betahistine', '16mg', '3x sehari', '14 hari', 42, 'Minum setelah makan'),
('RO017', 'RM014', 'Ibuprofen', '400mg', '3x sehari', '5 hari', 15, 'Jangan diminum saat perut kosong'),
('RO018', 'RM015', 'Diclofenac', '50mg', '2x sehari', '7 hari', 14, 'Minum dengan air putih'),
('RO019', 'RM016', 'Furosemide', '40mg', '1x sehari', '5 hari', 5, 'Minum pagi hari'),
('RO020', 'RM017', 'Amoxicillin', '500mg', '3x sehari', '7 hari', 21, 'Minum sampai habis'),
('RO021', 'RM018', 'Mupirocin cream', '2%', '3x sehari', '10 hari', 1, 'Oleskan tipis pada luka'),
('RO022', 'RM019', 'Aspirin', '81mg', '1x sehari', '30 hari', 30, 'Minum setelah makan'),
('RO023', 'RM019', 'Clopidogrel', '75mg', '1x sehari', '30 hari', 30, 'Minum secara teratur'),
('RO024', 'RM020', 'Omeprazole', '20mg', '1x sehari', '14 hari', 14, 'Minum 30 menit sebelum makan'),
('RO025', 'RM021', 'Salbutamol inhaler', '100mcg', '4x sehari', '14 hari', 1, 'Gunakan sesuai kebutuhan'),
('RO026', 'RM022', 'Paracetamol', '500mg', '3x sehari', '5 hari', 15, 'Minum setelah makan'),
('RO027', 'RM023', 'Ibuprofen', '400mg', '3x sehari', '7 hari', 21, 'Minum dengan air putih'),
('RO028', 'RM024', 'Propranolol', '40mg', '2x sehari', '30 hari', 60, 'Minum teratur'),
('RO029', 'RM024', 'Paracetamol', '500mg', '3x sehari', '5 hari', 15, 'Minum setelah makan'),
('RO030', 'RM025', 'ORS', '1 sachet', 'Setiap 4 jam', '3 hari', 9, 'Dilarutkan dengan 200ml air'),
('RO031', 'RM025', 'Ciprofloxacin', '500mg', '2x sehari', '7 hari', 14, 'Minum sampai habis'),
('RO032', 'RM026', 'Hydrocortisone cream', '1%', '2x sehari', '7 hari', 1, 'Oles tipis pada area yang sakit'),
('RO033', 'RM027', 'Oseltamivir', '75mg', '2x sehari', '5 hari', 10, 'Minum setelah makan'),
('RO034', 'RM028', 'Fluoride toothpaste', 'N/A', '2x sehari', 'Sesuai kebutuhan', 1, 'Gunakan saat menyikat gigi'),
('RO035', 'RM029', 'Paracetamol', '500mg', '3x sehari', '5 hari', 15, 'Minum setelah makan'),
('RO036', 'RM030', 'Cetirizine', '10mg', '1x sehari', '7 hari', 7, 'Minum di malam hari'),
('RO037', 'RM030', 'Hydrocortisone cream', '1%', '2x sehari', '7 hari', 1, 'Oles tipis pada ruam'),
('RO038', 'RM031', 'Diclofenac', '50mg', '2x sehari', '7 hari', 14, 'Minum dengan air putih'),
('RO039', 'RM032', 'Ranitidine', '150mg', '2x sehari', '14 hari', 28, 'Minum 30 menit sebelum makan'),
('RO040', 'RM033', 'Salbutamol inhaler', '100mcg', '4x sehari', '14 hari', 1, 'Gunakan sesuai kebutuhan'),
('RO041', 'RM034', 'Paracetamol', '500mg', '3x sehari', '5 hari', 15, 'Minum setelah makan'),
('RO042', 'RM034', 'Amoxicillin', '500mg', '3x sehari', '7 hari', 21, 'Minum sampai habis'),
('RO043', 'RM035', 'Ibuprofen', '400mg', '3x sehari', '7 hari', 21, 'Minum dengan air putih'),
('RO044', 'RM036', 'Naproxen', '250mg', '2x sehari', '5 hari', 10, 'Minum setelah makan'),
('RO045', 'RM037', 'Hydrocortisone cream', '1%', '2x sehari', '7 hari', 1, 'Oles tipis pada area yang sakit'),
('RO046', 'RM038', 'Nitrogliserin', '0.3mg', '1x saat nyeri', 'Sesudah nyeri hilang', 10, 'Letakkan di bawah lidah'),
('RO047', 'RM039', 'Betahistine', '16mg', '3x sehari', '14 hari', 42, 'Minum setelah makan'),
('RO048', 'RM040', 'Ambroxol', '30mg', '3x sehari', '7 hari', 21, 'Minum dengan air putih'),
('RO049', 'RM041', 'Paracetamol', '500mg', '3x sehari', '5 hari', 15, 'Minum setelah makan'),
('RO050', 'RM042', 'Ibuprofen', '400mg', '3x sehari', '7 hari', 21, 'Minum dengan air putih');


INSERT INTO Pembayaran (ID_Pembayaran, ID_Pendaftaran, RincianBiaya, TanggalBayar, MetodeBayar) VALUES
('BY001', 'P001', 150000, '2025-05-01', 'Cash'),
('BY002', 'P002', 100000, '2025-05-02', 'Kartu Kredit'),
('BY003', 'P003', 200000, '2025-05-02', 'Transfer'),
('BY004', 'P004', 175000, '2025-05-03', 'Cash'),
('BY005', 'P005', 130000, '2025-05-04', 'Kartu Kredit'),
('BY006', 'P006', 150000, '2025-05-04', 'Transfer'),
('BY007', 'P007', 160000, '2025-05-05', 'Cash'),
('BY008', 'P008', 140000, '2025-05-06', 'Kartu Kredit'),
('BY009', 'P009', 155000, '2025-05-06', 'Transfer'),
('BY010', 'P010', 145000, '2025-05-07', 'Cash'),
('BY011', 'P011', 120000, '2025-05-07', 'Kartu Kredit'),
('BY012', 'P012', 165000, '2025-05-08', 'Transfer'),
('BY013', 'P013', 135000, '2025-05-08', 'Cash'),
('BY014', 'P014', 180000, '2025-05-09', 'Kartu Kredit'),
('BY015', 'P015', 155000, '2025-05-09', 'Transfer'),
('BY016', 'P016', 140000, '2025-05-10', 'Cash'),
('BY017', 'P017', 150000, '2025-05-10', 'Kartu Kredit'),
('BY018', 'P018', 160000, '2025-05-11', 'Transfer'),
('BY019', 'P019', 170000, '2025-05-11', 'Cash'),
('BY020', 'P020', 130000, '2025-05-12', 'Kartu Kredit'),
('BY021', 'P021', 155000, '2025-05-12', 'Transfer'),
('BY022', 'P022', 140000, '2025-05-13', 'Cash'),
('BY023', 'P023', 145000, '2025-05-13', 'Kartu Kredit'),
('BY024', 'P024', 175000, '2025-05-14', 'Transfer'),
('BY025', 'P025', 160000, '2025-05-14', 'Cash'),
('BY026', 'P026', 150000, '2025-05-15', 'Kartu Kredit'),
('BY027', 'P027', 140000, '2025-05-15', 'Transfer'),
('BY028', 'P028', 130000, '2025-05-16', 'Cash'),
('BY029', 'P029', 165000, '2025-05-16', 'Kartu Kredit'),
('BY030', 'P030', 155000, '2025-05-17', 'Transfer'),
('BY031', 'P031', 145000, '2025-05-17', 'Cash'),
('BY032', 'P032', 135000, '2025-05-18', 'Kartu Kredit'),
('BY033', 'P033', 160000, '2025-05-18', 'Transfer'),
('BY034', 'P034', 170000, '2025-05-19', 'Cash'),
('BY035', 'P035', 140000, '2025-05-19', 'Kartu Kredit'),
('BY036', 'P036', 150000, '2025-05-20', 'Transfer'),
('BY037', 'P037', 155000, '2025-05-20', 'Cash'),
('BY038', 'P038', 130000, '2025-05-21', 'Kartu Kredit'),
('BY039', 'P039', 165000, '2025-05-21', 'Transfer'),
('BY040', 'P040', 140000, '2025-05-22', 'Cash'),
('BY041', 'P041', 135000, '2025-05-22', 'Kartu Kredit'),
('BY042', 'P042', 160000, '2025-05-23', 'Transfer'),
('BY043', 'P043', 170000, '2025-05-23', 'Cash'),
('BY044', 'P044', 150000, '2025-05-24', 'Kartu Kredit'),
('BY045', 'P045', 140000, '2025-05-24', 'Transfer'),
('BY046', 'P046', 130000, '2025-05-25', 'Cash'),
('BY047', 'P047', 155000, '2025-05-25', 'Kartu Kredit'),
('BY048', 'P048', 145000, '2025-05-26', 'Transfer'),
('BY049', 'P049', 160000, '2025-05-26', 'Cash'),
('BY050', 'P050', 150000, '2025-05-27', 'Kartu Kredit');

use rumahsakitkasihsayang

SELECT * FROM poli

SELECT * FROM pasien

SELECT * FROM dokter

SELECT * FROM pendaftaran

SELECT * FROM jadwal_praktek

SELECT * FROM spesialisasi

SELECT * FROM resep_obat

SELECT * FROM rekam_medis

SELECT * FROM pembayaran

/* menampilkan data pasien beserta golongan darah mereka yang golongan darah A adan O */
select nama, golongandarah
from pasien
where golongandarah in ('A', 'O');

/* menampilkan data pasien yang namanya berawalan huruf A dan seorang laki-laki */
SELECT Nama AS NamaPasien
FROM Pasien
WHERE Nama LIKE 'A%' AND JenisKelamin = 'L'

/* menampilkan data dokter yang sudah diurutkan yang memiliki pengalaman antara 5 sampai 15 tahun  */
SELECT DISTINCT Nama, JenisKelamin, TahunPengalaman
FROM Dokter
WHERE (StatusDokter = 'Aktif' AND TahunPengalaman BETWEEN 5 AND 15)
ORDER BY TahunPengalaman DESC;


/* menampilkan data resep obat yang memiliki ID Rekam medis RM001  */
SELECT r.ID_Resep_Obat, r.NamaObat, r.DosisObat, r.FrekuensiPemakaian, r.DurasiPemakaian
FROM Resep_Obat r
WHERE r.ID_Rekam_Medis = 'RM001';

///////

/* menampilkan data dokter yang aktif dan memiliki jadwal praktek pada hari rabu */
select d.nama as namadokter, j.hari, j.jammulai, j.jamselesai
from jadwal_praktek j
join dokter d on j.nik_dokter = d.nik_dokter 
where j.hari = 'rabu' and j.status = 'aktif';

/* menampilkan data dokter yang memiliki tahun pengalaman paling lmaa */
SELECT Nama, TahunPengalaman
FROM Dokter
WHERE TahunPengalaman = (SELECT MAX(TahunPengalaman) FROM Dokter);

/* Hitung jumlah pasien yang mendaftar pada setiap hari, urutkan dari jumlah terbanyak */
SELECT TanggalDaftar, COUNT(ID_Pendaftaran) AS JumlahPasien
FROM Pendaftaran
GROUP BY TanggalDaftar
ORDER BY JumlahPasien desc

/* menampilkan total pembayaran pasien berdasarkan masing-masing pasien */
SELECT ps.Nama, SUM(b.RincianBiaya) AS TotalBayar
FROM Pembayaran b
JOIN Pendaftaran p ON b.ID_Pendaftaran = p.ID_Pendaftaran
JOIN Pasien ps ON p.NIK_Pasien = ps.NIK_Pasien
GROUP BY ps.Nama;

//////


/* menampilkan pasien, tanggal daftar, diagnosis, dan resep obat yang diberikan */
SELECT p.Nama AS NamaPasien, pd.TanggalDaftar, rm.Diagnosis, ro.NamaObat
FROM Pasien p
JOIN Pendaftaran pd ON p.NIK_Pasien = pd.NIK_Pasien
JOIN Rekam_Medis rm ON pd.ID_Pendaftaran = rm.ID_Pendaftaran
JOIN Resep_Obat ro ON rm.ID_Rekam_Medis = ro.ID_Rekam_Medis;

/* menampilkan data pasien dengan reseb obat paracetamol */
SELECT pa.Nama AS NamaPasien, ro.NamaObat, ro.DosisObat, ro.FrekuensiPemakaian
FROM Resep_Obat ro
JOIN Rekam_Medis rm ON ro.ID_Rekam_Medis = rm.ID_Rekam_Medis
JOIN Pendaftaran p ON rm.ID_Pendaftaran = p.ID_Pendaftaran
JOIN Pasien pa ON p.NIK_Pasien = pa.NIK_Pasien
WHERE ro.NamaObat LIKE '%Paracetamol%';

/* menampilkan data pasien dengan keluhan awal dan nama dokter yang akan menangani */
SELECT pa.Nama AS NamaPasien, p.KeluhanAwal, d.Nama AS NamaDokter
FROM Pendaftaran p
JOIN Pasien pa ON p.NIK_Pasien = pa.NIK_Pasien
JOIN Jadwal_Praktek jp ON p.ID_Jadwal = jp.ID_Jadwal
JOIN Dokter d ON jp.NIK_Dokter = d.NIK_Dokter;

/* menampilkan data pasien beserta nama dokter yang menangani, tanggal pendaftaran, dan diagnosis rekam medis terkait */
SELECT pa.Nama AS NamaPasien, d.Nama AS NamaDokter, p.TanggalDaftar, rm.Diagnosis
FROM Pendaftaran p
JOIN Pasien pa ON p.NIK_Pasien = pa.NIK_Pasien
JOIN Jadwal_Praktek jp ON p.ID_Jadwal = jp.ID_Jadwal
JOIN Dokter d ON jp.NIK_Dokter = d.NIK_Dokter
LEFT JOIN Rekam_Medis rm ON p.ID_Pendaftaran = rm.ID_Pendaftaran;


