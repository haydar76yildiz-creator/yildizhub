-- YıldızHub Dernek Platformu - Veritabanı
-- 9 Örnek Dernek ile Başlangıç

-- Tablolar
CREATE TABLE dernekler (
  id INT PRIMARY KEY AUTO_INCREMENT,
  ad VARCHAR(255) NOT NULL,
  aciklama TEXT,
  kategori VARCHAR(100),
  kurulusTarihi DATE,
  uyeSayisi INT DEFAULT 0,
  logo VARCHAR(255),
  resim VARCHAR(255),
  email VARCHAR(255),
  telefon VARCHAR(20),
  adres TEXT,
  web VARCHAR(255),
  durum VARCHAR(50) DEFAULT 'Aktif',
  olusturmaTarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE kullanicilar (
  id INT PRIMARY KEY AUTO_INCREMENT,
  dernek_id INT,
  ad VARCHAR(255) NOT NULL,
  soyad VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  sifre VARCHAR(255) NOT NULL,
  rol VARCHAR(50) DEFAULT 'Üye',
  durum VARCHAR(50) DEFAULT 'Aktif',
  olusturmaTarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (dernek_id) REFERENCES dernekler(id)
);

CREATE TABLE etkinlikler (
  id INT PRIMARY KEY AUTO_INCREMENT,
  dernek_id INT NOT NULL,
  baslik VARCHAR(255) NOT NULL,
  aciklama TEXT,
  tarih DATETIME,
  yer VARCHAR(255),
  katilimci_sayisi INT DEFAULT 0,
  durum VARCHAR(50) DEFAULT 'Planlandi',
  olusturmaTarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (dernek_id) REFERENCES dernekler(id)
);

CREATE TABLE haberler (
  id INT PRIMARY KEY AUTO_INCREMENT,
  dernek_id INT NOT NULL,
  baslik VARCHAR(255) NOT NULL,
  icerik TEXT,
  yazar_id INT,
  resim VARCHAR(255),
  olusturmaTarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (dernek_id) REFERENCES dernekler(id),
  FOREIGN KEY (yazar_id) REFERENCES kullanicilar(id)
);

CREATE TABLE uye_istekleri (
  id INT PRIMARY KEY AUTO_INCREMENT,
  dernek_id INT NOT NULL,
  ad VARCHAR(255) NOT NULL,
  soyad VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  telefon VARCHAR(20),
  mesaj TEXT,
  durum VARCHAR(50) DEFAULT 'Beklemede',
  olusturmaTarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (dernek_id) REFERENCES dernekler(id)
);

-- ÖRNEK VERİLER

-- 1. SOSYAL DERNEKLER
INSERT INTO dernekler (ad, aciklama, kategori, kurulusTarihi, uyeSayisi, email, telefon, adres, web) VALUES
('İstanbul Sosyal Yardım Derneği', 'İstanbul ve çevresinde sosyal yardım hizmetleri sunan dernek', 'Sosyal', '2015-05-10', 245, 'info@istanbulsosyal.org', '+90 212 555 0001', 'İstanbul', 'www.istanbulsosyal.org'),
('Ankara Gençlik Derneği', 'Gençlerin sosyal ve kültürel gelişimini destekleyen dernek', 'Sosyal', '2018-03-20', 180, 'info@ankaragens.org', '+90 312 555 0002', 'Ankara', 'www.ankaragens.org'),
('İzmir Toplum Kalkınma Derneği', 'İzmir bölgesinde toplum kalkınması için çalışan dernek', 'Sosyal', '2016-07-15', 320, 'info@izmirtoplum.org', '+90 232 555 0003', 'İzmir', 'www.izmirtoplum.org'),

-- 2. KÜLTÜR DERNEKLERI
('Türk Kültür ve Sanat Derneği', 'Türk kültür ve sanatının korunması ve tanıtımı', 'Kültür', '2014-01-12', 410, 'info@turkkultür.org', '+90 216 555 0004', 'İstanbul', 'www.turkkultür.org'),
('Geleneksel Sanatlar Koruma Derneği', 'Geleneksel sanatları koruma ve geliştirilmesi', 'Kültür', '2017-09-08', 155, 'info@gelensanatlar.org', '+90 312 555 0005', 'Ankara', 'www.gelensanatlar.org'),
('Edebiyat ve Sanat Platformu', 'Edebiyat, ressam ve sanatçılar için platform', 'Kültür', '2019-02-20', 290, 'info@edebyatsanat.org', '+90 232 555 0006', 'İzmir', 'www.edebyatsanat.org'),

-- 3. HAYVANSEVERLERI DERNEKLERI
('Sokak Hayvanları Koruma Derneği', 'Sokak hayvanlarının bakım ve korunması', 'Hayvansever', '2013-06-05', 540, 'info@sokakhayvan.org', '+90 212 555 0007', 'İstanbul', 'www.sokakhayvan.org'),
('Doğa ve Hayvan Koruma Derneği', 'Doğa ve yaban hayatının korunması', 'Hayvansever', '2015-11-30', 385, 'info@doğahayvan.org', '+90 312 555 0008', 'Ankara', 'www.doğahayvan.org'),
('Evcil Hayvan Sahipleri Derneği', 'Evcil hayvan sahipleri için ağ ve destek', 'Hayvansever', '2018-04-18', 265, 'info@evcilhayvan.org', '+90 232 555 0009', 'İzmir', 'www.evcilhayvan.org');

-- YÖNETICI KULLANICILAR (Her dernek için 1)
INSERT INTO kullanicilar (dernek_id, ad, soyad, email, sifre, rol) VALUES
(1, 'Ahmet', 'Yılmaz', 'admin@istanbulsosyal.org', '$2y$10$abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', 'Yönetici'),
(2, 'Fatih', 'Kara', 'admin@ankaragens.org', '$2y$10$abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', 'Yönetici'),
(3, 'Zeynep', 'Demir', 'admin@izmirtoplum.org', '$2y$10$abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', 'Yönetici'),
(4, 'Mehmet', 'Çetin', 'admin@turkkultür.org', '$2y$10$abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', 'Yönetici'),
(5, 'Ayşe', 'Aydın', 'admin@gelensanatlar.org', '$2y$10$abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', 'Yönetici'),
(6, 'İbrahim', 'Şahin', 'admin@edebyatsanat.org', '$2y$10$abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', 'Yönetici'),
(7, 'Gül', 'Turan', 'admin@sokakhayvan.org', '$2y$10$abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', 'Yönetici'),
(8, 'Cem', 'Koç', 'admin@doğahayvan.org', '$2y$10$abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', 'Yönetici'),
(9, 'Elif', 'Sezer', 'admin@evcilhayvan.org', '$2y$10$abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', 'Yönetici');

-- ÖRNEK ETKİNLİKLER
INSERT INTO etkinlikler (dernek_id, baslik, aciklama, tarih, yer, katilimci_sayisi, durum) VALUES
(1, 'İhtiyaç Sahibi Ailelere Yardım Kampanyası', 'Ramadan ayında 100 aileye yardım dağıtımı', '2026-06-15 14:00:00', 'İstanbul Merkez', 50, 'Planlandi'),
(2, 'Gençlik Liderlik Semineri', 'Gençlerin liderlik becerilerini geliştirme', '2026-06-20 10:00:00', 'Ankara Kültür Merkezi', 75, 'Planlandi'),
(3, 'Çevre Temizliği Projesi', 'İzmir sahilinin temizliği', '2026-06-25 09:00:00', 'İzmir Sahili', 120, 'Planlandi'),
(4, 'Türk Sanat Sergisi', 'Geleneksel Türk sanatı sergisi', '2026-07-10 16:00:00', 'İstanbul Sanat Galerisi', 200, 'Planlandi'),
(5, 'Ebru Sanatı Atölyesi', 'Ebru sanatının öğretimi', '2026-07-05 14:00:00', 'Ankara Sanat Merkezi', 40, 'Planlandi'),
(6, 'Şiir Dinletisi', 'Ünlü şairlerle şiir dinletisi', '2026-07-15 19:00:00', 'İzmir Sanat Evi', 150, 'Planlandi'),
(7, 'Hayvan Sahipleri Buluşması', 'Evcil hayvan sahipleri ağı', '2026-06-30 15:00:00', 'İstanbul Parkı', 80, 'Planlandi'),
(8, 'Doğa Yürüyüşü', 'Ankara ormanlarında doğa yürüyüşü', '2026-06-22 07:00:00', 'Ankara Ormanları', 60, 'Planlandi'),
(9, 'Pet Expo 2026', 'Evcil hayvanlar fuarı', '2026-07-20 10:00:00', 'İzmir Fuar Alanı', 300, 'Planlandi');

-- ÖRNEK HABERLER
INSERT INTO haberler (dernek_id, baslik, icerik, yazar_id) VALUES
(1, 'Yeni Sosyal Projemiz Başladı', 'İstanbul Sosyal Yardım Derneği olarak yeni bir sosyal proje başlattığımızı duyurmaktan mutluluk duyuyoruz.', 1),
(2, 'Gençlere Burs Programı', 'Başarılı öğrenciler için aylık burs programı başlatılmıştır.', 2),
(3, 'Çevre Bilinci Kampanyası', 'İzmir bölgesinde çevre bilinci kampanyası yürütülmektedir.', 3),
(4, 'Sanat Sergisi Açıldı', 'Türk Kültür Derneği olarak yeni sanat sergimiz açıldı.', 4),
(5, 'Geleneksel Sanatlar Korunuyor', 'Geleneksel sanatlarımızın korunması için yeni projeler başlandı.', 5),
(6, 'Edebiyat Ödülleri Verildi', 'Başarılı yazarlar ödüllendirildi.', 6),
(7, 'Sokak Hayvanları İçin Yeni Merkezimiz', 'Sokak hayvanları için bakım ve tedavi merkezi açıldı.', 7),
(8, 'Doğa Koruma Projesi', 'Ankara ormanlarının korunması için yeni proje başlandı.', 8),
(9, 'Evcil Hayvan Sağlığı Semineri', 'Evcil hayvan sağlığı hakkında ücretsiz seminer verildi.', 9);

-- ÖRNEK ÜYE İSTEKLERİ
INSERT INTO uye_istekleri (dernek_id, ad, soyad, email, telefon, mesaj) VALUES
(1, 'Emre', 'Yıldız', 'emre@email.com', '+90 555 1234567', 'Derneğinize üye olmak istiyorum.'),
(2, 'Suna', 'Kaya', 'suna@email.com', '+90 555 2345678', 'Gençlik programlarına katılmak istiyorum.'),
(3, 'Rahim', 'Doğan', 'rahim@email.com', '+90 555 3456789', 'Çevre projelerine destek olmak istiyorum.'),
(4, 'Neşe', 'Arslan', 'nese@email.com', '+90 555 4567890', 'Sanat aktivitelerine katılmak istiyorum.'),
(5, 'Kadir', 'Taş', 'kadir@email.com', '+90 555 5678901', 'Sanat atölyelerine üye olmak istiyorum.'),
(6, 'Lale', 'Çiçek', 'lale@email.com', '+90 555 6789012', 'Edebiyat grup toplantılarına katılmak istiyorum.'),
(7, 'Murat', 'Birkan', 'murat@email.com', '+90 555 7890123', 'Hayvan koruma projelerine yardımcı olmak istiyorum.'),
(8, 'İclal', 'Sonuz', 'iclal@email.com', '+90 555 8901234', 'Doğa koruma aktivitelerine katılmak istiyorum.'),
(9, 'Tarık', 'Aç', 'tarik@email.com', '+90 555 9012345', 'Pet expo etkinliğine katılmak istiyorum.');