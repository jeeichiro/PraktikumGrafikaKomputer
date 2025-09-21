
float t = 0;      // parameter gerak bola (0..1)
float speed = 0.005; // kecepatan gerak bola

// Titik kontrol bezier (bola -> ring kanan)
float x0 = 400, y0 = 300;  // titik awal
float x1 = 500, y1 = 150;  // kontrol 1
float x2 = 750, y2 = 450;  // kontrol 2
float x3 = 880, y3 = 300;  // titik akhir

void setup() {
  size(1000, 600);
}

void draw() {
  background(210, 180, 140);

  // ===== LAPANGAN =====
  stroke(255);
  strokeWeight(4);
  noFill();
  rect(100, 50, 800, 500);
  line(width/2, 50, width/2, 550);
  ellipse(width/2, height/2, 150, 150);
  rect(100, 200, 160, 200);
  rect(740, 200, 160, 200);
  ellipse(260, 300, 120, 120);
  ellipse(740, 300, 120, 120);
  arc(100, 300, 480, 480, -HALF_PI, HALF_PI);
  arc(900, 300, 480, 480, HALF_PI, -HALF_PI);

  // Ring kiri & kanan
  fill(255);
  rect(95, 280, 10, 40);
  rect(895, 280, 10, 40);
  fill(255, 69, 0);
  ellipse(120, 300, 40, 40);
  ellipse(880, 300, 40, 40);

  // ===== HITUNG POSISI BOLA DI BEZIER =====
  float bx = bezierPoint(x0, x1, x2, x3, t);
  float by = bezierPoint(y0, y1, y2, y3, t);

  // Gambar jalur bezier (lintasan bola)
  stroke(255, 0, 0);
  noFill();
  bezier(x0, y0, x1, y1, x2, y2, x3, y3);

  // Bola basket
  fill(255, 140, 0);
  stroke(0);
  strokeWeight(2);
  ellipse(bx, by, 50, 50);

  // Pola bola basket
  noFill();
  arc(bx, by, 50, 50, HALF_PI/2, 3*HALF_PI/2);
  arc(bx, by, 50, 50, -HALF_PI/2, PI+HALF_PI/2);
  arc(bx, by, 50, 30, 0, PI);
  arc(bx, by, 50, 30, PI, TWO_PI);

  // Update parameter t
  t += speed;
  if (t > 1) {
    t = 0; // ulang dari awal
  }

  // ===== TRIBUN & PENONTON =====
  fill(70);
  rect(0, 0, 1000, 40);
  rect(0, 560, 1000, 40);

  fill(200, 0, 0);
  for (int i = 50; i < width; i += 50) {
    ellipse(i, 20, 20, 20);
    ellipse(i, 580, 20, 20);
  }

  // Banner melengkung pakai curveVertex
  noFill();
  stroke(0, 0, 200);
  strokeWeight(3);
  beginShape();
  curveVertex(200, 40);
  curveVertex(200, 40);
  curveVertex(500, 20);
  curveVertex(800, 40);
  curveVertex(800, 40);
  endShape();
}
