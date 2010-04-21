int cellsize = 8;
int cols, rows;
int[][] then, now, tmp;
int bg = 255;
int last = 0;
int iteration = 0;

void setup() {
  size(320, 480);
  cols = width / cellsize;
  rows = height / cellsize;
  then = new int[cols][rows];
  now = new int[cols][rows];
  background(bg);
  smooth();
  randomize();
}

void draw() {
  grid();
  fill(255, 200);
  rectMode(CORNER);
  rect(0, 0, width, height);
  count();
  iteration++;
  drawboard();
}

void grid() {
  for (int a = 0; a <= cols; a++) {
    for (int b = 0; b <= rows; b++) {
      stroke(45);
      noFill();
      rectMode(CENTER);
      rect(a * cellsize, b * cellsize, cellsize, cellsize);    
    }
  }
}

void count() {
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      int count = 0;
      if(then[(x + cols - 1) % cols][(y + rows - 1) % rows] == 1) { count++; }
      if(then[x][(y + rows - 1) % rows] == 1) { count++; }
      if(then[(x + 1) % cols][(y + rows - 1) % rows] == 1) { count++; }
      if(then[(x + cols - 1) % cols][y] == 1) { count++; }
      if(then[(x + 1) % cols][y] == 1) { count++; }
      if(then[(x + cols - 1) % cols ][(y + 1) % rows] == 1) { count++; }
      if(then[x][(y + 1) % rows] == 1) { count++; }
      if(then[(x + 1) % cols][(y + 1) % rows] == 1) { count++; }
      if((then[x][y] == 1) && (count <  2)) { now[x][y] = 0; }   
      else if((then[x][y] == 1) && (count >  3)) { now[x][y] = 0; }    
      else if((then[x][y] == 0) && (count == 3)) { now[x][y] = 1; }    
      else { now[x][y] = then[x][y]; }
    }
  }
  tmp = then;
  then = now;
  now = tmp;
}

void drawboard() {
  for(int i = 0; i < cols; i++) {
    for(int j = 0; j < rows; j++) {
      if((now[i][j] == 1)) {
        fill(0);
        noStroke();
        ellipse(i * cellsize, j * cellsize, cellsize, cellsize);
      }
    }
  }
}

void randomize() {
  background(bg);
  for(int i = 0; i < cols; i++) {
    for(int j = 0; j < rows; j++) {
      if(random(1) <= 0.4) {
        then[i][j] = 1;
        now[i][j] = 1;
      } else {
        then[i][j] = 0;
        now[i][j] = 0;
      }
    }
  }
}
