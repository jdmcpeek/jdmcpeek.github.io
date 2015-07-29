// simulates the exponential growth of a cell population

// TODO don't count population based on size of array; just do pow(2, num_gen)




void setup() {
  size(window.innerWidth, window.innerHeight);
  frameRate(32);
  restart();
}

ArrayList<Cell> cells = new ArrayList<Cell>();  // a collection to hold the entire cell population
int num_gen;
int population;
int growth = 2;  // the base with which we'll be growing
float scaler = 1;
boolean update = false;
float theta = 1;  // the ever-changing value by which cells bob



Graph graph = new Graph();

Color skyBlue = new Color(102, 190, 242);  // commonly used color for background and patching

class Cell {
  public float size;
  public Point position = new Point(random(0, width), random(0, height));
  public float bob = random(0, 30);
  public Color cellColor = new Color();
  // constructor
  Cell(float size) {
    this.size = size;
  }

  void shrink() {
    size *= scaler;
  }
}


class Point {
  float x, y;

  Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

class Color {
  float red, green, blue;

  Color() {
    this(random(0, 255), random(0, 255), random(0, 255));
  }

  Color(float red, float green, float blue) {
    this.red = red;
    this.green = green;
    this.blue = blue;
  }

  void fillColor() {
    fill(red, green, blue);
  }

  void backgroundColor() {
    background(red, green, blue);
  }
}

void restart() {
  cells.clear();
  scaler = 1;
  cells.add(new Cell(20));
  num_gen = 0;
  population = 1;
}


void nextGen() {
  population = (int) pow(growth, num_gen);
  for (int i = 0; i < population * (growth - 1); i++) {
    cells.add(new Cell(20));
  }
  num_gen++;
}

class Graph {
  void drawGraph() {
    pushMatrix();
    skyBlue.fillColor();
    rect(0, 0, 120, 120);
    stroke(255);  // white axes

    line(10, 110, 110, 110);  // x-axis
    line(10, 10, 10, 110);  // y-axis

    // add tick-marks to x and y axes
    for (float i = 17.5; i < 110; i += 7.5) {
      line(i, 107, i, 113);
      line(7, i - 5, 13, i - 5);
    }

    // calculate the number of generations that have passed

    stroke(255, 0, 0);
    for (int i = 1; i < num_gen + 1; i++) {
      line(10 + ((i - 1) * (97.5/13)),
      110 - (pow(growth, i-1) * (97.5/4096)),
      10 + (i * (97.5/13)),
      110 -  (pow(growth, i) * (97.5/4096)));
    }

    fill(0);
    text(num_gen + " gens", 74, 91, 50, 50);
    text("population", 21, 4, 75, 50);
    text(growth + "^" + num_gen + " = " + pow(growth, num_gen), 21, 20, 55, 50);

    popMatrix();
  }
}



void mouseClicked() {
  if (mouseButton == LEFT) {
    nextGen();
    scaler -= 0.05;
    update = true;
  }
  if (mouseButton == RIGHT) {
    restart();
  }
}

void draw() {
  if (update) {
    skyBlue.backgroundColor();
    for (int i = 0; i < cells.size(); i++) {
      fill(cells.get(i).cellColor.red, cells.get(i).cellColor.green, cells.get(i).cellColor.blue);
      cells.get(i).shrink();
      ellipse(cells.get(i).position.x,
              cells.get(i).position.y,
              cells.get(i).size,
              cells.get(i).size);
    }

    update = false;
  }
  skyBlue.backgroundColor();
  stroke(0);
  // stop moving the cells after population hits 4,096

  for (int i = 0; i < cells.size (); i++) {
    fill(cells.get(i).cellColor.red, cells.get(i).cellColor.green, cells.get(i).cellColor.blue);
    if (cells.get(i).size < 0.5) {
      cells.remove(i);
    } else {
      ellipse(cells.get(i).position.x + sin(cells.get(i).bob / 25) * 15,
              cells.get(i).position.y + cos(cells.get(i).bob / 25) * 5,
              cells.get(i).size,
              cells.get(i).size);

        if (i % 2 == 0) {
          cells.get(i).bob += random(0.1, 2);
        } else {
          cells.get(i).bob -= random(0.1, 2);
        }
    }




  }

  pushMatrix();
  {
    scale(1.75);
    graph.drawGraph();
  }
  popMatrix();
};
