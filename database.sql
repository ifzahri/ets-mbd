-- Active: 1706092922896@@127.0.0.1@5432@ets_mbd@public
-- Tabel Mahasiswa
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE Mahasiswa (
    Mahasiswa_ID UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    UMKM_ID UUID REFERENCES UMKM(UMKM_ID),
    Nama VARCHAR(50)
);

-- Tabel UMKM
CREATE TABLE UMKM (
    UMKM_ID UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    Nama VARCHAR(50),
    Status INT
);

-- Tabel AktivitasMahasiswa
CREATE TABLE AktivitasMahasiswa (
    AktivitasMahasiswa_ID UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    Koordinator_ID UUID REFERENCES Koordinator(Koordinator_ID),
    Tanggal DATE,
    NamaAktivitas VARCHAR(50),
    Verifikasi VARCHAR(3)
);

-- Tabel Koordinator
CREATE TABLE Koordinator (
    Koordinator_ID UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    Nama VARCHAR(50)
);

-- Tabel PengajuanSertifikasi
CREATE TABLE PengajuanSertifikasi (
    PengajuanSertifikasi_ID UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    TanggalPengajuan DATE,
    NamaSertifikasi VARCHAR(50),
    StatusPengajuan VARCHAR(10)
);

CREATE TABLE PengajuanSertifikasi_Mahasiswa (
    PengajuanSertifikasi_ID UUID REFERENCES PengajuanSertifikasi(PengajuanSertifikasi_ID),
    Mahasiswa_ID UUID REFERENCES Mahasiswa(Mahasiswa_ID),
    PRIMARY KEY (PengajuanSertifikasi_ID, Mahasiswa_ID)
);

CREATE TABLE AktivitasMahasiswa_Mahasiswa (
    AktivitasMahasiswa_ID UUID REFERENCES AktivitasMahasiswa(AktivitasMahasiswa_ID),
    Mahasiswa_ID UUID REFERENCES Mahasiswa(Mahasiswa_ID),
    PRIMARY KEY (AktivitasMahasiswa_ID, Mahasiswa_ID)
);




