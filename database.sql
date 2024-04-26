-- Tabel Mahasiswa
CREATE TABLE Mahasiswa (
    Mahasiswa_ID SERIAL PRIMARY KEY,
    Nama VARCHAR(50),
    UMKM_ID INT REFERENCES UMKM(UMKM_ID)
);

-- Tabel UMKM
CREATE TABLE UMKM (
    UMKM_ID SERIAL PRIMARY KEY,
    Nama VARCHAR(50),
    Status INT
);

-- Tabel AktivitasMahasiswa
CREATE TABLE AktivitasMahasiswa (
    AktivitasMahasiswa_ID SERIAL PRIMARY KEY,
    Tanggal DATE,
    NamaAktivitas VARCHAR(50),
    Verifikasi VARCHAR(3),
    Mahasiswa_ID INT REFERENCES Mahasiswa(Mahasiswa_ID)
);

-- Tabel Koordinator
CREATE TABLE Koordinator (
    Koordinator_ID SERIAL PRIMARY KEY,
    Nama VARCHAR(50)
);

-- Tabel PengajuanSertifikasi
CREATE TABLE PengajuanSertifikasi (
    PengajuanSertifikasi_ID SERIAL PRIMARY KEY,
    TanggalPengajuan DATE,
    NamaSertifikasi VARCHAR(50),
    StatusPengajuan VARCHAR(10)
);

-- Insert data into Mahasiswa table
INSERT INTO Mahasiswa (Nama, UMKM_ID) VALUES
    ('Mahasiswa1', 1),
    ('Mahasiswa2', 2),
    ('Mahasiswa3', 3),
    ('Mahasiswa4', 4),
    ('Mahasiswa5', 5),
    ('Mahasiswa6', 6),
    ('Mahasiswa7', 7),
    ('Mahasiswa8', 8),
    ('Mahasiswa9', 9),
    ('Mahasiswa10', 10);

-- Insert data into UMKM table
INSERT INTO UMKM (Nama, Status) VALUES
    ('UMKM1', 0),
    ('UMKM2', 0),
    ('UMKM3', 0),
    ('UMKM4', 0),
    ('UMKM5', 0),
    ('UMKM6', 0),
    ('UMKM7', 0),
    ('UMKM8', 0),
    ('UMKM9', 0),
    ('UMKM10', 0);

-- Insert data into AktivitasMahasiswa table
INSERT INTO AktivitasMahasiswa (Tanggal, NamaAktivitas, Verifikasi, Mahasiswa_ID) VALUES
    ('2024-01-01', 'Aktivitas1', 'ACC', 1),
    ('2024-01-02', 'Aktivitas2', 'ACC', 2),
    ('2024-01-03', 'Aktivitas3', 'NO', 3),
    ('2024-01-04', 'Aktivitas4', 'ACC', 4),
    ('2024-01-05', 'Aktivitas5', 'NO', 5),
    ('2024-01-06', 'Aktivitas6', 'ACC', 6),
    ('2024-01-07', 'Aktivitas7', 'ACC', 7),
    ('2024-01-08', 'Aktivitas8', 'NO', 8),
    ('2024-01-09', 'Aktivitas9', 'ACC', 9),
    ('2024-01-10', 'Aktivitas10', 'ACC', 10);

-- Insert data into Koordinator table
INSERT INTO Koordinator (Nama) VALUES
    ('Koordinator1'),
    ('Koordinator2'),
    ('Koordinator3'),
    ('Koordinator4'),
    ('Koordinator5'),
    ('Koordinator6'),
    ('Koordinator7'),
    ('Koordinator8'),
    ('Koordinator9'),
    ('Koordinator10');

-- Insert data into PengajuanSertifikasi table
INSERT INTO PengajuanSertifikasi (TanggalPengajuan, NamaSertifikasi, StatusPengajuan) VALUES
    ('2024-01-01', 'Sertifikasi1', 'Mendaftar'),
    ('2024-01-02', 'Sertifikasi2', 'Diterima'),
    ('2024-01-03', 'Sertifikasi3', 'Ditolak'),
    ('2024-01-04', 'Sertifikasi4', 'Mendaftar'),
    ('2024-01-05', 'Sertifikasi5', 'Diterima'),
    ('2024-01-06', 'Sertifikasi6', 'Ditolak'),
    ('2024-01-07', 'Sertifikasi7', 'Mendaftar'),
    ('2024-01-08', 'Sertifikasi8', 'Diterima'),
    ('2024-01-09', 'Sertifikasi9', 'Ditolak'),
    ('2024-01-10', 'Sertifikasi10', 'Mendaftar');
