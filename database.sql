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

INSERT INTO UMKM (UMKM_ID, Nama, Status) VALUES
    ('d8589819-2ea8-4a73-a651-709ff41bd7f6', 'UMKM A', 1),
    ('1efe5929-1c07-4371-bfcf-6b06291506de', 'UMKM B', 1),
    ('265e7d47-06b2-4ab3-9261-7dc9fbb8c754', 'UMKM C', 0),
    ('f9eb5d7c-8e62-4a64-ace1-e673b896300b', 'UMKM D', 1),
    ('49e73fba-d58c-449a-a0ca-439f6810a3c7', 'UMKM E', 1),
    ('ee7e1440-127f-4644-82ab-a7c9295251c1', 'UMKM F', 0),
    ('0a288232-b68d-4fe0-84d4-a9ee2b82513c', 'UMKM G', 0),
    ('ca1bcfc1-dc2b-4198-bddd-78149b150376', 'UMKM H', 1),
    ('8f73604e-57de-4188-a5bc-b71101c11488', 'UMKM I', 1),
    ('ff862f97-0c1d-4003-9efe-78769609667b', 'UMKM J', 1);

INSERT INTO mahasiswa (mahasiswa_id, umkm_id, nama) VALUES
    ('8d69d5b0-b1f9-49e3-9d41-e45f0efdb58b', 'd8589819-2ea8-4a73-a651-709ff41bd7f6', 'Tunas Abdi'),
    ('8c96b30f-85da-4522-9af2-1aebdb3429c4', '1efe5929-1c07-4371-bfcf-6b06291506de', 'Bimatara'),
    ('c3fb5eb1-27aa-4df3-843f-91b9ff49ed51', '265e7d47-06b2-4ab3-9261-7dc9fbb8c754', 'Jericho'),
    ('8bf7ad52-d676-4f45-ba1d-f65cf6da1f60', 'f9eb5d7c-8e62-4a64-ace1-e673b896300b', 'Revy'),
    ('91bc5f7e-17c4-4837-8a18-530344ed3686', '49e73fba-d58c-449a-a0ca-439f6810a3c7', 'Adit'),
    ('a2b723a1-51c9-4742-b54e-ff08a7b04bb7', 'ee7e1440-127f-4644-82ab-a7c9295251c1', 'Nainggolan'),
    ('2143a8d3-a61e-4eb4-9269-570308db33af', '0a288232-b68d-4fe0-84d4-a9ee2b82513c', 'Fairuuz'),
    ('34cf36e7-9e4e-4e20-8cb1-9553cf0a2590', 'ca1bcfc1-dc2b-4198-bddd-78149b150376', 'Genta'),
    ('edda8926-abb9-4bc9-8bd1-3fc5eeefb4b1', '8f73604e-57de-4188-a5bc-b71101c11488', 'Ranto'),
    ('965db2c8-6ea8-450e-9c02-1dc685ddcd04', 'ff862f97-0c1d-4003-9efe-78769609667b', 'Haikal');

INSERT INTO koordinator (koordinator_id, nama) VALUES
    ('da5aebf4-3760-46ac-af2d-cbd7abd87ebd', 'Koordinator A'),
    ('dc517252-a816-427b-a6ea-b6199242cac3', 'Koordinator B'),
    ('8b8da28f-993e-4485-ab70-5247035725ee', 'Koordinator C'),
    ('af3d945e-af9b-49f8-9d3e-c8664daabc83', 'Koordinator D'),
    ('5c7907dc-3162-4df2-be5d-2694c119c15b', 'Koordinator E'),
    ('ee0b3302-5e9c-4b75-af31-239fe1de0f8f', 'Koordinator F'),
    ('07368dd9-4f7a-453a-a696-5ebb40954a45', 'Koordinator G'),
    ('9df4a90c-4fa6-4c5d-ac54-7fb1b95c823d', 'Koordinator H'),
    ('f4392316-7d73-4c81-9a56-0b64252ac893', 'Koordinator I'),
    ('740c3c73-8b28-4905-9546-dff1c29cee35', 'Koordinator J');

INSERT INTO aktivitasmahasiswa (aktivitasmahasiswa_id, koordinator_id, tanggal, namaaktivitas, verifikasi) VALUES
    ('63c7ab98-23a9-43ee-b7a3-84eae3e1d8a1', 'da5aebf4-3760-46ac-af2d-cbd7abd87ebd', '2024-04-10', 'Membuat banner', 'ACC'),
    ('052407a6-068d-4986-a849-7af0ab939d2c', 'dc517252-a816-427b-a6ea-b6199242cac3', '2024-04-04', 'Mengajukan sertifikasi', 'ACC'),
    ('70f2b200-ea2d-41a7-ac37-38f94f945018', '8b8da28f-993e-4485-ab70-5247035725ee', '2024-04-22', 'Mengumpulkan data', 'ACC'),
    ('83484b40-ec3a-48d4-a69f-c1444141a62c', 'af3d945e-af9b-49f8-9d3e-c8664daabc83', '2024-04-13', 'Mengajukan sertifikasi', 'NO'),
    ('4e890035-fe1f-415f-8bc9-4f50bdfbd51b', '5c7907dc-3162-4df2-be5d-2694c119c15b', '2024-04-14', 'Membuat logo', 'ACC'),
    ('2b8cd395-5fdb-4983-a02e-36c24965bb59', 'ee0b3302-5e9c-4b75-af31-239fe1de0f8f', '2024-04-13', 'Menjadi kuli', 'NO'),
    ('23b66043-abf8-4101-8aaf-dc40d2a958a7', '07368dd9-4f7a-453a-a696-5ebb40954a45', '2024-04-21', 'Membersihkan kantor', 'NO'),
    ('64f617a7-9fee-4547-b8bb-492a50c7ee50', '9df4a90c-4fa6-4c5d-ac54-7fb1b95c823d', '2024-04-08', 'Mengumpulkan data', 'ACC'),
    ('11241f5e-ed8a-476d-85f9-ab3200e5b0fb', 'f4392316-7d73-4c81-9a56-0b64252ac893', '2024-04-19', 'Mengajukan sertifikasi', 'ACC'),
    ('0e09b29c-5e24-4036-b167-58ca2b43a4c3', '740c3c73-8b28-4905-9546-dff1c29cee35', '2024-04-12', 'Mengajukan sertifikasi', 'NO');

INSERT INTO pengajuansertifikasi (pengajuansertifikasi_id, tanggalpengajuan, namasertifikasi, statuspengajuan) VALUES
    ('b7087c7f-f3bc-40a2-adb4-ce34035aa7b4', '2024-04-10', 'Sertifikasi A', 'Mendaftar'),
    ('9597d595-d1e9-490e-a9db-de5d755a38ea', '2024-04-04', 'Sertifikasi B', 'Mendaftar'),
    ('585045ed-1809-4f43-93bd-e6915751e6cc', '2024-04-22', 'Sertifikasi C', 'Ditolak'),
    ('153bd5d8-875e-4330-aa41-5a863641978b', '2024-04-13', 'Sertifikasi D', 'Mendaftar'),
    ('4f3dee27-acba-4413-b89b-84e93840a6bc', '2024-04-14', 'Sertifikasi E', 'Mendaftar'),
    ('1a4e908c-49c5-4292-9748-ad39d4e9a6cf', '2024-04-13', 'Sertifikasi F', 'Diterima'),
    ('e1376ef6-e988-4523-8648-62db43f2f088', '2024-04-21', 'Sertifikasi G', 'Mendaftar'),
    ('fa4516e7-0d44-42d3-a0a6-71fba36e8817', '2024-04-08', 'Sertifikasi H', 'Diterima'),
    ('8110e0d0-ad4c-47eb-9bc6-1f3b7db60ce7', '2024-04-19', 'Sertifikasi I', 'Ditolak'),
    ('a62eb54b-2add-4a75-b902-2963b65e6d15', '2024-04-12', 'Sertifikasi J', 'Mendaftar');

INSERT INTO aktivitasmahasiswa_mahasiswa (aktivitasmahasiswa_id, mahasiswa_id) VALUES
    ('63c7ab98-23a9-43ee-b7a3-84eae3e1d8a1', '8d69d5b0-b1f9-49e3-9d41-e45f0efdb58b'),
    ('052407a6-068d-4986-a849-7af0ab939d2c', '8c96b30f-85da-4522-9af2-1aebdb3429c4'),
    ('70f2b200-ea2d-41a7-ac37-38f94f945018', 'c3fb5eb1-27aa-4df3-843f-91b9ff49ed51'),
    ('83484b40-ec3a-48d4-a69f-c1444141a62c', '8bf7ad52-d676-4f45-ba1d-f65cf6da1f60'),
    ('4e890035-fe1f-415f-8bc9-4f50bdfbd51b', '91bc5f7e-17c4-4837-8a18-530344ed3686'),
    ('2b8cd395-5fdb-4983-a02e-36c24965bb59', 'a2b723a1-51c9-4742-b54e-ff08a7b04bb7'),
    ('23b66043-abf8-4101-8aaf-dc40d2a958a7', '2143a8d3-a61e-4eb4-9269-570308db33af'),
    ('64f617a7-9fee-4547-b8bb-492a50c7ee50', '34cf36e7-9e4e-4e20-8cb1-9553cf0a2590'),
    ('11241f5e-ed8a-476d-85f9-ab3200e5b0fb', 'edda8926-abb9-4bc9-8bd1-3fc5eeefb4b1'),
    ('0e09b29c-5e24-4036-b167-58ca2b43a4c3', '965db2c8-6ea8-450e-9c02-1dc685ddcd04');

INSERT INTO pengajuansertifikasi_mahasiswa (pengajuansertifikasi_id, mahasiswa_id) VALUES
    ('b7087c7f-f3bc-40a2-adb4-ce34035aa7b4', '8d69d5b0-b1f9-49e3-9d41-e45f0efdb58b'),
    ('9597d595-d1e9-490e-a9db-de5d755a38ea', '8c96b30f-85da-4522-9af2-1aebdb3429c4'),
    ('585045ed-1809-4f43-93bd-e6915751e6cc', 'c3fb5eb1-27aa-4df3-843f-91b9ff49ed51'),
    ('153bd5d8-875e-4330-aa41-5a863641978b', '8bf7ad52-d676-4f45-ba1d-f65cf6da1f60'),
    ('4f3dee27-acba-4413-b89b-84e93840a6bc', '91bc5f7e-17c4-4837-8a18-530344ed3686'),
    ('1a4e908c-49c5-4292-9748-ad39d4e9a6cf', 'a2b723a1-51c9-4742-b54e-ff08a7b04bb7'),
    ('e1376ef6-e988-4523-8648-62db43f2f088', '2143a8d3-a61e-4eb4-9269-570308db33af'),
    ('fa4516e7-0d44-42d3-a0a6-71fba36e8817', '34cf36e7-9e4e-4e20-8cb1-9553cf0a2590'),
    ('8110e0d0-ad4c-47eb-9bc6-1f3b7db60ce7', 'edda8926-abb9-4bc9-8bd1-3fc5eeefb4b1'),
    ('a62eb54b-2add-4a75-b902-2963b65e6d15', '965db2c8-6ea8-450e-9c02-1dc685ddcd04');