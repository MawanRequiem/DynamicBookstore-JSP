<%-- 
    Document   : allbook
    Created on : Jul 1, 2024, 9:30:15 AM
    Author     : Arya Prathama
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <script src="jQuery 3.7.1.js"></script>
    <script src="script.js"></script>
    <style>
        .book-item img{
            width: 180px;
        }
        #modal-img{
            width: 180px;
        }
    </style>
    <title>Tere Liye Bookstore</title>
</head>
<body>
    <header>
        <div class="top-bar">
            <img src="image/serial anak/tere liyee.png" height="60000" class="logo">
            <div class="navbar">
              <nav>
                  <input type="search" id="search-input" class="form-control" placeholder="Cari Produk atau judul buku">
                  <a href="index.jsp" class="navtext">Home</a>
                  <a href="allbooklist.jspl" class="navtext">All Book</a>
                  <a href="allbooklist.html" class="navtext">Cart</a>
                  <a href="login.jsp" class="navtext">Login</a>
              </nav>
          </div>
        </div>
      </header>

    <section class="best-seller" id="best-seller">
        <h1 class="heading">
            <span>Action</span>
        </h1>
        <div class="carousel-container" id="carousel-action">
            <button class="carousel-button prev" onclick="plusSlidesAllBook('carousel-action', -1)">‹</button>
            <div class="carousel-slide">
                <div class="book-list">
                    <a href="book1.html" class="book-item" onclick="openModal(event, 'Pulang', 'Tere Liye', 'Rp 89.999', 'Genre: Action', 'novel Pulang mengisahkan petualangan hidup remaja berusia 15 tahun yang memiliki kemampuan hebat dalam berburu babi hutan. Hal itu membuat Teuku Muda terkesan. Bapak tua itu kemudian membawanya ke kota untuk diasuh layaknya anak angkat. Tokoh utama dalam sinopsis novel Pulang bernama Bujang','image/serial aksi/pulang.jpeg','book-page/pulang.html')">
                        <img src="image/serial aksi/pulang.jpeg" alt="Book 1">
                        <h2>Pulang</h2>
                        <p>Tere Liye</p>
                        <p>Rp 89.999</p>
                        <p class="genre">Genre: Action</p>
                    </a>
                    <a href="book2.html" class="book-item" onclick="openModal(event, 'Pergi', 'Tere Liye', 'Rp 89.999', 'Genre: Action', 'Pergi mengisahkan tentang petualangan Bujang dalam menemukan makna dari tujuan hidupnya, dan menemukan arti dari kata Pergi yang sesungguhnya. Bujang yang sering dijuluki sebagai “Sang Babi Hutan” memiliki nama asli Agam.','image/serial aksi/pergi.jpeg','book-page/pergi.html')">
                        <img src="image/serial aksi/pergi.jpeg" alt="Book 2">
                        <h2>Pergi</h2>
                        <p>Tere Liye</p>
                        <p>Rp 89.999</p>
                        <p class="genre">Genre: Action</p>
                    </a>
                    <a href="book3.html" class="book-item" onclick="openModal(event, 'Negeri Para Bedebah', 'Tere Liye', 'Rp 89.999', 'Genre: Action', 'Negeri Para Bedebah menceritakan kisah Thomas, seorang konsultan keuangan ternama yang disegani karena kecerdasan dan strateginya. Hidupnya yang tenang berubah drastis saat Bank Semesta terancam dilikuidasi.','image/serial aksi/negeri para bedebah.jpeg','book-page/negeriparabedebah.html')">
                        <img src="image/serial aksi/negeri para bedebah.jpeg" alt="Book 3">
                        <h2>Negeri Para Bedebah</h2>
                        <p>Tere Liye</p>
                        <p>Rp 89.999</p>
                        <p class="genre">Genre: Action</p>
                        
                    </a>
                    <a href="book2.html" class="book-item" onclick="openModal(event, 'Negeri di Ujung Tanduk', 'Tere Liye', 'Rp 89.999', 'Genre: Action', 'Novel Negeri Di Ujung Tanduk karya Tere Liye ini novel yang bercerita tentang perjuangan memenangkan partai politik demi terciptanya pemimpin yang jujur. Cerita dalam novel ini sangat menarik dan sederhana serta menggunakan bahasa yang mudah untuk dipahami.','image/serial aksi/negeri di ujung tanduk.jpeg','book-page/negeridiujung.html')">
                        <img src="image/serial aksi/negeri di ujung tanduk.jpeg" alt="Book 2">
                        <h2>Negeri di Ujung Tanduk</h2>
                        <p>Tere Liye</p>
                        <p>Rp 89.999</p>
                        <p class="genre">Genre: Action</p>
                    </a>
                    <a href="book3.html" class="book-item"  onclick="openModal(event, 'Pulang Pergi', 'Tere Liye', 'Rp 99.999', 'Genre: Action', 'Novel Pulang Pergi menceritakan tentang Bujang yang tak tahu harus kemana setelah pulang dan pergi. Bujang yang sedang berkunjung ke makam orang tuanya mendapatkan sebuah pesan misterius. Bertuliskan pesan dari Krestniy Otets, pemimpin brotherhood Bratva.','image/serial aksi/pulang pergi.jpeg','book-page/pulangpergi.html')">
                        <img src="image/serial aksi/pulang pergi.jpeg" alt="Book 3">
                        <h2>Pulang Pergi</h2>
                        <p>Tere Liye</p>
                        <p>Rp 99.999</p>
                        <p class="genre">Genre: Action</p>
                        
                    </a>
                    <a href="book2.html" class="book-item"  onclick="openModal(event, 'Bedebah Di Ujung Tanduk', 'Tere Liye', 'Rp 99.999', 'Genre: Action', 'Di Negeri di Ujung Tanduk, pencuri, perampok, berkeliaran menjadi penegak hukum. Di depan, di belakang, mereka tidak malu-malu lagi. Tapi setidaknya, Kawan, dalam situasi apapun, petarung sejati akan terus memilih kehormatan hidupnya. Bahkan ketika nasib di ujung tanduk.','image/serial aksi/bedebah di ujung tanduk.jpeg','book-page/bedebahdiujung.html')">
                        <img src="image/serial aksi/bedebah di ujung tanduk.jpeg" alt="Book 2">
                        <h2>Bedebah di Ujung Tanduk</h2>
                        <p>Tere Liye</p>
                        <p>Rp 99.999</p>
                        <p class="genre">Genre: Action</p>
                    </a>
                    <a href="book3.html" class="book-item" onclick="openModal(event, 'Tanah Para Bandit', 'Tere Liye', 'Rp 99.999', 'Genre: Action', 'Tanah Para Bandit menceritakan tentang Padma, seorang perempuan muda yang telah berlatih secara fisik, pikiran, mental, dan jiwa sejak kecil. Ia dilatih oleh seorang kakek bernama Abu Syik.','image/serial aksi/tanah para bandit.jpeg','book-page/tanahparabandit.html')">
                        <img src="image/serial aksi/tanah para bandit.jpeg" alt="Book 3">
                        <h2>Tanah Para Bandit</h2>
                        <p>Tere Liye</p>
                        <p>Rp 99.999</p>
                        <p class="genre">Genre: Action</p>
                    </a>
                </div>
            </div>
            <button class="carousel-button next" onclick="plusSlidesAllBook('carousel-action', 1)">›</button>
        </div>

        <h1 class="heading">
            <span>Romance</span>
        </h1>
        <div class="carousel-container" id="carousel-romance">
            <button class="carousel-button prev" onclick="plusSlidesAllBook('carousel-romance', -1)">‹</button>
            <div class="carousel-slide">
                <div class="book-list">
                    <a href="book4.html" class="book-item"  onclick="openModal(event, 'Sunset Bersama Rosie', 'Tere Liye', 'Rp 80.000', 'Genre: Romance', 'Novel Sunset Bersama Rosie karya Tere Liye Novel menceritakan tentang kisah percintaan seorang pria bernama Tegar, yakni tokoh utama di novel ini serta sebagai pelaku sudut pertama. Tokoh Tegar diceritakan bahwa ia memiliki seorang sahabat bernama Rosie, mereka sudah bersahabat sejak kecil dan sering bermain bersama.','image/non seri/sunset bersama rosie.jpeg','book-page/sunset.html')">
                        <img src="image/non seri/sunset bersama rosie.jpeg" alt="Book 4">
                        <h2>Sunset Bersama Rosie</h2>
                        <p>Tere Liye</p>
                        <p>Rp 80.000</p>
                        <p class="genre">Genre: Romance</p>
                    </a>
                    
                    <a href="book4.html" class="book-item"  onclick="openModal(event, 'Daun yang Jatuh taj jauh dari Angin', 'Tere Liye', 'Rp 80.000', 'Genre: Romance', 'Latar belakang dan alur buku “Daun yang Jatuh Tak Pernah Membenci Angin” Merupakan kisah yang menceritakan seorang anak perempuan yang bernama Tania, dia hanya memiliki ibu dan adik di hidupnya, ayahnya sudah meninggalkan dunia disaat umurnya delapan tahun karena penyakit TBC yang dideritanya.','image/non seri/daun.jpeg','book-page/daun.html')">
                        <img src="image/non seri/daun.jpeg" alt="Book 4">
                        <h2>Daun yang Jatuh tak Jauh Dari Angin</h2>
                        <p>Tere Liye</p>
                        <p>Rp 80.000</p>
                        <p class="genre">Genre: Romance</p>
                    </a>
                    <a href="book4.html" class="book-item"  onclick="openModal(event, ' Aku dan Sepucuk Angpau Merah', 'Tere Liye', 'Rp 85.000', 'Genre: Romance', 'Novel Kau, Aku dan Sepucuk Angpau Merah karya Darwis Tere Liye ini menceritakan tentang sebuah kisah cinta yang sangat sulit antara pemuda asal Kalimantan bernama Borno dan pemuda Tionghoa bernama Mei. Gagal menjadi pekerja pabrik karet, sarang burung walet, petugas karcis, akhirnya menjadi pengemudi Speedboat','image/non seri/angpau merah.jpeg','book-page/angpau.html')">
                        <img src="image/non seri/angpau merah.jpeg" alt="Book 4">
                        <h2> Aku dan Sepucuk Angpau Merah</h2>
                        <p>Tere Liye</p>
                        <p>Rp 85.000</p>
                        <p class="genre">Genre: Romance</p>
                    </a>
                    <a href="book4.html" class="book-item"  onclick="openModal(event, 'Hujan', 'Tere Liye', 'Rp 75.000', 'Genre: Romanca', 'Hujan merupakan karya ke-25 penulis Tere Liye. Dalam 24 karya sebelumnya terdapat novel, kumpulan cerpen, dan kumpulan sajak. Novel best-seller ini menceritakan tentang kehidupan setelah bencana alam di yaitu letusan gunung dan gempa bumi yang sangat dahsyat di tahun 2042, Tania.','image/non seri/Hujan.jpeg','book-page/hujan.html')">
                        <img src="image/non seri/Hujan.jpeg" alt="Book 4">
                        <h2>Hujan</h2>
                        <p>Tere Liye</p>
                        <p>Rp 75.000</p>
                        <p class="genre">Genre: Romance</p>
                    </a>
                    <a href="book4.html" class="book-item"  onclick="openModal(event, 'Sepotong Hati yang Baru', 'Tere Liye', 'Rp 75.000', 'Genre: Romanca', 'Kita hanya memiliki sepotong hati, bukan? Satu-satunya. Lalu, bagaimana jika hati itu terluka? Bagaimana hati kita justru disakiti oleh orang yang kita cintai? Aduh, apakah kita bisa mengobatinya? Apakah luka tersebut bisa sembuh, tanpa meninggalkan bekas? Atau jangan-jangan, kita harus menggantinya dengan sepotong hati yang baru.','image/non seri/Sepotong hati.jpeg','book-page/sepotonghati.html')">
                        <img src="image/non seri/Sepotong hati.jpeg" alt="Book 4">
                        <h2>Sepotong Hati yang Baru</h2>
                        <p>Tere Liye</p>
                        <p>Rp 75.000</p>
                        <p class="genre">Genre: Romance</p>
                    </a>
                    <a href="book4.html" class="book-item"  onclick="openModal(event, 'Cintaku Antara Jakarta dan Kuala Lumpur', 'Tere Liye', 'Rp 75.000', 'Genre: Romanca', 'Berkisah tentang James, dan Tania yang sudah bersahabat sejak mereka masih kecil. Suatu hari, Tania memaksa James untuk menghadiri konser penyanyi terkenal dari negeri jiran, bernama Siti. Tidak disangka, pertemuan pertama itu merupakan awal dari rangkain kisah cinta James terhadap Siti. Namun, pria cerdas nan lugu ini tidak pernah menyadari pertanda-pertanda dari sahabat masa kecilnya, Tania.','image/non seri/jakarta kuala lumpur.jpeg','book-page/jakartakuala.html')">
                        <img src="image/non seri/jakarta kuala lumpur.jpeg" alt="Book 4">
                        <h2>Cintaku Antara Jakarta dan Kuala Lumpur</h2>
                        <p>Tere Liye</p>
                        <p>Rp 75.000</p>
                        <p class="genre">Genre: Romance</p>
                    </a>
                    <!-- Add more book items as needed -->
                </div>
            </div>
            <button class="carousel-button next" onclick="plusSlidesAllBook('carousel-romance', 1)">›</button>
        </div>

        <h1 class="heading">
            <span>Family</span>
        </h1>
        <div class="carousel-container" id="carousel-family">
            <button class="carousel-button prev" onclick="plusSlidesAllBook('carousel-family', -1)">‹</button>
            <div class="carousel-slide">
                <div class="book-list">
                    <a href="book4.html" class="book-item"  onclick="openModal(event, 'Si anak Spesial', 'Tere Liye', 'Rp 80.000', 'Genre: Family', 'Buku ini menceritakan tentang kisah perjalanan hidup seorang anak spesial dan nakal bernama Burlian yang merupakan anak ketiga dari empat bersaudara. Julukan “si Anak Spesial” diberikan kepada Burlian oleh Mamak dan Bapak agar menumbuhkan rasa percaya diri dan keyakinan pada diri Burlian.','image/serial anak/anak spesial.jpeg','book-page/anakspesial.html')">
                        <img src="image/serial anak/anak spesial.jpeg" alt="Book 4">
                        <h2>Si Anak Spesial</h2>
                        <p>Tere Liye</p>
                        <p>Rp 80.000</p>
                        <p class="genre">Genre: Family</p>
                    </a>
                    <a href="book4.html" class="book-item"  onclick="openModal(event, 'Si anak Pintar', 'Tere Liye', 'Rp 80.000', 'Genre: Family', 'Buku ini tentang Pukat, si anak paling pintar dalam keluarga. Masa kecilnya dipenuhi petualangan seru dan kejadian kocak—serta jangan lupakan pertengkaran dengan kakak dan adik-adiknya. Tapi apakah dia mampu menjawab teka-teki hebat itu, apakah harta karun paling berharga di kampung mereka?','image/serial anak/anak pintar.jpeg','book-page/anakpintar.html')">
                        <img src="image/serial anak/Anak pintar.jpeg" alt="Book 4">
                        <h2>Si Anak Pintar</h2>
                        <p>Tere Liye</p>
                        <p>Rp 80.000</p>
                        <p class="genre">Genre: Family</p>
                    </a>
                    <a href="book4.html" class="book-item"  onclick="openModal(event, 'Si anak Pemberani', 'Tere Liye', 'Rp 80.000', 'Genre: Family', 'Buku ini tentang Eliana, anak pemberani yang membela tanah, sungai, hutan, dan lemah kampungnya. Saat kerakusan dunia datang, Eliana bersama teman karibnya bahu-membahu melakukan perlawanan','image/serial anak/anak pemberani.jpeg')">
                        <img src="image/serial anak/anak Pemberani.jpeg" alt="Book 4">
                        <h2>Si Anak Pemberani</h2>
                        <p>Tere Liye</p>
                        <p>Rp 80.000</p>
                        <p class="genre">Genre: Family</p>
                    </a>
                    <a href="book4.html" class="book-item"  onclick="openModal(event, 'Si anak Kuat', 'Tere Liye', 'Rp 80.000', 'Genre: Family', 'Si Anak Kuat menceritakan tentang kehidupan keluarga Syahdan dari sisi pandang si anak bungsu. Diawali dengan perkenalan tokoh utama yang bernama Amelia, atau biasa semua orang memanggilnya Amel. Amel dan keluarganya tinggal di perkampungan yang indah, persis di Lembah Bukit Barisan.','image/serial anak/anak kuat.jpeg','book-page/anakkuat.html')">
                        <img src="image/serial anak/anak kuat.jpeg" alt="Book 4">
                        <h2>Si Anak Kuat</h2>
                        <p>Tere Liye</p>
                        <p>Rp 80.000</p>
                        <p class="genre">Genre: Family</p>
                    </a>
                    <a href="book4.html" class="book-item"  onclick="openModal(event, 'Si anak Badai', 'Tere Liye', 'Rp 80.000', 'Genre: Family', 'Novel ini menceritakan tentang Si Anak Badai yang tumbuh ditemani suara aliran sungai, riak permukaan muara, dan deru ombak lautan. Si Anak Badai yang penuh tekad dan keberanian mempertahankan apa yang menjadi milik mereka, hari-hari penuh keceriaan dan petualangan seru.','image/serial anak/anak Badai.jpeg','book-page/anakbadai.html')">
                        <img src="image/serial anak/anak badai.jpeg" alt="Book 4">
                        <h2>Si Anak Badai</h2>
                        <p>Tere Liye</p>
                        <p>Rp 80.000</p>
                        <p class="genre">Genre: Family</p>
                    </a>
                    <a href="book4.html" class="book-item"  onclick="openModal(event, 'Si anak Pelangi', 'Tere Liye', 'Rp 80.000', 'Genre: Family', 'Buku ini tentang Rasuna, yang tinggal di lingkungan sangat beragam, dengan segala permasalahannya. Masa anak-anak yang seru dan lucu, mulai dari sekolah, lapangan bermain, belajar bela diri, hingga kehidupan pasar dan gang-gang sempit. Saat Rasuna paham, dunia memang bagai pelangi.','image/serial anak/anak pelangi.jpeg','book-page/anakpelangi.html')">
                        <img src="image/serial anak/anak Pelangi.jpeg" alt="Book 4">
                        <h2>Si Anak Pelangi</h2>
                        <p>Tere Liye</p>
                        <p>Rp 80.000</p>
                        <p class="genre">Genre: Family</p>
                    </a>
                    <a href="book4.html" class="book-item"  onclick="openModal(event, 'Si anak Savana', 'Tere Liye', 'Rp 80.000', 'Genre: Family', 'Novel ini mengisahkan perjuangan seorang anak perempuan kecil bernama Delisa yang harus menghadapi tragedi besar dan menemukan kekuatan dalam iman dan keyakinannya.','image/anak savana.jpeg','book-page/anaksavana.html')">
                        <img src="image/serial anak/anak savana.jpeg" alt="Book 4">
                        <h2>Si Anak Spesial</h2>
                        <p>Tere Liye</p>
                        <p>Rp 80.000</p>
                        <p class="genre">Genre: Family</p>
                    </a>
                    <a href="book4.html" class="book-item"  onclick="openModal(event, 'Si anak Cahaya', 'Tere Liye', 'Rp 80.000', 'Genre: Family', 'Sinopsis. Kisah ini tentang gadis kecil yang bernama Nurmas yang hidup di kampung pedalaman. Hidup di masa awal kemerdekaan dimana semua serba terbatas, bahkan sekolahpun tidak menggunakan seragam dan tidak beralas kaki. Meskipun kehidupan di kampung sana tidaklah mudah, Nur tetap menjalani hidupnya dengan ceria.','image/serial anak/anak cahaya.jpeg','book-page/anakcahaya.html')">
                        <img src="image/serial anak/anak cahaya.jpeg" alt="Book 4">
                        <h2>Si Anak Cahaya</h2>
                        <p>Tere Liye</p>
                        <p>Rp 80.000</p>
                        <p class="genre">Genre: Family</p>
                    </a>
                </div>
            </div>
            <button class="carousel-button next" onclick="plusSlidesAllBook('carousel-family', 1)">›</button>
        </div>

        <h1 class="heading">
            <span>Fantasy</span>
        </h1>
        <div class="carousel-container" id="carousel-fantasy">
            <button class="carousel-button prev" onclick="plusSlidesAllBook('carousel-fantasy', -1)">‹</button>
            <div class="carousel-slide">
                <div class="book-list">
                    <a href="html.html" class="book-item" onclick="openModal(event,'Bumi', 'Tere Liye', 'Rp 90.000', 'Genre: Fantasy', 'Raib adalah seorang gadis berumur 15 tahun. Secara umum, tidak ada yang berbeda dari Raib dengan remaja pada umumnya. Namun, Raib memiliki rahasia yang ia simpan sendiri sejak kecil, yakni kemampuan untuk menghilangkan diri. Hanya dengan mengatupkan kedua tangannya di depan wajahnya, Raib dapat melenyapkan seluruh tubuhnya dengan seketika.','image/dunia paralel/bumi.jpg','book-page/bumi.html')">
                        <img src="image/dunia paralel/bumi.jpg" alt="Bumi" >
                        <h3>Bumi</h3>
                        <p>Tere Liye</p>
                        <span class="price">Rp 90.000</span>
                        <p class="genre">Genre: Fantasy</p>
                    </a>
                    <a href="html.html" class="book-item" onclick="openModal(event,'Bulan', 'Tere Liye', 'Rp 90.000', 'Genre: Fantasy', 'Petualangan Raib, Seli, dan Ali berlanjut.Beberapa bulan setelah peristiwa klan bulan, Miss Selena akhirnya muncul di sekolah. Ia membawa kabar menggembirakan untuk anak-anak yang berjiwa petualang seperti Raib, Seli, dan Ali. Miss Selena bersama dengan Av akan mengajak mereka untuk mengunjungi klan matahari selama dua minggu. Av berencana akan bertemu dengan ketua konsil klan matahari, yang menguasai klan matahari sepenuhnya untuk mencari sekutu dalam menghadapi Tamus yang diperkirakan akan bebas dan juga membebaskan raja tanpa mahkota.','image/dunia paralel/Bulan.jpg','book-page/bulan.html')">
                        <img src="image/dunia paralel/Bulan.jpg" alt="Bulan">
                        <h3>Bulan</h3>
                        <p>Tere Liye</p>
                        <span class="price">Rp 90.000</span>
                        <p class="genre">Genre: Fantasy</p>
                      </a>
                    <a href="book4.html" class="book-item"  onclick="openModal(event, 'Matahari', 'Tere Liye', 'Rp 80.000', 'Genre: Fantasy', 'Raib, Ali, dan Seli dirundung duka atas tewasnya Ily, sahabat mereka, pada pertarungan di Klan Matahari. Tak hanya mereka, para kesatria Klan Bulan juga merasakan hal sama, sampai membuat Miss Selena tak bisa kembali ke Klan Bumi.','image/dunia paralel/matahari.jpg','book-page/matahari.html')">
                        <img src="image/dunia paralel/matahari.jpg" alt="Book 4">
                        <h2>Matahari</h2>
                        <p>Tere Liye</p>
                        <p>Rp 80.000</p>
                        <p class="genre">Genre: Fantasy</p>
                    </a>
                    <a href="book4.html" class="book-item"  onclick="openModal(event, 'Bintang', 'Tere Liye', 'Rp 80.000', 'Genre: Fantasy', 'Raib, Seli dan Ali meneruskan petualangan mereka. Mereka harus menemukan pasak bumi yang akan di runtuh kan oleh sekretaris Dewan kota. Oleh karna itu, Raib, Seli dan Ali melibatkan orang-orang yang berasal dari klan Bulan dan Matahari. Petualangan kali ini dibantu oleh Miss Selena sebagai pemimpin rombongan, juga 10 anggota pasukan bayangan dan pasukan matahari.','image/dunia paralel/bintang.jpg','book-page/bintang.html')">
                        <img src="image/dunia paralel/bintang.jpg" alt="Book 4">
                        <h2>Bintang</h2>
                        <p>Tere Liye</p>
                        <p>Rp 80.000</p>
                        <p class="genre">Genre: Fantasy</p>
                    </a>
                    <a href="book4.html" class="book-item"  onclick="openModal(event, 'Ceros dan Batozar', 'Tere Liye', 'Rp 80.000', 'Genre: Fantasy', 'Ketika mengikuti karyawisata di suatu tempat wisata, alat pelacak milik Ali mendeteksi adanya energi dunia paralel yang sangat kuat di sekitar situ. Penasaran, Ali bersikeras ingin menyelidikinya. Raib dan Seli yang awalnya menolak akhirnya mau tak mau mengikuti. Menaiki ILY, mereka bertiga kabur dari rombongan dan memulai perjalanan mencari sumber energi dunia paralel tersebut, yang diduga berasal dari bawah tanah. Kemudian sampailah mereka di sebuah gerbang batu di dasar laut. Mereka menelusurinya hingga memasuki sebuah ruangan kuno.','image/dunia paralel/cerosdanbatozar.jpg','book-page/cerosdanbatozar.html')">
                        <img src="image/dunia paralel/cerosdanbatozar.jpg" alt="Book 4">
                        <h2>Ceros dan Batozar</h2>
                        <p>Tere Liye</p>
                        <p>Rp 80.000</p>
                        <p class="genre">Genre: Fantasy</p>
                    </a>
                    <a href="book4.html" class="book-item"  onclick="openModal(event, 'Komet', 'Tere Liye', 'Rp 80.000', 'Genre: Fantasy', 'Saat mengetahui si Tanpa Mahkota sedang mencari Klan Komet untuk menggenapkan kekuatannya, Ali sibuk mencari tahu tentang Klan Komet melalui buku-buku yang ditinggalkan Zaad di Ruangan Padang Sampah Klan Bintang. Portal menuju Klan Komet ternyata ada di Klan Matahari. Ali mengabari Av dan Miss Selena tentang si Tanpa Mahkota yang mencari Komet dan portal menuju Klan Komet di Klan Matahari.','image/dunia paralel/komet.jpg','book-page/komet.html')">
                        <img src="image/dunia paralel/komet.jpg" alt="Book 4">
                        <h2>Komet</h2>
                        <p>Tere Liye</p>
                        <p>Rp 80.000</p>
                        <p class="genre">Genre: Fantasy</p>
                    </a>
                    <a href="book4.html" class="book-item"  onclick="openModal(event, 'Komet Minor', 'Tere Liye', 'Rp 80.000', 'Genre: Fantasy', 'Sebelum kita mulai, mari kita mebaca basmalah. Bismillah. Selanjutnya buku ini melanjutan kisah dari buku sebelumnya yaitu Komet, dimana berakhir saat itu berupa pengkhiatan oleh Max alias Si Tanpa Mahkota yang mengkhianati kebaikan tiga remaja petarung yang berasal dari klan berbeda: Raib (Klan Bulan), Seli (Klan Matahari, dan Ali (Klan Bumi).','image/dunia paralel/kometminor.jpg','book-page/kometminor.html')">
                        <img src="image/dunia paralel/kometminor.jpg" alt="Book 4">
                        <h2>Komet Minor</h2>
                        <p>Tere Liye</p>
                        <p>Rp 80.000</p>
                        <p class="genre">Genre: Fantasy</p>
                    </a>
                    <a href="book4.html" class="book-item"  onclick="openModal(event, 'Selena', 'Tere Liye', 'Rp 80.000', 'Genre: Fantasy', 'Buku Selena berlatar di Klan Bulan, menceritakan sosok Selena guru matematika Raib, Seli, dan Ali di Klan Bumi. Kisahnya dimulai saat Selena berusia 15 tahun, menjadi anak yatim piatu karena Ayahnya meninggal, dan kemudian menyusul ibunya, hidup miskin dan tinggal di Distrik Sabit Enam.','image/dunia paralel/selena.jpg','book-page/selena.html')">
                        <img src="image/dunia paralel/selena.jpg" alt="Book 4">
                        <h2>Selena</h2>
                        <p>Tere Liye</p>
                        <p>Rp 80.000</p>
                        <p class="genre">Genre: Fantasy</p>
                    </a>
                </div>
            </div>
            <button class="carousel-button next" onclick="plusSlidesAllBook('carousel-fantasy', 1)">›</button>
        </div>
        <div id="modal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeModal()">&times;</span>
                <img id="modal-img" src="" alt="Book Image">
                <h2 id="modal-title">Book Title</h2>
                <p id="modal-author">Author</p>
                <p id="modal-price">Price</p>
                <p id="modal-genre">Genre</p>
                <p id="modal-synopsis">Synopsis</p>
                <button id="modal-link">Buy</button>
            </div>
        </div>
    </section>

  <!-- Modal for login -->
  <div id="loginModal" class="modal">
    <div class="modal-content">
      <span class="close" onclick="closeModalMain('loginModal')">&times;</span>
      <h2>Login</h2>
      <form>
        <label for="username">Username:</label>
        <input type="text" id="username" name="username"><br><br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password"><br><br>
        <button type="submit">Login</button>
      </form>
      <p>Don't have an account? <a href="#" onclick="openModalMain('registerModal'); closeModalMain('loginModal');">Register</a></p>
    </div>
  </div>

  <!-- Modal for register -->
  <div id="registerModal" class="modal">
    <div class="modal-content">
      <span class="close" onclick="closeModalMain('registerModal')">&times;</span>
      <h2>Register</h2>
      <form>
        <label for="newUsername">Username:</label>
        <input type="text" id="newUsername" name="newUsername"><br><br>
        <label for="newPassword">Password:</label>
        <input type="password" id="newPassword" name="newPassword"><br><br>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email"><br><br>
        <label for="confirmPassword">Confirm Password:</label>
        <input type="password" id="confirmPassword" name="confirmPassword"><br><br>
        <button type="submit">Register</button>
      </form>
    </div>
  </div>

  <footer>
    <div class="footer-container">
      <div class="footer-section">
        <h4>Payment Methods</h4>
        <div class="payment-method">
          <img class="logo" src="image/footer/bca logo.png" alt="BCA Logo">
          <img class="logo" src="image/footer/mandiri logo.png" alt="Mandiri Logo">
          <img class="logo" src="image/footer/bni logo.png" alt="BNI Logo">
        </div>
      </div>
      <div class="footer-section">
        <h4>Shipping Methods</h4>
        <div class="shipping-method">
          <img class="logo" src="image/footer/idexpress logo.png" alt="JNE Logo">
          <br>
          <img class="logo" src="image/footer/anteraja logo.png" alt="jnt Logo">
        </div>
      </div>
      <div class="footer-section">
        <h4>Social Media</h4>
        <div class="social-media">
          <a href="https://www.instagram.com" target="_blank">
            <img src="image/footer/instagram logo.png" alt="Instagram">
          </a>
          <a href="https://www.facebook.com" target="_blank">
            <img src="image/footer/facebook logo.png" alt="Facebook">
          </a>
          <a href="https://www.twitter.com" target="_blank">
            <img src="image/footer/x logo.png" alt="Twitter">
          </a>
        </div>
      </div>
    </div>
  </footer>
    <script src="javascript/script.js"></script>
</body>
</html>

