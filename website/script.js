/* =========================================================
   CricStatz – Main Script
   Handles: Scroll reveals, nav active state, download animation
   ========================================================= */

document.addEventListener("DOMContentLoaded", () => {

  // ── 1. Scroll-Reveal with IntersectionObserver ──────────
  const revealElements = document.querySelectorAll(
    ".reveal, .reveal-left, .reveal-right, .reveal-scale"
  );

  const revealObserver = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add("visible");
        }
      });
    },
    { threshold: 0.15, rootMargin: "0px 0px -40px 0px" }
  );

  revealElements.forEach((el) => revealObserver.observe(el));

  // ── 2. Active Nav Link on Scroll ────────────────────────
  const sections = document.querySelectorAll(".section[id]");
  const navLinks = document.querySelectorAll(".nav-links a");

  const navObserver = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          const id = entry.target.getAttribute("id");
          navLinks.forEach((link) => {
            link.classList.toggle(
              "active",
              link.getAttribute("href") === `#${id}`
            );
          });
        }
      });
    },
    { threshold: 0.4 }
  );

  sections.forEach((section) => navObserver.observe(section));

  // ── 3. Cricket Ball Download Animation ──────────────────
  const downloadBtn = document.getElementById("downloadBtn");
  const overlay = document.getElementById("cricketOverlay");
  const hiddenLink = document.getElementById("hiddenDownload");

  let animating = false;

  downloadBtn.addEventListener("click", () => {
    if (animating) return;
    animating = true;

    // Step 1: Show overlay with dark backdrop + batsman swing
    overlay.classList.add("active");

    // Step 2: After batsman appears and swings (0.5s), 
    // the ball starts flying (handled by CSS delay).
    // At ~1.1s the ball "hits" the user — trigger the impact flash
    setTimeout(() => {
      overlay.classList.add("impact");
    }, 1100);

    // Step 3: Clean up and trigger download after animation completes
    setTimeout(() => {
      overlay.classList.remove("active", "impact");
      animating = false;

      // Trigger actual download
      hiddenLink.click();
    }, 2000);
  });

  // ── 4. Navbar background on scroll ──────────────────────
  const navbar = document.getElementById("navbar");
  window.addEventListener("scroll", () => {
    if (window.scrollY > 80) {
      navbar.style.background = "rgba(0, 0, 0, 0.85)";
    } else {
      navbar.style.background = "rgba(0, 0, 0, 0.6)";
    }
  });
});
