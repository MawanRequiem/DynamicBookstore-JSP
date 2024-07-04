<%-- 
    Document   : index.jsp
    Created on : Jun 30, 2024, 10:52:18 PM
    Author     : Arya Prathama
--%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="db.db" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <script src="js/jquery-3.7.1.min.js"></script>
    <script>
    var counter = 1;
    setInterval(() => {
        document.getElementById('radio' + counter).checked = true;
        counter++;
        if(counter > 3){
            counter = 1;
        }
    }, 5000);
    
    $(document).ready(function(){
    var showCartNotification = '<%= session.getAttribute("showCartNotification") %>';
    if (showCartNotification == 'true') {
        $('#cartModal').modal('show');
        <% session.setAttribute("showCartNotification", false); %>
    }
});
    </script>
    
    <style>
      .carousel-slide-new, .carousel-slide-best{
        margin: 50px;
      }
      #modal-img{
            width: 180px;
      }

      .card-best img, .card-new img{
        width: 180px;
        height: 280px;
      }

      /* CAROUSEL CSS */
      .slider {
        width: 100%;
        height: 900px; 
        overflow: hidden;
        position: relative; /* Add this to position manual buttons */
      }

      .slides {
        display: flex;
        width: 300%;
        height: 100%;
      }

      .slides input {
        display: none;
      }

      .slide {
        width: 33.3333%;
        transition: 0.7s;
        height: 100%;
        display: flex;
        justify-content: center;
      }

      .slide img {
        width: 80%; /* reduce image width */
        height: 80%; /* reduce image height */
        object-fit: cover; /* maintain aspect ratio */
        border-radius: 30px;
      }

      .navigation-auto {
        position: absolute;
        width: 100%;
        margin-top: -40px;
        display: flex;
        justify-content: center;
      }

      .auto-btn1:hover, .auto-btn2:hover, .auto-btn3:hover{
        opacity: 1;
      }

      #radio1:checked ~ .first {
        margin-left: 0;
      }

      #radio2:checked ~ .first {
        margin-left: -33.3333%;
      }

      #radio3:checked ~ .first {
        margin-left: -66.6667%;
      }

      .manual-btn {
  border: 2px solid #fff;
  padding: 5px;
  border-radius: 50%;
  cursor: pointer;
  transition: 0.4s;
  display: inline-block;
  background-color: rgba(0, 0, 0, 0.5); /* Make the buttons more noticeable */
  color: #fff; /* Change text color for better visibility */
}

.manual-btn:hover {
  background: #fff;
  color: #000; /* Change color on hover */
}

.manual-btn::before {
  content: attr();
  font-size: 16px;
  font-weight: bold;
  color: #fff;
}

.navigation-manual {
  position: absolute; /* Position the manual buttons */
  bottom: 200px; /* Reduce the white space under the buttons */
  width: 100%;
  display: flex;
  justify-content: center;
  z-index: 1000; /* Ensure they are above other elements */
}
    </style>
    <title>Tere Liye Bookstore</title>
</head>


<body>
    <!--<!-- Session -->
    
  <%
String username = (String) session.getAttribute("uName");
boolean isLoggedIn = (username != null);
%>    
  <header>
 <header>
    <div class="top-bar">
        <img src="image/serial anak/tere liyee.png" height="60" class="logo"> <!-- Pastikan ukuran gambar disesuaikan -->
        <div class="navbar">
            <nav>
                <input type="search" id="search-input" class="form-control" placeholder="Cari Produk atau judul buku">
                <a href="index.jsp" class="navtext">Home</a>
                <a href="allbooklist.jsp" class="navtext">All Book</a>
                <a href="cart.jsp" class="navtext">Cart</a>
                <% if (isLoggedIn) { %>
                    <a href="detail.jsp" class="navtext"> <%= username %></a>
                <% } else { %>
                    <a href="login.jsp" class="navtext">Login</a>
                <% } %>
            </nav>
        </div>
    </div>
</header>

  <br><br><br>
  <!-- Slideshow container -->
  <div class="slider">
    <div class="slides">
      <input type="radio" name="radio-btn" id="radio1" checked>
      <input type="radio" name="radio-btn" id="radio2">
      <input type="radio" name="radio-btn" id="radio3">

      <div class="slide first">
        <img src="image/1.png" alt="Slide 1">
      </div>

      <div class="slide">
        <img src="image/2.png" alt="Slide 2">
      </div>

      <div class="slide">
        <img src="image/3.png" alt="Slide 3">
      </div>

      <div class="navigation-auto">
        <div class="auto-btn1"></div>
        <div class="auto-btn2"></div>
        <div class="auto-btn3"></div>
      </div>
    </div>

    <div class="navigation-manual">
      <label for="radio1" class="manual-btn">•</label>
      <label for="radio2" class="manual-btn">•</label>
      <label for="radio3" class="manual-btn">•</label>
    </div>
  </div>

  <section class="genre-icon">
    <a href="series-page/aksiseries.html">
      <div class="icons">
        <img src="image/Serial Aksi/pulang.jpeg" alt="Book Icon">
        <div>
          <h3>Serial Aksi</h3>
        </div>
      </div>
    </a>

    <a href="series-page/duniaparalelseries.html">
      <div class="icons">
        <img src="image/dunia paralel/bumi.jpg" alt="Book Icon">
        <div>
          <h3>Serial Dunia Paralel</h3>
        </div>
      </div>
    </a>

    <a href="series-page/anakseries.html">
      <div class="icons">
        <img src="image/serial anak/anak spesial.jpeg" alt="Book Icon">
        <div>
          <h3>Serial Anak Nusantara</h3>
        </div>
      </div>
    </a>

    <a href="series-page/gogonseries.html">
      <div class="icons">
        <img src="image/gogons/1.jpg" alt="Book Icon">
        <div>
          <h3>Serial The Gogons</h3>
        </div>
      </div>
    </a>

    <a href="series-page/nonseries.html">
      <div class="icons">
        <img src="image/non seri/teruslahbodoh.jpg" alt="Book Icon">
        <div>
          <h3>Novel non-serial</h3>
        </div>
      </div>
    </a>

    <a href="series-page/cerpen.html">
      <div class="icons">
        <img src="image/cerpen/berjutarasa.jpg" alt="Book Icon">
        <div>
          <h3>Kumpulan Cerpen</h3>
        </div>
      </div>
    </a>
  </section>

  <h1 class="heading"> <span>Best Seller</span> </h1>

  <div class="carousel-main-div1" id="carousel1">
    <div class="carousel-main">
      <div class="carousel-slide-best">
        <a href="pulang.html" class="card-best" onclick="openModal(event, 'Pulang', 'Tere Liye', 'Rp 89.999', 'Genre: Action', 'novel Pulang mengisahkan petualangan hidup remaja berusia 15 tahun yang memiliki kemampuan hebat dalam berburu babi hutan. Hal itu membuat Teuku Muda terkesan. Bapak tua itu kemudian membawanya ke kota untuk diasuh layaknya anak angkat. Tokoh utama dalam sinopsis novel Pulang bernama Bujang','image/serial aksi/pulang.jpeg','book-page/pulang.html')">
          <img src="image/Serial Aksi/pulang.jpeg" alt="Melangkah">
          <h3>Pulang</h3>
          <p>Action</p>
          <span class="price">Rp 89.999</span>
        </a>
        <a href="html.html" class="card-best" onclick="openModal(event, 'Daun yang Jatuh taj jauh dari Angin', 'Tere Liye', 'Rp 80.000', 'Genre: Romance', 'Latar belakang dan alur buku “Daun yang Jatuh Tak Pernah Membenci Angin” Merupakan kisah yang menceritakan seorang anak perempuan yang bernama Tania, dia hanya memiliki ibu dan adik di hidupnya, ayahnya sudah meninggalkan dunia disaat umurnya delapan tahun karena penyakit TBC yang dideritanya.','image/non seri/daun.jpeg','book-page/daun.html')">
          <img src="image/non seri/daun.jpeg" alt="Tanah Para Bandit">
          <h3>Daun Yang Tak Pernah Membenci Angin</h3>
          <p>Action</p>
          <span class="price">Rp 80.000</span>
        </a>
        <a href="html.html" class="card-best" onclick="openModal(event, 'Negeri Para Bedebah', 'Tere Liye', 'Rp 89.999', 'Genre: Action', 'Negeri Para Bedebah menceritakan kisah Thomas, seorang konsultan keuangan ternama yang disegani karena kecerdasan dan strateginya. Hidupnya yang tenang berubah drastis saat Bank Semesta terancam dilikuidasi.','image/serial aksi/negeri para bedebah.jpeg','book-page/negeriparabedebah.html')">
          <img src="image/Serial Aksi/negeri para bedebah.jpeg" alt="Laut Bercerita">
          <h3>Negeri Para Bedebah</h3>
          <p>Action</p>
          <span class="price">Rp 89.999</span>
        </a>
        <a href="html.html" class="card-best">
          <img src="image/dunia paralel/bumi.jpg" alt="Bumi" onclick="openModal(event,'Bumi', 'Tere Liye', 'Rp 90.000', 'Genre: Fantasy', 'Raib adalah seorang gadis berumur 15 tahun. Secara umum, tidak ada yang berbeda dari Raib dengan remaja pada umumnya. Namun, Raib memiliki rahasia yang ia simpan sendiri sejak kecil, yakni kemampuan untuk menghilangkan diri. Hanya dengan mengatupkan kedua tangannya di depan wajahnya, Raib dapat melenyapkan seluruh tubuhnya dengan seketika.','image/dunia paralel/bumi.jpg','book-page/bumi.html')">
          <h3>Bumi</h3>
          <p>Fantasy</p>
          <span class="price">Rp 90.000</span>
        </a>
        <a href="html.html" class="card-best">
          <img src="image/non seri/Hujan.jpeg" alt="hujan" onclick="openModal(event,'Hujan', 'Tere Liye', 'Rp 70.000', 'Genre: Romance', 'Novel ini mengisahkan percintaan dan perjuangan hidup seorang perempuan bernama Lail. Ketika Lail baru berusia 13 tahun, dirinya harus menjadi seorang anak yatim piatu. Di hari pertama ia sekolah, ada sebuah bencana gunung meletus dan gempa dahsyat sehingga menghancurkan kota di mana ia menetap, bahkan merenggut nyawa ibu serta ayah Lail.','image/non seri/hujan.jpeg','book-page/hujan.html')">
          <h3>Hujan</h3>
          <p>Romance</p>
          <span class="price">Rp 70.000</span>
        </a>
        <a href="html.html" class="card-best">
          <img src="image/Serial Aksi/bedebah di ujung tanduk.jpeg" alt="Bedebah di ujung tanduk" onclick="openModal(event, 'Bedebah Di Ujung Tanduk', 'Tere Liye', 'Rp 99.999', 'Genre: Action', 'Di Negeri di Ujung Tanduk, pencuri, perampok, berkeliaran menjadi penegak hukum. Di depan, di belakang, mereka tidak malu-malu lagi. Tapi setidaknya, Kawan, dalam situasi apapun, petarung sejati akan terus memilih kehormatan hidupnya. Bahkan ketika nasib di ujung tanduk.','image/serial aksi/bedebah di ujung tanduk.jpeg','book-page/bedebahdiujung.html')">
          <h3>Bedebah di Ujung Tanduk</h3>
          <p>Action</p>
          <span class="price">Rp 99.999</span>
        </a>
        <a href="html.html" class="card-best">
          <img src="image/Serial Aksi/tanah para bandit.jpeg" alt="Tanah Para Bandit" onclick="openModal(event, 'Tanah Para Bandit', 'Tere Liye', 'Rp 99.999', 'Genre: Action', 'Tanah Para Bandit menceritakan tentang Padma, seorang perempuan muda yang telah berlatih secara fisik, pikiran, mental, dan jiwa sejak kecil. Ia dilatih oleh seorang kakek bernama Abu Syik.','image/serial aksi/tanah para bandit.jpeg', 'book-page/tanahparabandit.html')">
          <h3>Tanah Para Bandit</h3>
          <p>Action</p>
          <span class="price">Rp 99.999</span>
        </a>
        <a href="html.html" class="card-best">
          <img src="image/non seri/sunset bersama rosie.jpeg" alt="sunset" onclick="openModal(event, 'Sunset Bersama Rosie', 'Tere Liye', 'Rp 80.000', 'Genre: Romance', 'Novel Sunset Bersama Rosie karya Tere Liye Novel menceritakan tentang kisah percintaan seorang pria bernama Tegar, yakni tokoh utama di novel ini serta sebagai pelaku sudut pertama. Tokoh Tegar diceritakan bahwa ia memiliki seorang sahabat bernama Rosie, mereka sudah bersahabat sejak kecil dan sering bermain bersama.','image/non seri/sunset bersama rosie.jpeg','book-page/sunset.html')">
          <h3>Sunset Bersama Rosie</h3>
          <p>Romance</p>
          <span class="price">Rp 80.000</span>
        </a>
        <a href="book4.html" class="card-best"  onclick="openModal(event, 'Si anak Savana', 'Tere Liye', 'Rp 80.000', 'Genre: Family', 'Buku Si Anak Savana menghadirkan kisah yang mengagumkan tentang ketekunan dan persahabatan yang tulus di Kampung Dopu, sebuah komunitas yang terletak di dekat savana yang memukau. Dalam cerita ini, para pembaca akan diajak untuk mengenal Wanga, Sedo, Rantu, Bidal, dan Somad, kelompok anak-anak yang menjalin hubungan persahabatan yang erat dan murni.','image/serial anak/anak savana.jpeg', 'book-page/anaksavana.html')">
          <img src="image/serial anak/anak savana.jpeg" alt="Book 4">
          <h2>Si Anak Savana</h2>
          <span class="price">Rp 90.000</span>
        </a>
      </div>
      <div>
        <button class="prev-main" onclick="moveSlideBest(-1)">&#10094;</button>
        <button class="next-main" onclick="moveSlideBest(1)">&#10095;</button>
      </div>
    </div>
  </div>

  <h1 class="heading"> <span>New Release</span> </h1>

  <div class="carousel-main-div1" id="carousel1">
    <div class="carousel-main">
      <div class="carousel-slide-new">
        <a href="book4.html" class="card-new"  onclick="openModal(event, 'Si anak Savana', 'Tere Liye', 'Rp 80.000', 'Genre: Family', 'Buku Si Anak Savana menghadirkan kisah yang mengagumkan tentang ketekunan dan persahabatan yang tulus di Kampung Dopu, sebuah komunitas yang terletak di dekat savana yang memukau. Dalam cerita ini, para pembaca akan diajak untuk mengenal Wanga, Sedo, Rantu, Bidal, dan Somad, kelompok anak-anak yang menjalin hubungan persahabatan yang erat dan murni.','image/serial anak/anak savana.jpeg', 'book-page/anaksavana.html')">
          <img src="image/serial anak/anak savana.jpeg" alt="Book 4">
          <h3>Si Anak Savana</h3>
          <p>Family</p>
          <span class="price">Rp 90.000</span>
        </a>
        <a href="html.html" class="card-new" onclick="openModal(event,'Hujan', 'Tere Liye', 'Rp 70.000', 'Genre: Romance', 'Novel ini mengisahkan percintaan dan perjuangan hidup seorang perempuan bernama Lail. Ketika Lail baru berusia 13 tahun, dirinya harus menjadi seorang anak yatim piatu. Di hari pertama ia sekolah, ada sebuah bencana gunung meletus dan gempa dahsyat sehingga menghancurkan kota di mana ia menetap, bahkan merenggut nyawa ibu serta ayah Lail.','image/non seri/Hujan.jpeg','book-page/hujan.html')">
          <img src="image/non seri/Hujan.jpeg" alt="hujan" >
          <h3>Hujan</h3>
          <p>Romance</p>
          <span class="price">Rp 70.000</span>
        </a>
        <a href="html.html" class="card-new" onclick="openModal(event,'Tentang Kamu', 'Tere Liye', 'Rp 115.000', 'Genre: Romance', 'Tentang Kamu, novel dengan tokoh utama bernama Zaman Zulkarnaen. Ia merupakan lulusan magister hukum di Oxford University. Zaman bekerja di sebuah firma hukum, tepatnya di Belgrave, London. Firma hukum tersebut bernama Thompson & Co., ia berada di bidang Elder Law yang menjadi legendaris sebab prinsip kuat yang dipegang olehnya.','image/non seri/tentangkamu.jpg','book-page/tentangkamu.html')">
          <img src="image/non seri/tentangkamu.jpg" alt="Tentang Kamu" >
          <h3>Tentang Kamu</h3>
          <p>Romance</p>
          <span class="price">Rp 115.000</span>
        </a>
        <a href="html.html" class="card-new" onclick="openModal(event,'Selena', 'Tere Liye', 'Rp 90.000', 'Genre: Romance', 'Buku Selena berlatar di Klan Bulan, menceritakan sosok Selena guru matematika Raib, Seli, dan Ali di Klan Bumi. Kisahnya dimulai saat Selena berusia 15 tahun, menjadi anak yatim piatu karena Ayahnya meninggal, dan kemudian menyusul ibunya, hidup miskin dan tinggal di Distrik Sabit Enam.','image/dunia paralel/selena.jpg','book-page/selena.html')">
          <img src="image/dunia paralel/selena.jpg" alt="selena" >
          <h3>Selena</h3>
          <p>Fantasy</p>
          <span class="price">Rp 90.000</span>
        </a>
        <a href="html.html" class="card-new" onclick="openModal(event, 'Tanah Para Bandit', 'Tere Liye', 'Rp 99.999', 'Genre: Action', 'Tanah Para Bandit menceritakan tentang Padma, seorang perempuan muda yang telah berlatih secara fisik, pikiran, mental, dan jiwa sejak kecil. Ia dilatih oleh seorang kakek bernama Abu Syik.','image/serial aksi/tanah para bandit.jpeg','book-page/tanahparabandit.html')">
          <img src="image/Serial Aksi/tanah para bandit.jpeg" alt="Tanah Para Bandit" >
          <h3>Tanah Para Bandit</h3>
          <p>Action</p>
          <span class="price">Rp 99.999</span>
        </a>
        <a href="html.html" class="card-new" onclick="openModal(event, 'Teruslah Bodoh Jangan Pintar', 'Tere Liye', 'Rp 90.000', 'Genre: Action', 'Tanah Para Bandit menceritakan tentang Padma, seorang perempuan muda yang telah berlatih secara fisik, pikiran, mental, dan jiwa sejak kecil. Ia dilatih oleh seorang kakek bernama Abu Syik.','image/non seri/teruslahbodoh.jpg','book-page/teruslahbodoh.html')">
          <img src="image/non seri/teruslahbodoh.jpg" alt="teruslahbodoh" >
          <h3>Teruslah Bodoh Jangan Pintar</h3>
          <p>Action</p>
          <span class="price">Rp 90.000</span>
        </a>
        <a href="html.html" class="card-new" onclick="openModal(event,'Bumi', 'Tere Liye', 'Rp 90.000', 'Genre: Fantasy', 'Raib adalah seorang gadis berumur 15 tahun. Secara umum, tidak ada yang berbeda dari Raib dengan remaja pada umumnya. Namun, Raib memiliki rahasia yang ia simpan sendiri sejak kecil, yakni kemampuan untuk menghilangkan diri. Hanya dengan mengatupkan kedua tangannya di depan wajahnya, Raib dapat melenyapkan seluruh tubuhnya dengan seketika.','image/dunia paralel/bumi.jpg','book-page/bumi.html')">
          <img src="image/dunia paralel/bumi.jpg" alt="Bumi" >
          <h3>Bumi</h3>
          <p>Fantasy</p>
          <span class="price">Rp 90.000</span>
        </a>
        <a href="html.html" class="card-new" onclick="openModal(event,'Bulan', 'Tere Liye', 'Rp 90.000', 'Genre: Fantasy', 'Petualangan Raib, Seli, dan Ali berlanjut.Beberapa bulan setelah peristiwa klan bulan, Miss Selena akhirnya muncul di sekolah. Ia membawa kabar menggembirakan untuk anak-anak yang berjiwa petualang seperti Raib, Seli, dan Ali. Miss Selena bersama dengan Av akan mengajak mereka untuk mengunjungi klan matahari selama dua minggu. Av berencana akan bertemu dengan ketua konsil klan matahari, yang menguasai klan matahari sepenuhnya untuk mencari sekutu dalam menghadapi Tamus yang diperkirakan akan bebas dan juga membebaskan raja tanpa mahkota.','image/dunia paralel/Bulan.jpg','book-page/bulan.html')">
          <img src="image/dunia paralel/Bulan.jpg" alt="Bulan">
          <h3>Bulan</h3>
          <p>Fantasy</p>
          <span class="price">Rp 90.000</span>
        </a>
        <a href="pulang.html" class="card-new" onclick="openModal(event, 'Pulang', 'Tere Liye', 'Rp 89.999', 'Genre: Action', 'novel Pulang mengisahkan petualangan hidup remaja berusia 15 tahun yang memiliki kemampuan hebat dalam berburu babi hutan. Hal itu membuat Teuku Muda terkesan. Bapak tua itu kemudian membawanya ke kota untuk diasuh layaknya anak angkat. Tokoh utama dalam sinopsis novel Pulang bernama Bujang','image/serial aksi/pulang.jpeg','book-page/pulang.html')">
          <img src="image/Serial Aksi/pulang.jpeg" alt="Melangkah">
          <h3>Pulang</h3>
          <p>Action</p>
          <span class="price">Rp 89.999</span>
        </a>
      </div>
      <div>
        <button class="prev-main" onclick="moveSlideNew(-1)">&#10094;</button>
        <button class="next-main" onclick="moveSlideNew(1)">&#10095;</button>
      </div>
    </div>
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
      <button id="modal-link">Add To Cart</button>
    </div>
  </div>

<!-- Add to cart buttons -->
    <form action="AddToCartServlet" method="post">
        <input type="hidden" name="bookTitle" value="Pulang">
        <button type="submit">Add to Cart</button>
    </form>

    <form action="AddToCartServlet" method="post">
        <input type="hidden" name="bookTitle" value="Daun yang Jatuh Tak Pernah Membenci Angin">
        <button type="submit">Add to Cart</button>
    </form>

     <!-- Modal HTML -->
    <div class="modal fade" id="cartModal" tabindex="-1" role="dialog" aria-labelledby="cartModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="cartModalLabel">Cart Notification</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Your book has been added to the cart successfully!
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
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
  
    <script type="text/javascript" src="javascript/script.js"></script>
    
</body>
</html>
