/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


/* global title */

let currentIndex = 0;
let slideIndex = 0;
let autoPlayInterval;

// Show the slides
showSlides(slideIndex);

// Next/previous controls
function plusSlides(n) {
  clearInterval(autoPlayInterval); // Stop automatic playback
  slideIndex += n;
  if (slideIndex < 0) slideIndex = document.getElementsByClassName("mySlides").length - 1;
  if (slideIndex >= document.getElementsByClassName("mySlides").length) slideIndex = 0;
  showSlides(slideIndex);
  startAutoPlay(); // Restart autoplay
}

// Thumbnail image controls
function currentSlide(n) {
  clearInterval(autoPlayInterval); // Stop automatic playback
  slideIndex = n - 1;
  showSlides(slideIndex);
  startAutoPlay(); // Restart autoplay
}

function showSlides(n) {
  let i;
  let slides = document.getElementsByClassName("mySlides");
  let dots = document.getElementsByClassName("dot");
  for (i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";
  }
  slides[n].style.display = "block";
  for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" active", "");
  }
  dots[n].className += " active";
}

function startAutoPlay() {
  autoPlayInterval = setInterval(function() {
    plusSlides(1);
  }, 3000); // Change image every 3 seconds
}

// Modal functions
function openModalMain(modalId) {
  document.getElementById(modalId).style.display = "block";
}

function closeModalMain(modalId) {
  document.getElementById(modalId).style.display = "none";
}

$(document).ready(function() {
    // Sticky navbar with animation
    let lastScrollTop = 0;
    $(window).scroll(function() {
        let st = $(this).scrollTop();
        if (st > lastScrollTop) {
            $('header').removeClass('visible').addClass('hidden');
        } else {
            $('header').removeClass('hidden').addClass('visible');
        }
        lastScrollTop = st;
    });

    // Dropdown menu animation
    $('.dropdown').hover(
        function() {
            $(this).find('.dropdown-content').stop(true, true).slideDown(200);
        },
        function() {
            $(this).find('.dropdown-content').stop(true, true).slideUp(200);
        }
    );
});

function plusSlidesAllBook(carouselId, n) {
  const carouselContainer = document.getElementById(carouselId);
  const bookList = carouselContainer.querySelector('.book-list');
  const slides = bookList.getElementsByClassName('book-item');
  const totalSlides = slides.length;
  let slideIndex = parseInt(carouselContainer.dataset.slideIndex) || 0;

  const bookItemWidth = slides[0].offsetWidth + 20; // Including margin
  const visibleItems = Math.floor(carouselContainer.offsetWidth / bookItemWidth);

  slideIndex += n;

  if (slideIndex >= totalSlides - visibleItems + 1) { slideIndex = totalSlides - visibleItems; } 
  else if (slideIndex < 0) { slideIndex = 0; }

  carouselContainer.dataset.slideIndex = slideIndex;
  const offset = slideIndex * bookItemWidth;

  bookList.style.transform = `translateX(-${offset}px)`;
}

// Initialize slide indices for each carousel
document.querySelectorAll('.carousel-container').forEach((carousel) => {
  carousel.dataset.slideIndex = 0;
});
window.onclick = function(event) {
  const modal = document.getElementById('modal');
  if (event.target === modal) {
      modal.style.display = "none";
  }
}

//Slider main style
function moveSlideBest(direction) {
  const carousel = document.querySelector('.carousel-slide-best');
  const totalCards = document.querySelectorAll('.card-best').length;
  const cardWidth = document.querySelector('.card-best').offsetWidth;
  const visibleCards = Math.floor(carousel.clientWidth / cardWidth);
  const maxIndex = totalCards - visibleCards;

  currentIndex += direction;

  if (currentIndex < 0) {
      currentIndex = maxIndex;
  } else if (currentIndex > maxIndex) {
      currentIndex = 0;
  }

  carousel.style.transform = `translateX(${-currentIndex * cardWidth}px)`;
};

function moveSlideNew(direction) {
  const carousel = document.querySelector('.carousel-slide-new');
  const totalCards = document.querySelectorAll('.card-new').length;
  const cardWidth = document.querySelector('.card-new').offsetWidth;
  const visibleCards = Math.floor(carousel.clientWidth / cardWidth);
  const maxIndex = totalCards - visibleCards;

  currentIndex += direction;

  if (currentIndex < 0) {
      currentIndex = maxIndex;
  } else if (currentIndex > maxIndex) {
      currentIndex = 0;
  }

  carousel.style.transform = `translateX(${-currentIndex * cardWidth}px)`;
};


