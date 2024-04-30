-- Buatlah view yang menampilkan mahasiswa dan UMKM yang dibantunya.
CREATE VIEW Mahasiswa_UMKM AS
SELECT Mahasiswa.Mahasiswa_ID, Mahasiswa.Nama, UMKM.Nama AS Nama_UMKM
FROM Mahasiswa
JOIN UMKM ON Mahasiswa.UMKM_ID = UMKM.UMKM_ID;

-- Buatlah view yang menampilkan nama mahasiswa dan jumlah UMKM yang pengajuan sertifikasinya “mendaftar”, “Diterima”, dan “Ditolak”
CREATE VIEW Mahasiswa_PengajuanSertifikasi AS
SELECT m.Nama AS Mahasiswa, 
       COUNT(ps.PengajuanSertifikasi_ID) FILTER (WHERE ps.StatusPengajuan = 'Mendaftar') AS Mendaftar,
       COUNT(ps.PengajuanSertifikasi_ID) FILTER (WHERE ps.StatusPengajuan = 'Diterima') AS Diterima,
       COUNT(ps.PengajuanSertifikasi_ID) FILTER (WHERE ps.StatusPengajuan = 'Ditolak') AS Ditolak
FROM Mahasiswa m
JOIN PengajuanSertifikasi_Mahasiswa psm ON m.Mahasiswa_ID = psm.Mahasiswa_ID
JOIN PengajuanSertifikasi ps ON psm.PengajuanSertifikasi_ID = ps.PengajuanSertifikasi_ID
GROUP BY m.Nama;

-- Buatlah sebuah tabel baru bernama Log Verifikasi. Tabel ini perlu menyimpan data ID log, ID Aktivitas, status verifikasi lama, status verifikasi baru, ID koordinator, dan timestamp. Buatlah sequence untuk membuat autoincrement pada ID log.
CREATE TABLE LogVerifikasi (
    LogVerifikasi_ID SERIAL PRIMARY KEY,
    AktivitasMahasiswa_ID UUID REFERENCES AktivitasMahasiswa(AktivitasMahasiswa_ID),
    Koordinator_ID UUID REFERENCES Koordinator(Koordinator_ID),
    StatusVerifikasiLama VARCHAR(3),
    StatusVerifikasiBaru VARCHAR(3),
    Timestamp TIMESTAMP
);

CREATE SEQUENCE LogVerifikasi_ID_seq;

-- Terapkan trigger pada tabel log verifikasi yang akan menyimpan log perubahan kolom status verifikasi pada tabel Aktivitas Mahasiswa.
CREATE OR REPLACE FUNCTION log_verifikasi_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.Verifikasi <> NEW.Verifikasi THEN
        INSERT INTO LogVerifikasi (AktivitasMahasiswa_ID, StatusVerifikasiLama, StatusVerifikasiBaru, Koordinator_ID)
        VALUES (NEW.AktivitasMahasiswa_ID, OLD.Verifikasi, NEW.Verifikasi, NEW.Koordinator_ID);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER log_verifikasi
AFTER UPDATE ON AktivitasMahasiswa
FOR EACH ROW
EXECUTE FUNCTION log_verifikasi_trigger();

-- Buat test data untuk memastikan trigger berjalan dengan baik.
UPDATE AktivitasMahasiswa SET Verifikasi = 'ACC' WHERE AktivitasMahasiswa_ID = '83484b40-ec3a-48d4-a69f-c1444141a62c';

-- Buatlah INSTEAD OF trigger untuk menambahkan data melalui view pada soal no. 1.
CREATE OR REPLACE FUNCTION insert_mahasiswa_umkm()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Mahasiswa (Mahasiswa_ID, UMKM_ID, Nama)
    VALUES (NEW.Mahasiswa_ID, (SELECT UMKM_ID FROM UMKM WHERE Nama = NEW.nama_umkm), NEW.nama);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_mahasiswa_umkm_trigger
INSTEAD OF INSERT ON Mahasiswa_UMKM
FOR EACH ROW
EXECUTE FUNCTION insert_mahasiswa_umkm();

-- De;ete function on insert_mahasiswa_umkm and trigger on insert_mahasiswa_umkm_trigger
DROP FUNCTION insert_mahasiswa_umkm();
DROP TRIGGER insert_mahasiswa_umkm_trigger;

-- Buat test data untuk memastikan trigger berjalan dengan baik.
INSERT INTO Mahasiswa_UMKM (Mahasiswa_ID, nama, Nama_UMKM) VALUES ('c7cbb815-1cc1-41e7-86ce-d36057c8260c', 'Anthony', 'UMKM F');

-- Buatlah procedure yang mengganti semua value "Menunggu" menjadi "Ditolak" pada kolom status di tabel Pengajuan Sertifikasi bila sudah lebih dari 6 bulan semenjak sertifikasi diajukan.
CREATE OR REPLACE PROCEDURE update_pengajuan_sertifikasi()
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE PengajuanSertifikasi
    SET StatusPengajuan = 'Ditolak'
    WHERE StatusPengajuan = 'Mendaftar' AND TanggalPengajuan <= (current_date - interval '6 months');
    COMMIT;
END;
$$;

-- Jalankan procedurenya
CALL update_pengajuan_sertifikasi();

-- Buat fungsi perhitungan Insentif mahasiswa dimana insentif sebesar Rp50.000 diberikan per aktivitas yang sudah diverifikasi. Gunakan fungsi tersebut pada query untuk menampilkan daftar mahasiswa dan jumlah insentifnya.
CREATE OR REPLACE FUNCTION bigint_insentif()
RETURNS TABLE (Mahasiswa VARCHAR(50), Insentif BIGINT) AS $$
BEGIN
    RETURN QUERY
    SELECT m.Nama, COUNT(am.AktivitasMahasiswa_ID) * 50000 AS Insentif
    FROM Mahasiswa m
    JOIN AktivitasMahasiswa_Mahasiswa amm ON m.Mahasiswa_ID = amm.Mahasiswa_ID
    JOIN AktivitasMahasiswa am ON amm.AktivitasMahasiswa_ID = am.AktivitasMahasiswa_ID
    WHERE am.Verifikasi = 'ACC'
    GROUP BY m.Nama;
END;
$$ LANGUAGE plpgsql;

-- Jalankan fungsi tersebut
SELECT * FROM bigint_insentif();