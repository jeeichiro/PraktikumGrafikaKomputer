
void setup() {
  size(1000, 600); 
  background(210, 180, 140); // Warna kayu coklat muda
}

void draw() {
  // ===== LAPANGAN UTAMA =====
  stroke(255);
  strokeWeight(4);
  noFill();
  rect(100, 50, 800, 500); // Lapangan persegi panjang
  
  // ===== GARIS TENGAH & LINGKARAN =====
  line(width/2, 50, width/2, 550); // Garis tengah
  ellipse(width/2, height/2, 150, 150); // Lingkaran tengah
  
  // ===== PAINT AREA (KEY) =====
  rect(100, 200, 160, 200);  // Key kiri
  rect(740, 200, 160, 200);  // Key kanan
  
  // ===== FREE THROW CIRCLES =====
  noFill();
  ellipse(260, 300, 120, 120); // Lingkaran free throw kiri
  ellipse(740, 300, 120, 120); // Lingkaran free throw kanan
  
  // ===== GROUND SEMICIRCLE (TIGA POIN) =====
  arc(100, 300, 480, 480, -HALF_PI, HALF_PI); // Kiri
  arc(900, 300, 480, 480, HALF_PI, -HALF_PI); // Kanan
  
  // ===== RING & PAPAN =====
  // Kiri
  fill(255); rect(95, 280, 10, 40);    // Papan
  fill(255, 69, 0); ellipse(120, 300, 40, 40); // Ring
  // Kanan
  fill(255); rect(895, 280, 10, 40);   
  fill(255, 69, 0); ellipse(880, 300, 40, 40);
  
  // ===== BOLA BASKET DI TENGAH =====
  fill(255, 140, 0); 
  stroke(0);
  strokeWeight(2);
  ellipse(width/2, height/2, 50, 50); // Bola
  
  // Garis bola
  line(width/2 - 25, height/2, width/2 + 25, height/2);
  line(width/2, height/2 - 25, width/2, height/2 + 25);
  arc(width/2, height/2, 50, 50, HALF_PI/2, PI+HALF_PI/2);
  arc(width/2, height/2, 50, 50, -HALF_PI/2, PI-HALF_PI/2);
  
  // ===== TRIBUN PENONTON =====
  fill(70);
  rect(0, 0, 1000, 40);   // Atas
  rect(0, 560, 1000, 40); // Bawah
 
}
