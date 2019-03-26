PImage bg, hog, soil, life, soldier, robot, cabbage;
PImage startNormal, startHovered, restartNormal, restartHovered;
float soldierX, soldierY;
float hogX, hogY;
float hogSpeed=80;
float cabbageX, cabbageY;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_WIN = 2;
final int GAME_LOSE = 3;
int gameState = GAME_START;

int lifeNumber = 2;

boolean downPressed;
boolean rightPressed;
boolean leftPressed;


void setup() {
  
  size(640, 480);
  bg = loadImage("img/bg.jpg");
  
  hog = loadImage("img/groundhogIdle.png");
  hogX = 320;
  hogY = 80;
  
  startNormal=loadImage("img/startNormal.png");
  startHovered=loadImage("img/startHovered.png");
  restartNormal=loadImage("img/restartNormal.png");
  restartHovered=loadImage("img/restartHovered.png");
  
  cabbage= loadImage("img/cabbage.png");
  cabbageX = floor(random(0,8))*80;
  cabbageY = floor(random(0,4))*80 + 160;
  
  soil = loadImage("img/soil.png");
  life = loadImage("img/life.png");
  
  soldier = loadImage("img/soldier.png");
  //decide soldierY
  soldierX = -80;
  soldierY = int(random(0,4))*80+160;
  
  downPressed=false;
  rightPressed=false;
  leftPressed=false;
    
  gameState = GAME_START;
  lifeNumber=2;
}

void draw() {

  //draw background
  image(bg,0,0);
  image(soil,0,160);
  
  //cabbage
  image(cabbage, cabbageX , cabbageY);
  
  //grass
  noStroke();
  fill(124,204,25);
  rectMode(CORNERS);
  rect(0,145,640,160);
  
  //sun
  fill(253,184,19);
  stroke(255,255,0);
  strokeWeight(5);
  ellipse(590,50,120,120);
  
  //soldierwalk
  soldierX +=5;
  soldierX%=640;
  image(soldier,soldierX,soldierY);
 
  //boundarydetection
    if(hogX>width-80){
    hogX=width-80;}
    
    if(hogX<0){
    hogX=0;}
    
    if(hogY>height-80){
    hogY=height-80;}
    
    image(hog,hogX,hogY);
    
    
      //collide detection      
      if(hogX<soldierX+80 && hogX+80>soldierX && 
       hogY < soldierY+80 && hogY+80 > soldierY){
       lifeNumber=lifeNumber-1; 
       hogX = 320;
       hogY = 80;
       }

       if(hogX<cabbageX+80 && hogX+80>cabbageX && 
       hogY < cabbageY+80 && hogY+80 > cabbageY){
       cabbageX=800;
       lifeNumber=lifeNumber+1;}
       
      
    //lifeNumber
    switch(lifeNumber){
    case 3:
    image(life,10,10);image(life,81,10);image(life,152,10);
    break;
    
    case 2:
    image(life,10,10);image(life,81,10);
    break;
      
    case 1:
    image(life,10,10);
    break;
      
    case 0:
    gameState=GAME_LOSE;
    break;
    }
}
    

//key control
void keyPressed(){
  if (key == CODED) {
    switch (keyCode) {

      case DOWN:
      hogY += hogSpeed;
      break;
      
      case LEFT:
      hogX -= hogSpeed;
      break;
      
      case RIGHT:
      hogX += hogSpeed;
      break;
    }
  }
}
