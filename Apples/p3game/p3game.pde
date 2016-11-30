/*
* Authors: Jose Martinez and An Tran
 * Program Name: Apples Catcher
 * Description: A simple "catch" game with menu, 
 * game and win screens.
 * It makes use of keyboard interaction, 
 * namely "s" to start the game, "r" to replay
 * the game, "m" to go back to the main menu
 * and the left and right keys to move the basket.
 * The objective of the game is to get a score of 10
 * by catching apples.
 * You gain a point for each apple caught and
 * lose a point for each apple dropped.
 * (IMPORTANT): Program makes use of a font, 
 * create font Verdana-40 for program to work
 */

//Global variables
//Game Variables
float s; //Variable that determines the screen shown
PFont font; //Loads the text font
float score; //Variable for the score

//Apples variables
float AX;  //X-variable for game apple
float AX1; //X-variable for game win screen apple
float AX2; //X-variable for game win screen apple
float AX3; //X-variable for game win screen apple
float AY; //Y-variable for apples
float AR; //Radius of apples
float AS; //Speed of apples

//Basket variables
float BX; //X-variable of basket
float BY; //Y-variable of basket
float BW; //Width of basket
float BH; //Height of basket



void setup() {   //Beginning
  size(500, 500); //Sets size of screen to 500 x 500
  background(255); //Sets back ground to white
  smooth(); //Smooths
  
  font = loadFont("Verdana-40.vlw"); //Sets font of text
  s = 1; //Sets initial screen to "main menu"
  score = 0; //Sets score to 0
  
  //Apples variables
  AR = 40; //Size of apples
  AX = random(AR, 500-AR); //Spawns apple at random X-position
  AX1 = random(85, 415); //Same but for a win screen apple
  AX2 = random(85, 415); //Same but for a win screen apple
  AX3 = random(85, 415); //Same but for a win screen apple
  AY = random(AR, 150); 
  AS = random(6, 12); //Randomises speed of apple after each spawn

  //Basket
  BX = 400; //Initial X-position of basket
  BY = 400; //Initial Y-position of basket
  BW = 50; //Width of basket
  BH = 50; //Height of basket
}

void draw() { 
  if (s == 1) {
    //Displays "main menu"
    background(151, 199, 237); //Sky blue
    noStroke();
    rectMode(CORNERS);
    ellipseMode(CENTER);
    
    //Grass
    fill(7, 240, 71); //Grass green
    rect(0, 450, width, height); //Grass
    
    //Tree trunk
    fill(222, 176, 90); //Bark brown
    rect(220, 200, 280, 450); //Tree trunk
    
    //Tree top
    fill(10, 193, 63); //Leaf green
    ellipse(250, 100, 450, 340); //Leaves
    
    //Apples
    fill(255, 31, 31); //Apple red
    ellipse(200, 50, AR, AR); //apple1
    ellipse(150, 240, AR, AR); //apple2
    ellipse(120, 190, AR, AR); //apple3
    ellipse(340, 150, AR, AR); //apple4
    ellipse(420, 100, AR, AR); //apple5

    //Words on Startup Screen
    fill(0, 0, 255); //Blue letters
    textFont(font, 50); //Changes size of text
    text("Apples Catcher", 70, 100); //Game title
    fill(0, 0, 0); //B;ack letter
    textFont(font, 20); //Changes size of text
    text("How to play:", 190, 160); //Game instructions
    text("Move by pressing the arrow keys.", 90, 200); //Game instructions
    text("Get a score of 10.", 170, 240); //Game instructions
    fill(10, 165, 55); //Green letters
    textFont(font, 25); //Changes size of text
    text("Press s to start.", 160, 350); //Game instructions
    
    //Sets screen to "game" screen
    if (keyPressed) {
      if (key == 's') {
        s = 2;
      }
    }
  } 
  
  //Game screen
  if (s == 2) {
    AY = AY+AS;//Speed of apple
    background(151, 199, 237); //Sky blue
    fill(7, 240, 71); //Grass green
    rect(width/2, 450, width, 100); //Grass
    
    //Basket 
    rectMode(CENTER);
    fill(167, 115, 2); //Brown
    rect(BX, BY, BW, BH); //Draws Basket
    
    //Movement inputs for basket
    if (keyPressed) {
      if (keyCode == LEFT) {
        BX = BX - 10; //Moves basket to the left
      } else {
        if (keyCode == RIGHT) {
          BX = BX + 10; //Moves basket to the right
        }
      }
    }  
    
    //Apple
    fill(255, 31, 31); //Apple red
    ellipse(AX, AY, AR, AR); //Draws Apple
    
    //If apple falls to the grass
    if (AY >= 410) {
      AY= 0; //Respawns apple at top of the screen
      AX= random(AR, 500-AR); //Respawns apple at a random x-position
      score = score - 1; //Reduces score by 1 for each apple missed
      AS = random(6, 12); //Randomises speed of apple after each spawn
    }
    
    //Collision detection of apple and basket
    if (AY + AR >= BY && AX + AR >= BX && AX <= BX + BW) {
      AY = 0; //Respawns apple at top of the screen
      AX = random(AR, 500-AR); //Respawns apple at a random x-position
      score = score + 1; //Increases apple for each caught apple
      AS = random(6, 12); //Randomises speed of apple after each spawn
    }
    
    text("Score: " + score, 340, 50); //Displays current score
    
    //If score drops below 0
    if (score <= 0) {
      score= 0; //Sets score back to 0
    }
    
    //Win condition
    if (score == 10) {
      s = 3; //Sets screen to "win" screen
    }
  }
  
  //"Win" screen
  if (s == 3) {
    background(151, 199, 237); //Sky blue
    noStroke();
    smooth();
    
    //Basket
    fill(167, 115, 2); //Brown
    rect(width/2, 400, 350, 200); //Front of basket
    fill(147, 103, 9); //Darker brown
    ellipse(width/2, 300, 350, 170); //Basket top
    
    AY = AY +AS; //Speed of apples
    fill(255, 31, 31); //Apple red
    ellipse(AX1, AY, AR, AR); //Apple1
    ellipse(AX2, AY, AR, AR); //Apple2
    ellipse(AX3, AY, AR, AR); //Apple3
    
    //When apples fall into basket
    if (AY >= 320) {
      AY=0; //Respawns apple at top of the screen
      AX1= random(85, 415); //Respawns apple at a random x-position
      AX2= random(85, 415); //Respawns apple at a random x-position
      AX3= random(85, 415); //Respawns apple at a random x-position
    }
    
    //Text
    fill(0); //Black text
    textFont(font, 50); //Changes size of text
    text("YOU WIN", width/4 + 10, 130); //Displays text
    textFont(font, 30); //Changes size of text
    text("Replay press r", width/3 - 10, 420); //Displays text
    text("Main Menu press m", width/4 - 10, 470); //Displays text
    
    //Restarts game or Returns to main menu
    if (keyPressed) {
      if (key == 'r') {
        s = 2; //Restarts game
        score = 0; //Resets score so game can be played again
      } else {
        if (key == 'm') {
          s = 1; //Returns to main menu
          score = 0; //Resets score so game can be played again
        }
      }
    }
  }
}






