
float t = 0;
float speed = 0.004;
float rotasi = 0;

// Titik kontrol bezier (bola bergerak ke ring kanan)
float x0 = 400, y0 = 320;
float x1 = 500, y1 = 180;
float x2 = 720, y2 = 420;
float x3 = 860, y3 = 300;

void setup() {
  size(1000, 600);
  smooth();
}

void draw() {
  background(180, 120, 70); // kayu dasar arena

  // ===== LANTAI KAYU STRIP =====
  noStroke();
  for (int i = 0; i < height; i += 20) {
    if (i % 40 == 0) fill(200, 150, 90);
    else fill(190, 140, 80);
    quad(150, 70+i*0.1, 850, 70+i*0.1, 950, 530+i*0.1, 50, 530+i*0.1);
  }

  // ===== LAPANGAN (TRAPEZIUM) =====
  noFill();
  stroke(255);
  strokeWeight(3);
  // outline lapangan
  quad(150, 70, 850, 70, 950, 530, 50, 530);

  // Garis tengah
  line(500, 70, 500, 530);

  // Lingkaran tengah (oval biar sesuai perspektif)
  ellipse(500, 300, 180, 60);

  // Area key kiri
  quad(150, 200, 250, 200, 280, 400, 120, 400);
  ellipse(250, 300, 120, 50); // free throw kiri

  // Area key kanan
  quad(750, 200, 850, 200, 880, 400, 720, 400);
  ellipse(750, 300, 120, 50); // free throw kanan

  // Garis 3 poin kiri
  arc(150, 300, 480, 220, -HALF_PI, HALF_PI);

  // Garis 3 poin kanan
  arc(850, 300, 480, 220, HALF_PI, -HALF_PI);

  // ===== RING KIRI & KANAN =====
  fill(255, 69, 0);
  stroke(0);
  ellipse(120, 300, 35, 15);   // ring kiri (oval karena perspektif)
  ellipse(880, 300, 35, 15);   // ring kanan
  fill(255);
  rect(110, 260, 20, 80);      // papan kiri
  rect(870, 260, 20, 80);      // papan kanan

  // ===== POSISI BOLA DI BEZIER =====
  float bx = bezierPoint(x0, x1, x2, x3, t);
  float by = bezierPoint(y0, y1, y2, y3, t);

  // Jalur bezier (lintasan bola)
  stroke(255, 0, 0, 120);
  strokeWeight(2);
  noFill();
  bezier(x0, y0, x1, y1, x2, y2, x3, y3);

  // ===== BOLA BASKET =====
  pushMatrix();
  translate(bx, by);
  rotate(rotasi);
  fill(255, 140, 0);
  stroke(0);
  strokeWeight(2);
  ellipse(0, 0, 40, 40);

  // Pola bola basket
  noFill();
  arc(0, 0, 40, 40, HALF_PI/2, 3*HALF_PI/2);
  arc(0, 0, 40, 40, -HALF_PI/2, PI+HALF_PI/2);
  arc(0, 0, 40, 25, 0, PI);
  arc(0, 0, 40, 25, PI, TWO_PI);
  popMatrix();

  // Update bola
  t += speed;
  if (t > 1) t = 0;
  rotasi += 0.05;

  // ===== TRIBUN 3D BERTINGKAT =====
  noStroke();
  fill(90);

  // Tribun atas bertingkat
  for (int i = 0; i < 3; i++) {
    pushMatrix();
    translate(0, 0 - (i*25));
    scale(1 - i*0.05, 1);
    rect(0, 0, 1000, 40);
    popMatrix();
  }

  // Tribun bawah bertingkat
  for (int i = 0; i < 3; i++) {
    pushMatrix();
    translate(0, 560 + (i*25));
    scale(1 - i*0.05, 1);
    rect(0, 0, 1000, 40);
    popMatrix();
  }

  // Penonton
  fill(200, 0, 0);
  for (int i = 50; i < width; i += 50) {
    ellipse(i, 20, 18, 18);
    ellipse(i, 580, 18, 18);
  }

  // ===== LOGO TENGAH LAPANGAN =====
  pushMatrix();
  translate(500, 300);
  scale(1.8, 0.8); // pipihkan biar ikut perspektif
  fill(255, 255, 0, 100);
  noStroke();
  ellipse(0, 0, 60, 60);
  popMatrix();
}
