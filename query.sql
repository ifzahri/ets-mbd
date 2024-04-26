-- View yang menampilkan mahasiswa dan UMKM yang dibantunya:
CREATE VIEW BantuUMKM AS
SELECT M.Nama AS Mahasiswa, U.Nama AS UMKM
FROM Mahasiswa M
JOIN UMKM U ON M.UMKM_ID = U.UMKM_ID;

-- View yang menampilkan nama mahasiswa dan jumlah UMKM yang pengajuan sertifikasinya "mendaftar", "Diterima", dan "Ditolak":
CREATE VIEW JumlahPengajuanSertifikasi AS
SELECT M.Nama AS Mahasiswa, 
       COUNT(CASE WHEN PS.StatusPengajuan = 'Mendaftar' THEN 1 END) AS JumlahMendaftar,
       COUNT(CASE WHEN PS.StatusPengajuan = 'Diterima' THEN 1 END) AS JumlahDiterima,
       COUNT(CASE WHEN PS.StatusPengajuan = 'Ditolak' THEN 1 END) AS JumlahDitolak
FROM Mahasiswa M
JOIN AktivitasMahasiswa AM ON M.Mahasiswa_ID = AM.Mahasiswa_ID
JOIN PengajuanSertifikasi PS ON AM.Mahasiswa_ID = PS.PengajuanSertifikasi_ID
GROUP BY M.Nama;

-- Tabel baru "LogVerifikasi" dengan autoincrement pada ID log:
-- Tabel LogVerifikasi
CREATE TABLE LogVerifikasi (
    Log_ID SERIAL PRIMARY KEY,
    AktivitasMahasiswa_ID INT REFERENCES AktivitasMahasiswa(AktivitasMahasiswa_ID),
    StatusVerifikasiLama VARCHAR(3),
    StatusVerifikasiBaru VARCHAR(3),
    Koordinator_ID INT REFERENCES Koordinator(Koordinator_ID),
    Timestamp TIMESTAMP
);
-- Sequence untuk ID log
CREATE SEQUENCE LogVerifikasi_ID_Sequence;

-- Trigger pada tabel LogVerifikasi untuk menyimpan log perubahan kolom status verifikasi pada tabel AktivitasMahasiswa:
CREATE OR REPLACE FUNCTION LogVerifikasiTriggerFunction()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO LogVerifikasi (AktivitasMahasiswa_ID, StatusVerifikasiLama, StatusVerifikasiBaru, Koordinator_ID, Timestamp)
    VALUES (OLD.AktivitasMahasiswa_ID, OLD.Verifikasi, NEW.Verifikasi, NEW.Koordinator_ID, NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER LogVerifikasiTrigger
AFTER UPDATE ON AktivitasMahasiswa
FOR EACH ROW
EXECUTE FUNCTION LogVerifikasiTriggerFunction();

-- INSTEAD OF trigger untuk menambahkan data melalui view "BantuUMKM":
CREATE OR REPLACE FUNCTION BantuUMKMTriggerFunction()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.Mahasiswa IS NOT NULL AND NEW.UMKM IS NOT NULL THEN
        INSERT INTO Mahasiswa (Nama, UMKM_ID)
        VALUES (NEW.Mahasiswa, (SELECT UMKM_ID FROM UMKM WHERE Nama = NEW.UMKM));
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER BantuUMKMTrigger
INSTEAD OF INSERT ON BantuUMKM
FOR EACH ROW
EXECUTE FUNCTION BantuUMKMTriggerFunction();

-- Procedure untuk mengganti semua value "Menunggu" menjadi "Ditolak" pada kolom status di tabel PengajuanSertifikasi bila sudah lebih dari 6 bulan semenjak sertifikasi diajukan:
CREATE OR REPLACE PROCEDURE UpdateStatusPengajuanSertifikasi()
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE PengajuanSertifikasi
    SET StatusPengajuan = 'Ditolak'
    WHERE StatusPengajuan = 'Menunggu' AND TanggalPengajuan <= CURRENT_DATE - INTERVAL '6 months';
END;
$$;

-- Fungsi perhitungan Insentif mahasiswa:
CREATE OR REPLACE FUNCTION CalculateIncentive()
RETURNS TABLE (Mahasiswa VARCHAR(50), Insentif INT) AS $$
BEGIN
    RETURN QUERY
    SELECT M.Nama, COUNT(AM.Verifikasi) * 50000 AS Insentif
    FROM Mahasiswa M
    JOIN AktivitasMahasiswa AM ON M.Mahasiswa_ID = AM.Mahasiswa_ID
    WHERE AM.Verifikasi = 'ACC'
    GROUP BY M.Nama;
END;
$$ LANGUAGE plpgsql;
SELECT * FROM CalculateIncentive();
