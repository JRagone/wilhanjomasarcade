

import ddf.minim.*;

int pts = 0;

//Gun Sprites
  //Pistol
    PImage Gun_Raised_Pre_Fire;
    PImage Gun_Raised_Fire_Frame_One;
    PImage Gun_Raised_Fire_Frame_Two;
    PImage Gun_Raised_Fire_Frame_Three;
  //Machine_Gun
    PImage Machine_Gun_Raised_Pre_Fire;
    PImage Machine_Gun_Fire_Frame_One;
    PImage Machine_Gun_Fire_Frame_Two;
    PImage Machine_Gun_Fire_Frame_Three;
//Zombie Sprites
PImage Guard_Standing_Front;
PImage Guard_Shot_Alive;
PImage Guard_Shot_Frame_One;
PImage Guard_Shot_Frame_Two;
PImage Guard_Shot_Frame_Three;
PImage Guard_Shot_Frame_Four;
PImage Guard_Shot_Frame_Five;
PImage Guard_Run_Frame_One;
PImage Guard_Run_Frame_Two;
PImage Guard_Run_Frame_Three;
PImage Guard_Run_Frame_Four;
PImage Guard_Attack_Frame_One;
PImage Guard_Attack_Frame_Two;
PImage Guard_Attack_Frame_Three;
//Store Sprites
PImage Ammo_Store;
PImage Machine_Gun_Store;
PImage Gatling_Gun_Store;
//Game Over Image
PImage freezeFrame;

Zombie bob;
Player player;
Wave waveOne;
Wave waveTwo;
Wave waveThree;
Wave waveFour;
Wave waveFive;
Store store;

//Fonts
PFont main;

//Sound
AudioPlayer playerPistol;
AudioPlayer playerMachineGun;
AudioPlayer guardPistol;
AudioPlayer funkThat;
Minim minim;

void settingsJohan(){
  fullScreen();
}

void setupJohan() {
  minim = new Minim(this);
  //Load Gun Sprites
    //Pistol
      Gun_Raised_Pre_Fire = loadImage("Sprites/Gun_Raised_Pre_Fire.png");
      Gun_Raised_Fire_Frame_One = loadImage("Sprites/Gun_Raised_Fire_Frame_One.png");
      Gun_Raised_Fire_Frame_Two = loadImage("Sprites/Gun_Raised_Fire_Frame_Two.png");
      Gun_Raised_Fire_Frame_Three = loadImage("Sprites/Gun_Raised_Fire_Frame_Three.png");
    //Machine_Gun
      Machine_Gun_Raised_Pre_Fire = loadImage("Sprites/Machine_Gun_Raised_Pre_Fire.png");
      Machine_Gun_Fire_Frame_One = loadImage("Sprites/Machine_Gun_Fire_Frame_One.png");
      Machine_Gun_Fire_Frame_Two = loadImage("Sprites/Machine_Gun_Fire_Frame_Two.png");
      Machine_Gun_Fire_Frame_Three = loadImage("Sprites/Machine_Gun_Fire_Frame_Three.png");
  //Load Guard Sprites
    //Guard_Standing
      Guard_Standing_Front = loadImage("Sprites/Guard_Standing_Front.png");
    //Guard_Shot_Alive
      Guard_Shot_Alive = loadImage("Sprites/Guard_Shot_Alive.png");
    //Guard_Shot
      Guard_Shot_Frame_One = loadImage("Sprites/Guard_Shot_Frame_One.png");
      Guard_Shot_Frame_Two = loadImage("Sprites/Guard_Shot_Frame_Two.png");
      Guard_Shot_Frame_Three = loadImage("Sprites/Guard_Shot_Frame_Three.png");
      Guard_Shot_Frame_Four = loadImage("Sprites/Guard_Shot_Frame_Four.png");
      Guard_Shot_Frame_Five = loadImage("Sprites/Guard_Shot_Frame_Five.png");
    //Guard_Attack
      Guard_Attack_Frame_One = loadImage("Sprites/Guard_Attack_Frame_One.png");
      Guard_Attack_Frame_Two = loadImage("Sprites/Guard_Attack_Frame_Two.png");
      Guard_Attack_Frame_Three = loadImage("Sprites/Guard_Attack_Frame_Three.png");
    //Guard_Run
      Guard_Run_Frame_One = loadImage("Sprites/Guard_Run_Frame_One.png");
      Guard_Run_Frame_Two = loadImage("Sprites/Guard_Run_Frame_Two.png");
      Guard_Run_Frame_Three = loadImage("Sprites/Guard_Run_Frame_Three.png");
      Guard_Run_Frame_Four = loadImage("Sprites/Guard_Run_Frame_Four.png");
  //Load Store Sprites
    Ammo_Store = loadImage("Sprites/Ammo_Store.png");
    Machine_Gun_Store = loadImage("Sprites/Machine_Gun_Store.png");
    Gatling_Gun_Store = loadImage("Sprites/Gatling_Gun_Store.png");
  playerPistol = minim.loadFile("Sounds/Pistol.mp3",2048);
  playerMachineGun = minim.loadFile("Sounds/Machine_Gun.mp3",2048);
  guardPistol = minim.loadFile("Sounds/Guard_Pistol.mp3",2048);
  funkThat = minim.loadFile("Sounds/Funk_That.mp3",2048);
  funkThat.setGain(10);
  player = new Player();
  store = new Store();
  bob = new Zombie(Guard_Standing_Front, 2);
  waveOne = new Wave(10, 1, 1);
  waveTwo = new Wave(10, 2, 3);
  waveThree = new Wave(15, 1, 8);
  waveFour = new Wave(1, 1, 100);
  waveFive = new Wave(30, 1, 5);
  
  main = createFont("Sprites/pixelated.ttf", 12);
  textFont(main);
  textAlign(CENTER);
}

void drawJohan(){
  background(255);
  fill(220, 220, 220);
  quad(0, height, width*.47, height/2, width*.47, height*.3, 0, 0);
  quad(width, height, width*.53, height/2, width*.53, height*.3, width, 0);
  line(width*.47, height*.3, width*.53, height*.3);
  line(width*.47, height/2, width*.53, height/2);
  fill(0);
  imageMode(CENTER);
  //image(zombieSprite, width*.5, height*.5);
  //bob.update();
  if(waveFive.livingZombieList.listSize==0 && waveFive.allZombies.length()==0){
    image(freezeFrame, width*.5, height*.5);
    text("You have been killed!", width*.5, height*.07);
    text("Press either 'R' to retry or 'M' to return to the Main Menu", width*.5, height*.14);
  }
  if(player.victory){
    image(freezeFrame, width*.5, height*.5);
    text("You have survived!", width*.5, height*.07);
    text("Press either 'R' to retry or 'M' to return to the Main Menu", width*.5, height*.14);
  }
  else{
    if(waveFive.allZombies.length()==0){
      freezeFrame = get();
      player.victory = true;
    }
    else if(player.alive){
      if(waveFour.allZombies.length()==0){
        waveFive.update();
      }
      if(waveThree.allZombies.length()==0){
        waveFour.update();
      }
      if(waveTwo.allZombies.length()==0){
        waveThree.update();
      }
      if(waveOne.allZombies.length()==0){
        waveTwo.update();
      }
      waveOne.update();
      player.update();
      store.update();
    }
    else if(!player.alive){
      image(freezeFrame, width*.5, height*.5);
      text("You have been killed!", width*.5, height*.07);
      text("Press either 'R' to retry or 'M' to return to the Main Menu", width*.5, height*.14);
    }
  }
}

void mouseClickedJohan(){
  store.items.moveToStart();
  for(int i = 1; i<=store.items.cnt; i++){
    if(store.items.getValue().purchase()){
      store.buy = true;
    }
  }
}

void mousePressedJohan(){
  //bob.hitCheck();
  //player.fire();
  //waveOne.hitCheck();
}

void keyPressedJohan(){
  if(key=='b' || key=='B' && player.alive && !player.victory){
    waveOne.pause = !waveOne.pause;
    waveTwo.pause = !waveTwo.pause;
    waveThree.pause = !waveThree.pause;
    waveFour.pause = !waveFour.pause;
    waveFive.pause = !waveFive.pause;
    store.pause = !store.pause;
  }
  if((key=='r' || key=='R') && (!player.alive || player.victory)){
    player.reset();
    store.reset();
    waveOne.reset();
    waveTwo.reset();
    waveThree.reset();
    waveFour.reset();
    waveFive.reset();
  }
  if((key=='m' || key=='M') && (!player.alive || player.victory)){
    player.reset();
    store.reset();
    waveOne.reset();
    waveTwo.reset();
    waveThree.reset();
    waveFour.reset();
    waveFive.reset();
    stage=0;
    funkThat.pause();
    arcadeScreen.play();
  }
}