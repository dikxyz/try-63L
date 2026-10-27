// Amanah Komputer — navigasi, animasi, dan formulir WhatsApp
const mobileMenuButton = document.getElementById("mobile-menu-button");
const mobileMenu = document.getElementById("mobile-menu");
const mobileMenuLinks = document.querySelectorAll(".mobile-menu-link");

if (mobileMenuButton && mobileMenu) {
  mobileMenuButton.addEventListener("click", () => {
    const isOpen = !mobileMenu.classList.contains("hidden");
    mobileMenu.classList.toggle("hidden", isOpen);
    mobileMenuButton.textContent = isOpen ? "☰" : "✕";
    mobileMenuButton.setAttribute("aria-expanded", String(!isOpen));
    mobileMenuButton.setAttribute("aria-label", isOpen ? "Buka menu navigasi" : "Tutup menu navigasi");
  });

  mobileMenuLinks.forEach((link) => {
    link.addEventListener("click", () => {
      mobileMenu.classList.add("hidden");
      mobileMenuButton.textContent = "☰";
      mobileMenuButton.setAttribute("aria-expanded", "false");
      mobileMenuButton.setAttribute("aria-label", "Buka menu navigasi");
    });
  });
}

const revealElements = document.querySelectorAll(".reveal");
if ("IntersectionObserver" in window) {
  const revealObserver = new IntersectionObserver((entries, observer) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        entry.target.classList.add("active");
        observer.unobserve(entry.target);
      }
    });
  }, { threshold: 0.12 });
  revealElements.forEach((element) => revealObserver.observe(element));
} else {
  revealElements.forEach((element) => element.classList.add("active"));
}

// Nomor WhatsApp Amanah Komputer. Samakan dengan tautan wa.me di index.html.
const whatsappNumber = "6281310158206";

const openWhatsApp = (message) => {
  const whatsappURL = `https://wa.me/${whatsappNumber}?text=${encodeURIComponent(message)}`;
  window.open(whatsappURL, "_blank", "noopener,noreferrer");
};

// Tombol "Tanya stok & harga" pada kartu produk membuka WhatsApp dengan pesan terkait.
document.querySelectorAll(".js-product-inquiry").forEach((link) => {
  link.addEventListener("click", (event) => {
    const product = link.dataset.product;
    if (!product) return;
    event.preventDefault();
    openWhatsApp(
      `Halo Amanah Komputer, saya ingin menanyakan stok, harga, dan spesifikasi untuk ${product}. Apakah unitnya masih tersedia?`
    );
  });
});

const inquiryForm = document.getElementById("inquiry-form");

if (inquiryForm) {
  inquiryForm.addEventListener("submit", (event) => {
    event.preventDefault();
    const name = document.getElementById("inquiry-name").value.trim();
    const topic = document.getElementById("inquiry-topic").value;
    const device = document.getElementById("inquiry-device").value.trim();
    const message = document.getElementById("inquiry-message").value.trim();

    if (!name || !topic || !message) {
      inquiryForm.reportValidity();
      return;
    }

    const whatsappMessage =
`Halo Amanah Komputer, saya ingin berkonsultasi tentang laptop.

Nama: ${name}
Kebutuhan: ${topic}
Laptop / perangkat: ${device || "-"}

Detail kebutuhan / keluhan:
${message}

Terima kasih.`;

    openWhatsApp(whatsappMessage);
  });
}

const backToTopButton = document.getElementById("back-to-top");
if (backToTopButton) {
  const updateBackToTop = () => backToTopButton.classList.toggle("visible", window.scrollY > 500);
  window.addEventListener("scroll", updateBackToTop, { passive: true });
  updateBackToTop();
  backToTopButton.addEventListener("click", () => window.scrollTo({ top: 0, behavior: "smooth" }));
}

const year = document.getElementById("current-year");
if (year) year.textContent = new Date().getFullYear();
