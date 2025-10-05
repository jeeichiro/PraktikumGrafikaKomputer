 import processing.sound.*; // Import library sound untuk audio 

// Deklarasi variabel sound
 SoundFile whistleSound; // File audio whistle basket 

float t = 0; // Parameter untuk posisi di kurva bezier (0-1)
float speed = 0.004; // Kecepatan pergerakan bola
float rotasi = 0; // Rotasi bola basket

// Titik kontrol bezier (bola bergerak ke ring kanan)
float x0 = 400, y0 = 320; // Titik awal
float x1 = 500, y1 = 180; // Titik kontrol 1
float x2 = 720, y2 = 420; // Titik kontrol 2
float x3 = 860, y3 = 300; // Titik akhir

// Variabel interaktif
boolean isPaused = false; // Status pause/play animasi
int bgColor = 180; // Warna background
boolean showPath = true; // Toggle tampilan lintasan
float ballSize = 40; // Ukuran bola

void setup() {
  size(1000, 600); // Ukuran canvas
  smooth(); // Anti-aliasing
  
  // Load file audio whistle 
   whistleSound = new SoundFile(this, "./audio/basketball.mp3");
  // whistleSound.amp(0.5); // Set volume 50%
}

void draw() {
  background(bgColor, 120, 70); // kayu dasar arena
  
  // ===== LANTAI KAYU STRIP =====
  noStroke(); // Hilangkan garis tepi
  for (int i = 0; i < height; i += 20) { // Loop strip kayu
    if (i % 40 == 0) fill(200, 150, 90); // Strip terang
    else fill(190, 140, 80); // Strip gelap
    quad(150, 70+i*0.1, 850, 70+i*0.1, 950, 530+i*0.1, 50, 530+i*0.1); // Gambar strip
  }
  
  // ===== LAPANGAN (TRAPEZIUM) =====
  noFill(); // Tanpa isi
  stroke(255); // Garis putih
  strokeWeight(3); // Ketebalan 3px
  // outline lapangan
  quad(150, 70, 850, 70, 950, 530, 50, 530); // Outline lapangan
  
  // Garis tengah
  line(500, 70, 500, 530); // Garis tengah lapangan
  
  // Lingkaran tengah (oval biar sesuai perspektif)
  ellipse(500, 300, 180, 60); // Lingkaran tengah
  
  // Area key kiri
  quad(150, 200, 250, 200, 280, 400, 120, 400); // Key kiri
  ellipse(250, 300, 120, 50); // free throw kiri
  
  // Area key kanan
  quad(750, 200, 850, 200, 880, 400, 720, 400); // Key kanan
  ellipse(750, 300, 120, 50); // free throw kanan
  
  // Garis 3 poin kiri
  arc(150, 300, 480, 220, -HALF_PI, HALF_PI); // Arc 3-point kiri
  
  // Garis 3 poin kanan
  arc(850, 300, 480, 220, HALF_PI, -HALF_PI); // Arc 3-point kanan
  
  // ===== RING KIRI & KANAN =====
  fill(255, 69, 0); // Warna orange ring
  stroke(0); // Garis hitam
  ellipse(120, 300, 35, 15);   // ring kiri (oval karena perspektif)
  ellipse(880, 300, 35, 15);   // ring kanan
  fill(255); // Warna putih papan
  rect(110, 260, 20, 80);      // papan kiri
  rect(870, 260, 20, 80);      // papan kanan
  
  // ===== POSISI BOLA DI BEZIER =====
  float bx = bezierPoint(x0, x1, x2, x3, t); // Posisi X bola
  float by = bezierPoint(y0, y1, y2, y3, t); // Posisi Y bola
  
  // Jalur bezier (lintasan bola)
  if (showPath) { // Jika showPath true
    stroke(255, 0, 0, 120); // Garis merah transparan
    strokeWeight(2); // Ketebalan 2px
    noFill(); // Tanpa isi
    bezier(x0, y0, x1, y1, x2, y2, x3, y3); // Kurva bezier
  }
  
  // ===== BOLA BASKET =====
  pushMatrix(); // Simpan koordinat
  translate(bx, by); // Pindah ke posisi bola
  rotate(rotasi); // Rotasi bola
  fill(255, 140, 0); // Orange
  stroke(0); // Hitam
  strokeWeight(2); // Ketebalan 2px
  ellipse(0, 0, ballSize, ballSize); // Gambar bola
  
  // Pola bola basket
  noFill(); // Tanpa isi
  arc(0, 0, ballSize, ballSize, HALF_PI/2, 3*HALF_PI/2); // Lengkung kiri
  arc(0, 0, ballSize, ballSize, -HALF_PI/2, PI+HALF_PI/2); // Lengkung kanan
  arc(0, 0, ballSize, ballSize*0.625, 0, PI); // Lengkung atas
  arc(0, 0, ballSize, ballSize*0.625, PI, TWO_PI); // Lengkung bawah
  popMatrix(); // Kembalikan koordinat
  
  // Update bola
  if (!isPaused) { // Jika tidak pause
    t += speed; // Tambah parameter t
    if (t > 1) t = 0; // Reset jika > 1
    rotasi += 0.05; // Tambah rotasi
  }
  
  // ===== TRIBUN 3D BERTINGKAT =====
  noStroke(); // Tanpa garis
  fill(90); // Abu-abu
  
  // Tribun atas bertingkat
  for (int i = 0; i < 3; i++) { // Loop 3 tingkat
    pushMatrix(); // Simpan koordinat
    translate(0, 0 - (i*25)); // Geser atas
    scale(1 - i*0.05, 1); // Scale 3D
    rect(0, 0, 1000, 40); // Gambar tribun
    popMatrix(); // Kembalikan koordinat
  }
  
  // Tribun bawah bertingkat
  for (int i = 0; i < 3; i++) { // Loop 3 tingkat
    pushMatrix(); // Simpan koordinat
    translate(0, 560 + (i*25)); // Geser bawah
    scale(1 - i*0.05, 1); // Scale 3D
    rect(0, 0, 1000, 40); // Gambar tribun
    popMatrix(); // Kembalikan koordinat
  }
  
  // Penonton
  fill(200, 0, 0); // Merah
  for (int i = 50; i < width; i += 50) { // Loop penonton
    ellipse(i, 20, 18, 18); // Penonton atas
    ellipse(i, 580, 18, 18); // Penonton bawah
  }
  
  // ===== LOGO TENGAH LAPANGAN =====
  pushMatrix(); // Simpan koordinat
  translate(500, 300); // Ke tengah
  scale(1.8, 0.8); // pipihkan biar ikut perspektif
  fill(255, 255, 0, 100); // Kuning transparan
  noStroke(); // Tanpa garis
  ellipse(0, 0, 60, 60); // Logo
  popMatrix(); // Kembalikan koordinat
}

// ===== EVENT MOUSE =====

// 1. mousePressed() - Saat mouse ditekan
void mousePressed() {
  float bx = bezierPoint(x0, x1, x2, x3, t); // Posisi X bola
  float by = bezierPoint(y0, y1, y2, y3, t); // Posisi Y bola
  float d = dist(mouseX, mouseY, bx, by); // Jarak mouse ke bola (mouseX, mouseY)
  
  if (d < ballSize/2) { // Jika klik bola
    ballSize += 5; // Besarkan bola
    ballSize = constrain(ballSize, 20, 80); // Batasi size
  }
}

// 2. mouseReleased() - Saat mouse dilepas
void mouseReleased() {
  if (mouseX > 150 && mouseX < 850 && mouseY > 70 && mouseY < 530) { // Jika di area lapangan (mouseX, mouseY)
    isPaused = !isPaused; // Toggle pause
     whistleSound.play(); // Play whistle 
  }
}

// 3. mouseMoved() - Saat mouse bergerak
void mouseMoved() {
  bgColor = int(map(mouseX, 0, width, 150, 220)); // Ubah background dari mouseX
}

// 4. mouseClicked() - Saat klik sempurna
void mouseClicked() {
  if (mouseButton == RIGHT) { // Jika klik kanan
    t = 0; // Reset posisi
    rotasi = 0; // Reset rotasi
  }
}

// 5. mouseDragged() - Saat mouse di-drag
void mouseDragged() {
  speed = map(mouseX, 0, width, 0.001, 0.02); // Ubah speed dari mouseX
}

// ===== EVENT KEYBOARD =====

// 1. keyPressed() - Saat tombol ditekan
void keyPressed() {
  // Deteksi key biasa
  if (key == ' ') { // Jika SPACE (key)
    isPaused = !isPaused; // Toggle pause
    // whistleSound.play(); // Play whistle 
  } 
  else if (key == 't' || key == 'T') { // Jika T (key)
    showPath = !showPath; // Toggle path
  }
  else if (key == 'r' || key == 'R') { // Jika R (key)
    t = 0; // Reset posisi
    rotasi = 0; // Reset rotasi
    speed = 0.004; // Reset speed
    ballSize = 40; // Reset size
  }
  
  // Deteksi keyCode khusus
  if (key == CODED) { // Jika key CODED
    if (keyCode == UP) { // Panah atas (keyCode)
      speed += 0.001; // Tambah speed
      speed = constrain(speed, 0.001, 0.02); // Batasi speed
    } 
    else if (keyCode == DOWN) { // Panah bawah (keyCode)
      speed -= 0.001; // Kurangi speed
      speed = constrain(speed, 0.001, 0.02); // Batasi speed
    }
    else if (keyCode == LEFT) { // Panah kiri (keyCode)
      ballSize -= 5; // Kecilkan bola
      ballSize = constrain(ballSize, 20, 80); // Batasi size
    }
    else if (keyCode == RIGHT) { // Panah kanan (keyCode)
      ballSize += 5; // Besarkan bola
      ballSize = constrain(ballSize, 20, 80); // Batasi size
    }
  }
}

// 2. keyReleased() - Saat tombol dilepas
void keyReleased() {
  if (key == 'p' || key == 'P') { // Jika P dilepas (key)
    isPaused = !isPaused; // Toggle pause
  }
}
