  // TABLE
  /*   
        0,0   | 0,109   | 0,218
        109,0 | 109,109 | 109,218
        218,0 | 218,109 | 218,218
  //  Player = 1 for cross and 2 for circle
  */



PImage cross;
PImage circle;
PImage grid;



PImage red_bar_v;
PImage red_bar_h;
PImage red_bar_diagonal_down;
PImage red_bar_diagonal_up;

PImage blue_bar_v;
PImage blue_bar_h;
PImage blue_bar_diagonal_down;
PImage blue_bar_diagonal_up;
  
int[][] gridTable = new int[3][3];
int[][] gameTable = new int[3][3];
int startCoordX = 200;
int startCoordY = 200;

float divideX = 0;
float divideY = 0;
int x;
int y;
int moves = 0;
int tries = 0;
int nextPlayer = 1;
boolean pause;


void setup() {
  size(1366, 768);
  background(0);
  //smooth(10);
  
  red_bar_v = loadImage("src/lines/red/bar_v.png");
  red_bar_h = loadImage("src/lines/red/bar_h.png");
  red_bar_diagonal_down = loadImage("src/lines/red/bar_diagonal_down.png");
  red_bar_diagonal_up = loadImage("src/lines/red/bar_diagonal_up.png");
  
  blue_bar_v = loadImage("src/lines/blue/bar_v.png");
  blue_bar_h = loadImage("src/lines/blue/bar_h.png");
  blue_bar_diagonal_down = loadImage("src/lines/blue/bar_diagonal_down.png");
  blue_bar_diagonal_up = loadImage("src/lines/blue/bar_diagonal_up.png");
  
  cross = loadImage("src/cross.png");
  circle = loadImage("src/circle.png");
  grid = loadImage("src/grid3.png");
  image(grid, 0 + startCoordX, 0 + startCoordY);
  reset();
  moves = 0;
}

void draw() {
   if(pause == false && mousePressed && startCoordX+0 <= mouseX && mouseX <= startCoordX+318 && startCoordY+0 <= mouseY && mouseY <= startCoordY+318){
    divideX = (mouseX-startCoordX)/109;
    divideY = (mouseY-startCoordY)/109;
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
    pause = true;
    moves = 0;
    println("[info] Game Finished !");
  }
}

void crossPlays(int xPos, int yPos){
  if(verify(xPos, yPos) == false){
    image(cross, (xPos * 109) + startCoordX, (yPos * 109) + startCoordY);
    print("CROSS PLAYED x=");
    print(xPos);
    print(", y=");
    println(yPos);
    gridTable[xPos][yPos] = 1;
    nextPlayer = 2;
    moves++;
    gameTable[xPos][yPos] = 1;
    whoHasWon();
  }
}

void circlePlays(int xPos, int yPos){
  if(verify(xPos, yPos) == false){
    image(circle, (xPos * 109) + startCoordX, (yPos * 109) + startCoordY);
    print("CIRCLE PLAYED x=");
    print(xPos);
    print(", y=");
    println(yPos);
    gridTable[xPos][yPos] = 1;
    nextPlayer = 1;
    moves++;
    gameTable[xPos][yPos] = 2;
    whoHasWon();
  }
}

boolean verify(int xPos, int yPos){
  if(gridTable[xPos][yPos] == 1){
    return true;
  }
  return false;
}


void reset(){
  tries = 0;
  for(int i = 0; i<=2; i++){
    for(int j = 0; j<=2; j++){
      if(gridTable[i][j] == 1){
        tries++;
      }
    }
  }
  if(tries != 0){
    background(0);
    image(grid, 0 + startCoordX, 0 + startCoordY);
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
    for(int i = 0; i<=2; i++){
      for(int j = 0; j<=2; j++){
        gameTable[i][j] = 0;
      }
    }
    println();
    tries = 0;
    moves = 0;
    pause = false;
  }
}


void whoHasWon(){
  int winner = 0;
  // FOR CROSS (blue)
  // diagonals -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  if(gameTable[0][0] == 1 && gameTable[1][1] == 1 && gameTable[2][2] == 1){
    winner = 1;
    image(blue_bar_diagonal_down, 0 + startCoordX, 0 + startCoordY);
  }
  if(gameTable[0][2] == 1 && gameTable[1][1] == 1 && gameTable[2][0] == 1){
    winner = 1;
    image(blue_bar_diagonal_up, 0 + startCoordX, 0 + startCoordY);
  }
  //verticals -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  if(gameTable[2][0] == 1 && gameTable[2][1] == 1 && gameTable[2][2] == 1){
    winner = 1;
    image(blue_bar_v, 218 + startCoordX, 0 + startCoordY);
  }
  if(gameTable[1][0] == 1 && gameTable[1][1] == 1 && gameTable[1][2] == 1){
    winner = 1;
    image(blue_bar_v, 109 + startCoordX, 0 + startCoordY);
  }
  if(gameTable[0][0] == 1 && gameTable[0][1] == 1 && gameTable[0][2] == 1){
    winner = 1;
    image(blue_bar_v, 0 + startCoordX, 0 + startCoordY);
  }
  //hroizontals -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  if(gameTable[0][0] == 1 && gameTable[1][0] == 1 && gameTable[2][0] == 1){
    winner = 1;
    image(blue_bar_h, 0 + startCoordX, 0 + startCoordY);
  }
  if(gameTable[0][1] == 1 && gameTable[1][1] == 1 && gameTable[2][1] == 1){
    winner = 1;
    image(blue_bar_h, 0 + startCoordX, 109 + startCoordY);    
  }
  if(gameTable[0][2] == 1 && gameTable[1][2] == 1 && gameTable[2][2] == 1){
    winner = 1;
    image(blue_bar_h, 0 + startCoordX, 218 + startCoordY);
  }
  
  
  
  // FOR CIRCLE (red)
  // diagonals -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  if(gameTable[0][0] == 2 && gameTable[1][1] == 2 && gameTable[2][2] == 2){
    winner = 2;
    image(red_bar_diagonal_down, 0 + startCoordX, 0 + startCoordY);
  }
  if(gameTable[0][2] == 2 && gameTable[1][1] == 2 && gameTable[2][0] == 2){
    winner = 2;
    image(red_bar_diagonal_up, 0 + startCoordX, 0 + startCoordY);
  }
  //verticals -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  if(gameTable[2][0] == 2 && gameTable[2][1] == 2 && gameTable[2][2] == 2){
    winner = 2;
    image(red_bar_v, 218 + startCoordX, 0 + startCoordY);
  }
  if(gameTable[1][0] == 2 && gameTable[1][1] == 2 && gameTable[1][2] == 2){
    winner = 2;
    image(red_bar_v, 109 + startCoordX, 0 + startCoordY);
  }
  if(gameTable[0][0] == 2 && gameTable[0][1] == 2 && gameTable[0][2] == 2){
    winner = 2;
    image(red_bar_v, 0 + startCoordX, 0 + startCoordY);
  }
  //hroizontals -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  if(gameTable[0][0] == 2 && gameTable[1][0] == 2 && gameTable[2][0] == 2){
    winner = 2;
    image(red_bar_h, 0 + startCoordX, 0 + startCoordY);
  }
  if(gameTable[0][1] == 2 && gameTable[1][1] == 2 && gameTable[2][1] == 2){
    winner = 2;
    image(red_bar_h, 0 + startCoordX, 109 + startCoordY);
  }
  if(gameTable[0][2] == 2 && gameTable[1][2] == 2 && gameTable[2][2] == 2){
    winner = 2;
    image(red_bar_h, 0 + startCoordX, 218 + startCoordY);
  }
  
  if(winner != 0){
    if(winner == 1){
      println("[info] CROSS WON !");
      moves = 9;
      winner = 0;
    }
    if(winner == 2){
      println("[info] CIRCLE WON ! ");
      moves = 9;
      winner = 0;
    }
  } else {
    if(moves == 9){
      println("[info] IT'S A TIE ! ");
    }
  }
}
