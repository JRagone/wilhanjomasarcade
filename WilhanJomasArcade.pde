import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

PImage joystick_Center;
PImage joystick_Left;
PImage joystick_Right;
PImage stick;
PImage shooterIcon;
private int stickPos;
private int select;
private float x;
private float opacity;
private float titleY;
int stage=0;
PFont mainFont;
AudioPlayer arcadeScreen;
AudioPlayer file;
AudioPlayer tennisGod;
Minim backgroundTunes;

Thomas thomasGame;
Willem willemGame;
boolean johnStart = true;

void settings() {
  if(stage==0){
  fullScreen();  
  }
}

void setup(){
  willemGame = new Willem();
  willemGame.setupWillem();
  thomasGame = new Thomas();
  thomasGame.setupThomas();
  setupJohan();
  x=width*.5;
  stickPos=-1;
  select=0;
  stage=0;
  opacity = 0;
  titleY = height*.5;
  mainFont = createFont("ARCADE_I.TTF", 60);
  textFont(mainFont);
  joystick_Center = loadImage("Joystick_Center.png");
  joystick_Right = loadImage("Joystick_Right.png");
  joystick_Left = loadImage("Joystick_Left.png");
  stick=loadImage("Joystick_Center.png");
  file = minim.loadFile("Tron-Legacy-Soundtrack-OST-21-TRON-Legacy-End-Titles-Da.mp3");
  tennisGod=minim.loadFile("superSaiyan.mp3");
  arcadeScreen=minim.loadFile("macintoshplus.mp3");
  arcadeScreen.loop();
  playerMachineGun = minim.loadFile("Sounds/Machine_Gun.mp3",2048);
  //shooterIcon=loadImage("shooterIcon.png");
  backgroundTunes = new Minim(this);
  }
 
  

  
  


void draw() {
  if(stage==0){
    select=0;
    strokeWeight(4);
    smooth();
    surface.setSize(displayWidth, displayHeight);
    textFont(mainFont);
    background(0);
    fill(255);
    textSize(width*.023438);
    if(millis()>5000 && titleY>height/4){
      titleY-= height*.001;
      opacity++;
    }
    text("WilhanJomas Arcade 2000: Electric Boogaloo", width/2, titleY);
    //image(shooterIcon,300,305,250,200);
    textSize(width*.015625);
    fill(255,0,0,select);
    stroke(255, 0, 0, opacity);
    if (stickPos==-1) {
      rect(.139*width,.565*height,width*.22,height*.05); 
    }
    if(stickPos==0){
      rect(.389*width,.565*height,width*.22,height*.05);
    }
    if (stickPos==1) {
      rect(.639*width,.565*height,width*.22,height*.05);
    }
    fill(255, 255, 255, opacity);
    text("WWII Shooter", width/4, .6*height);
    text("Pong Adventure",width/2,.6*height);
    text("Light Cycle",.75*width, .6*height);
    image(stick,x,height*.65+titleY,height*.2,height*.2);
  }
  if(stage==1) {
    if(johnStart){
      johnStart=false;
      arcadeScreen.pause();
      funkThat.loop();
    }
    strokeWeight(1);
    stroke(0,0,0);
    fullScreen();
    textFont(main);
    textSize(width*.0390625);
    drawJohan();
  }
  if(stage==2){
      if(willemGame.pongemStart){
        willemGame.pongemStart=false;
        arcadeScreen.pause();
        tennisGod.loop();
      }
      textFont(main);
      stroke(0,0,0);
      surface.setSize(displayWidth, displayHeight);
      willemGame.drawWillem();
  }
  if(stage==3){
    textFont(main);
    if(thomasGame.start){
      thomasGame.start = false;
      arcadeScreen.pause();
      file.loop(); 
    }
    surface.setSize(500,600);
    thomasGame.drawThomas();
  }
}


void keyPressed() {
  
  if(stage==0) {
    keyPressedMenu();
  }
  
  if(stage==1){
    keyPressedJohan();
  }
  
}

void keyPressedMenu() {
  if(stage==0) {
  if(keyCode==LEFT) {
    stick = joystick_Left;
    x=width*.47;
    stickPos=stickPos-1;
    if(stickPos==-2) {
      stickPos=-1;
    }
  }
  
  if(keyCode==RIGHT) {
     stick = joystick_Right;
     x=width*.53;
     stickPos=stickPos+1;
     if (stickPos==2) {
       stickPos=1;
     }
  }
  if(keyCode==ENTER) {
    select=100;
    if(stickPos==-1){
    stage=1;
    }
    if(stickPos==0){
      stage=2;
    }
    if(stickPos==1){
     stage=3;
    }
  }
  }
  
  
}


 void keyReleased() {
   if(stage==0){
   stick = joystick_Center;
   x=width*.5;
   select=0; 
   }
   if(stage==3){
   }
 }


void mousePressed() {
  if(stage==1){
    //johanGame.mousePressedJohan();
    mousePressedJohan();
  }
  if(stage==3){
      thomasGame.mousePressedThomas();
    }
  }
 
 
 
void mouseClicked(){
  if(stage==1){
    mouseClickedJohan();
    }
  if(stage==3){
    thomasGame.mousePressedThomas();
  }
}