-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Waktu pembuatan: 09 Nov 2025 pada 07.47
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smarthealthcare`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `apoteker`
--

CREATE TABLE `apoteker` (
  `id_apoteker` bigint(20) UNSIGNED NOT NULL,
  `id_pengguna` bigint(20) UNSIGNED NOT NULL,
  `no_lisensi` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `detail_resep`
--

CREATE TABLE `detail_resep` (
  `id_detail` bigint(20) UNSIGNED NOT NULL,
  `id_resep` bigint(20) UNSIGNED NOT NULL,
  `id_obat` bigint(20) UNSIGNED NOT NULL,
  `jumlah` int(11) NOT NULL,
  `dosis` varchar(100) DEFAULT NULL,
  `instruksi` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `dokter`
--

CREATE TABLE `dokter` (
  `id_dokter` bigint(20) UNSIGNED NOT NULL,
  `id_pengguna` bigint(20) UNSIGNED NOT NULL,
  `spesialisasi` varchar(100) NOT NULL,
  `no_lisensi` varchar(100) NOT NULL,
  `biaya_konsultasi` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `shift` enum('pagi','malam') NOT NULL DEFAULT 'pagi'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `dokter`
--

INSERT INTO `dokter` (`id_dokter`, `id_pengguna`, `spesialisasi`, `no_lisensi`, `biaya_konsultasi`, `created_at`, `updated_at`, `deleted_at`, `shift`) VALUES
(1, 1, 'Ahli Sihir', '12345678', 100000.00, '2025-11-08 19:40:22', '2025-11-08 19:40:22', NULL, 'pagi');

-- --------------------------------------------------------

--
-- Struktur dari tabel `janji_temu`
--

CREATE TABLE `janji_temu` (
  `id_janji_temu` bigint(20) UNSIGNED NOT NULL,
  `id_pasien` bigint(20) UNSIGNED NOT NULL,
  `id_dokter` bigint(20) UNSIGNED NOT NULL,
  `tanggal_janji` date NOT NULL,
  `waktu_mulai` time NOT NULL,
  `waktu_selesai` time NOT NULL,
  `status` enum('terjadwal','selesai','dibatalkan') NOT NULL DEFAULT 'terjadwal',
  `keluhan` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `janji_temu`
--

INSERT INTO `janji_temu` (`id_janji_temu`, `id_pasien`, `id_dokter`, `tanggal_janji`, `waktu_mulai`, `waktu_selesai`, `status`, `keluhan`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, '2025-11-10', '00:00:00', '00:00:00', 'dibatalkan', 'Sakit kepala dan mual', '2025-11-08 21:49:13', '2025-11-08 21:52:00', NULL),
(2, 1, 1, '2025-11-10', '00:00:00', '00:00:00', 'selesai', 'Sakit kepala dan masuk angin', '2025-11-08 21:57:21', '2025-11-08 22:00:22', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2025_11_09_015159_create_pengguna_table', 1),
(2, '2025_11_09_015212_create_dokter_table', 1),
(3, '2025_11_09_015226_create_pasien_table', 1),
(4, '2025_11_09_015239_create_apoteker_table', 1),
(5, '2025_11_09_015252_create_janji_temu_table', 1),
(6, '2025_11_09_015306_create_rekam_medis_table', 1),
(7, '2025_11_09_015321_create_obat_table', 1),
(8, '2025_11_09_015336_create_resep_table', 1),
(9, '2025_11_09_015349_create_detail_resep_table', 1),
(10, '2025_11_09_015407_create_transaksi_farmasi_table', 1),
(11, '2025_11_09_025034_create_personal_access_tokens_table', 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `obat`
--

CREATE TABLE `obat` (
  `id_obat` bigint(20) UNSIGNED NOT NULL,
  `nama_obat` varchar(255) NOT NULL,
  `kategori` varchar(100) DEFAULT NULL,
  `harga` decimal(10,2) DEFAULT NULL,
  `stok` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pasien`
--

CREATE TABLE `pasien` (
  `id_pasien` bigint(20) UNSIGNED NOT NULL,
  `id_pengguna` bigint(20) UNSIGNED NOT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `golongan_darah` varchar(5) DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `pasien`
--

INSERT INTO `pasien` (`id_pasien`, `id_pengguna`, `tanggal_lahir`, `golongan_darah`, `alamat`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 2, '2003-12-01', 'O', 'jalan avengers', '2025-11-08 19:40:22', '2025-11-08 19:40:22', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pengguna`
--

CREATE TABLE `pengguna` (
  `id_pengguna` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('pasien','dokter','apoteker','admin') NOT NULL,
  `nama_lengkap` varchar(255) NOT NULL,
  `no_telepon` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `pengguna`
--

INSERT INTO `pengguna` (`id_pengguna`, `email`, `password_hash`, `role`, `nama_lengkap`, `no_telepon`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'raihanstrange@gmail.com', '$2y$12$r/b5RUA90.Q/jnBTznf6euHRB1zgtvX1Du8iCEpFB3pbpQK.jVIB.', 'dokter', 'Raihan Strange', '085156401610', '2025-11-08 19:40:22', '2025-11-08 19:40:22', NULL),
(2, 'raihanstark@gmail.com', '$2y$12$kJvCw/VZBxHXcUSpot2y4.EMqpktvBd0BOeG3k4QpkaFi1czTuCY.', 'pasien', 'Raihan Stark', '085156401611', '2025-11-08 19:40:22', '2025-11-08 19:40:22', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\Pengguna', 2, 'auth_token', 'db6cbfd383108d8bde4ff5ba9b6329b4ba7f5b6d9be7aec06a91d99587c68c84', '[\"*\"]', NULL, NULL, '2025-11-08 19:51:04', '2025-11-08 19:51:04'),
(2, 'App\\Models\\Pengguna', 2, 'auth_token', '1fb32f54e6d7f931a7961e1370fb981c7c1401933b441bc6f1f9e42c08e43e6e', '[\"*\"]', NULL, NULL, '2025-11-08 19:54:32', '2025-11-08 19:54:32'),
(3, 'App\\Models\\Pengguna', 2, 'auth_token', '1e18bf102b4658807916ac95930312978cefb23be014db2d2bd913a38ab57202', '[\"*\"]', NULL, NULL, '2025-11-08 19:56:41', '2025-11-08 19:56:41'),
(4, 'App\\Models\\Pengguna', 2, 'auth_token', '38375e6005890be9c8a796b43fabe2c88dc425908c9655499a56dd0dbe18918f', '[\"*\"]', NULL, NULL, '2025-11-08 21:35:36', '2025-11-08 21:35:36'),
(5, 'App\\Models\\Pengguna', 2, 'auth_token', '4d6220cff7ecfdaf837874dacf270b3d28583abeafcd75052b05782f52329478', '[\"*\"]', '2025-11-08 21:41:23', NULL, '2025-11-08 21:40:53', '2025-11-08 21:41:23'),
(6, 'App\\Models\\Pengguna', 2, 'auth_token', '832c8632f45cd8892c038b16494e62468f02ba9fbc0bccf200308f53b9f12e51', '[\"*\"]', '2025-11-08 21:52:19', NULL, '2025-11-08 21:47:12', '2025-11-08 21:52:19'),
(7, 'App\\Models\\Pengguna', 2, 'auth_token', '1665aa0e5068371c6c2688f4482e93d70b5f9d12f8633ff63e7adbe0d61cfa4e', '[\"*\"]', '2025-11-08 22:00:45', NULL, '2025-11-08 21:54:03', '2025-11-08 22:00:45'),
(8, 'App\\Models\\Pengguna', 1, 'auth_token', '207d4f182f9c8faab604dbeedc5c3d4483a7fd841535b37738e439e9b14bcd24', '[\"*\"]', '2025-11-08 22:00:22', NULL, '2025-11-08 21:59:16', '2025-11-08 22:00:22'),
(9, 'App\\Models\\Pengguna', 2, 'auth_token', '8fb38374f6f03eaf0ed37943ffa4b363d008e51ee6a4e59976b1fcc73b7e6e2e', '[\"*\"]', NULL, NULL, '2025-11-08 22:38:01', '2025-11-08 22:38:01'),
(10, 'App\\Models\\Pengguna', 2, 'auth_token', '01794ffb6fc1373609fba8c2707e1c3e0aca09a8b9548159ef249c8d69f77cc8', '[\"*\"]', NULL, NULL, '2025-11-08 22:55:20', '2025-11-08 22:55:20'),
(11, 'App\\Models\\Pengguna', 2, 'auth_token', 'de01a2de94c67083f23e10e3859c0ccb765282e766c9994b0e3b1deadb8d772a', '[\"*\"]', NULL, NULL, '2025-11-08 23:03:59', '2025-11-08 23:03:59'),
(12, 'App\\Models\\Pengguna', 2, 'auth_token', '1721d0a80c8d40ad8927b30a98481435fba8e390b20d9fc1cd3ff184697d259d', '[\"*\"]', NULL, NULL, '2025-11-08 23:08:24', '2025-11-08 23:08:24'),
(13, 'App\\Models\\Pengguna', 2, 'auth_token', '3f657e208a93ad83d4b96741f54b737fb70b755cad9e139a5afae4bdbbc3d6df', '[\"*\"]', NULL, NULL, '2025-11-08 23:12:16', '2025-11-08 23:12:16'),
(14, 'App\\Models\\Pengguna', 2, 'auth_token', '8e61dd3f7a94e7be65dfc10500934097d90ebc0cb7b8534967f2d81823e99c23', '[\"*\"]', NULL, NULL, '2025-11-08 23:16:20', '2025-11-08 23:16:20'),
(15, 'App\\Models\\Pengguna', 2, 'auth_token', '3982f9c2e0bb6ca24d5da4c80aeb17a972530885a70883759af1a8897ea89b26', '[\"*\"]', NULL, NULL, '2025-11-08 23:21:14', '2025-11-08 23:21:14'),
(16, 'App\\Models\\Pengguna', 2, 'auth_token', 'c2c0f1c1799d414e9fd919af85165c1744cb0039a343dcb12192b0afc6b0732a', '[\"*\"]', NULL, NULL, '2025-11-08 23:26:58', '2025-11-08 23:26:58'),
(17, 'App\\Models\\Pengguna', 2, 'auth_token', '67d1408d96b9c3e1b84826753e6e58f2e65b3e935988a64a98a7edd519d92781', '[\"*\"]', NULL, NULL, '2025-11-08 23:27:31', '2025-11-08 23:27:31');

-- --------------------------------------------------------

--
-- Struktur dari tabel `rekam_medis`
--

CREATE TABLE `rekam_medis` (
  `id_rekam_medis` bigint(20) UNSIGNED NOT NULL,
  `id_pasien` bigint(20) UNSIGNED NOT NULL,
  `id_dokter` bigint(20) UNSIGNED NOT NULL,
  `id_janji_temu` bigint(20) UNSIGNED DEFAULT NULL,
  `tanggal_kunjungan` date NOT NULL,
  `diagnosis` text DEFAULT NULL,
  `tindakan` text DEFAULT NULL,
  `catatan` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `resep`
--

CREATE TABLE `resep` (
  `id_resep` bigint(20) UNSIGNED NOT NULL,
  `id_rekam_medis` bigint(20) UNSIGNED NOT NULL,
  `tanggal_resep` date NOT NULL,
  `status` enum('menunggu','diserahkan','dibatalkan') NOT NULL DEFAULT 'menunggu',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi_farmasi`
--

CREATE TABLE `transaksi_farmasi` (
  `id_transaksi` bigint(20) UNSIGNED NOT NULL,
  `id_resep` bigint(20) UNSIGNED NOT NULL,
  `id_apoteker` bigint(20) UNSIGNED NOT NULL,
  `tanggal_transaksi` timestamp NULL DEFAULT NULL,
  `total_harga` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `apoteker`
--
ALTER TABLE `apoteker`
  ADD PRIMARY KEY (`id_apoteker`),
  ADD UNIQUE KEY `apoteker_no_lisensi_unique` (`no_lisensi`),
  ADD KEY `apoteker_id_pengguna_foreign` (`id_pengguna`);

--
-- Indeks untuk tabel `detail_resep`
--
ALTER TABLE `detail_resep`
  ADD PRIMARY KEY (`id_detail`),
  ADD KEY `detail_resep_id_resep_foreign` (`id_resep`),
  ADD KEY `detail_resep_id_obat_foreign` (`id_obat`);

--
-- Indeks untuk tabel `dokter`
--
ALTER TABLE `dokter`
  ADD PRIMARY KEY (`id_dokter`),
  ADD UNIQUE KEY `dokter_no_lisensi_unique` (`no_lisensi`),
  ADD KEY `dokter_id_pengguna_foreign` (`id_pengguna`);

--
-- Indeks untuk tabel `janji_temu`
--
ALTER TABLE `janji_temu`
  ADD PRIMARY KEY (`id_janji_temu`),
  ADD KEY `janji_temu_id_pasien_foreign` (`id_pasien`),
  ADD KEY `janji_temu_id_dokter_foreign` (`id_dokter`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `obat`
--
ALTER TABLE `obat`
  ADD PRIMARY KEY (`id_obat`);

--
-- Indeks untuk tabel `pasien`
--
ALTER TABLE `pasien`
  ADD PRIMARY KEY (`id_pasien`),
  ADD KEY `pasien_id_pengguna_foreign` (`id_pengguna`);

--
-- Indeks untuk tabel `pengguna`
--
ALTER TABLE `pengguna`
  ADD PRIMARY KEY (`id_pengguna`),
  ADD UNIQUE KEY `pengguna_email_unique` (`email`);

--
-- Indeks untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indeks untuk tabel `rekam_medis`
--
ALTER TABLE `rekam_medis`
  ADD PRIMARY KEY (`id_rekam_medis`),
  ADD KEY `rekam_medis_id_pasien_foreign` (`id_pasien`),
  ADD KEY `rekam_medis_id_dokter_foreign` (`id_dokter`),
  ADD KEY `rekam_medis_id_janji_temu_foreign` (`id_janji_temu`);

--
-- Indeks untuk tabel `resep`
--
ALTER TABLE `resep`
  ADD PRIMARY KEY (`id_resep`),
  ADD KEY `resep_id_rekam_medis_foreign` (`id_rekam_medis`);

--
-- Indeks untuk tabel `transaksi_farmasi`
--
ALTER TABLE `transaksi_farmasi`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD KEY `transaksi_farmasi_id_resep_foreign` (`id_resep`),
  ADD KEY `transaksi_farmasi_id_apoteker_foreign` (`id_apoteker`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `apoteker`
--
ALTER TABLE `apoteker`
  MODIFY `id_apoteker` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `detail_resep`
--
ALTER TABLE `detail_resep`
  MODIFY `id_detail` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `dokter`
--
ALTER TABLE `dokter`
  MODIFY `id_dokter` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `janji_temu`
--
ALTER TABLE `janji_temu`
  MODIFY `id_janji_temu` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT untuk tabel `obat`
--
ALTER TABLE `obat`
  MODIFY `id_obat` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pasien`
--
ALTER TABLE `pasien`
  MODIFY `id_pasien` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `pengguna`
--
ALTER TABLE `pengguna`
  MODIFY `id_pengguna` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT untuk tabel `rekam_medis`
--
ALTER TABLE `rekam_medis`
  MODIFY `id_rekam_medis` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `resep`
--
ALTER TABLE `resep`
  MODIFY `id_resep` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `transaksi_farmasi`
--
ALTER TABLE `transaksi_farmasi`
  MODIFY `id_transaksi` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `apoteker`
--
ALTER TABLE `apoteker`
  ADD CONSTRAINT `apoteker_id_pengguna_foreign` FOREIGN KEY (`id_pengguna`) REFERENCES `pengguna` (`id_pengguna`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `detail_resep`
--
ALTER TABLE `detail_resep`
  ADD CONSTRAINT `detail_resep_id_obat_foreign` FOREIGN KEY (`id_obat`) REFERENCES `obat` (`id_obat`) ON DELETE CASCADE,
  ADD CONSTRAINT `detail_resep_id_resep_foreign` FOREIGN KEY (`id_resep`) REFERENCES `resep` (`id_resep`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `dokter`
--
ALTER TABLE `dokter`
  ADD CONSTRAINT `dokter_id_pengguna_foreign` FOREIGN KEY (`id_pengguna`) REFERENCES `pengguna` (`id_pengguna`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `janji_temu`
--
ALTER TABLE `janji_temu`
  ADD CONSTRAINT `janji_temu_id_dokter_foreign` FOREIGN KEY (`id_dokter`) REFERENCES `dokter` (`id_dokter`) ON DELETE CASCADE,
  ADD CONSTRAINT `janji_temu_id_pasien_foreign` FOREIGN KEY (`id_pasien`) REFERENCES `pasien` (`id_pasien`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `pasien`
--
ALTER TABLE `pasien`
  ADD CONSTRAINT `pasien_id_pengguna_foreign` FOREIGN KEY (`id_pengguna`) REFERENCES `pengguna` (`id_pengguna`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `rekam_medis`
--
ALTER TABLE `rekam_medis`
  ADD CONSTRAINT `rekam_medis_id_dokter_foreign` FOREIGN KEY (`id_dokter`) REFERENCES `dokter` (`id_dokter`) ON DELETE CASCADE,
  ADD CONSTRAINT `rekam_medis_id_janji_temu_foreign` FOREIGN KEY (`id_janji_temu`) REFERENCES `janji_temu` (`id_janji_temu`) ON DELETE SET NULL,
  ADD CONSTRAINT `rekam_medis_id_pasien_foreign` FOREIGN KEY (`id_pasien`) REFERENCES `pasien` (`id_pasien`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `resep`
--
ALTER TABLE `resep`
  ADD CONSTRAINT `resep_id_rekam_medis_foreign` FOREIGN KEY (`id_rekam_medis`) REFERENCES `rekam_medis` (`id_rekam_medis`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `transaksi_farmasi`
--
ALTER TABLE `transaksi_farmasi`
  ADD CONSTRAINT `transaksi_farmasi_id_apoteker_foreign` FOREIGN KEY (`id_apoteker`) REFERENCES `apoteker` (`id_apoteker`) ON DELETE CASCADE,
  ADD CONSTRAINT `transaksi_farmasi_id_resep_foreign` FOREIGN KEY (`id_resep`) REFERENCES `resep` (`id_resep`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
