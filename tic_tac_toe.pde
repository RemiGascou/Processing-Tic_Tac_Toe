  // TABLE
  /*   
        0,0   | 0,109   | 0,218
        109,0 | 109,109 | 109,218
        218,0 | 218,109 | 218,218
  //  int nextPlayer = 1 for cross and 2 for circle
  */



PImage cross;
PImage circle;
PImage grid;

int[][] gridTable = new int[3][3];

float divideX = 0;
float divideY = 0;
int x;
int y;
int moves = 0;
int tries = 0;
int nextPlayer = 1;


void setup() {
  size(319, 319);
  //smooth(10);
  cross = loadImage("src/small/cross.png");
  circle = loadImage("src/small/circle.png");
  grid = loadImage("src/small/grid.png");
  image(grid, 0, 0);
  reset();
}

void draw() {
   if(mousePressed && 0 <= mouseX && mouseX <= 318 && 0 <= mouseY && mouseY <= 318){
    divideX = mouseX/109;
    divideY = mouseY/109;
    x = (int)divideX;
    y = (int)divideY;
    
    if(nextPlayer == 1){
      crossPlays(x,y);
      
    }
    else {
      if(nextPlayer == 2){
        circlePlays(x,y);
      }
    }
  }
  
  if(key == ' '){
    reset();
  }
  if(moves == 9){
    moves = 0;
    println("[info] Game Finished !");
  }
}

void crossPlays(int xPos, int yPos){
  if(verify(xPos, yPos) == false){
    image(cross, xPos * 109,yPos * 109);
    print("CROSS PLAYED x=");
    print(xPos);
    print(", y=");
    println(yPos);
    gridTable[xPos][yPos] = 1;
    nextPlayer = 2;
    moves++;
  }
}

void circlePlays(int xPos, int yPos){
  if(verify(xPos, yPos) == false){
    image(circle, xPos * 109,yPos * 109);
    print("CIRCLE PLAYED x=");
    print(xPos);
    print(", y=");
    println(yPos);
    gridTable[xPos][yPos] = 1;
    nextPlayer = 1;
    moves++;
  }
}

boolean verify(int xPos, int yPos){
  if(gridTable[xPos][yPos] == 1){
    return true;
  }
  return false;
}

boolean isGameFinished(){
  moves = 0;
  for(int i = 0; i<=2; i++){
    for(int j = 0; j<=2; j++){
      if(gridTable[i][j] == 1){
        moves++;
      }
    }
  }
  print("Moves = ");
  println(moves);
  if(moves == 9){
    moves = 0;
    return true;
  } else {
  return false;
  }
}

void reset(){
  for(int i = 0; i<=2; i++){
    for(int j = 0; j<=2; j++){
      if(gridTable[i][j] == 1){
        tries++;
      }
    }
  }
  if(tries != 0){
    background(0);
    image(grid, 0, 0);
    key = '-';
    println();
    println("[info] RESETING GAME : ");
    print("# Old table : ");
    for(int i = 0; i<=2; i++){
      for(int j = 0; j<=2; j++){
        print(gridTable[i][j]);
      }
    }
    println();
    print("# New table : ");
    for(int i = 0; i<=2; i++){
      for(int j = 0; j<=2; j++){
        gridTable[i][j] = 0;
        print(gridTable[i][j]);
      }
    }
    println();
    tries = 0;
  }
}
