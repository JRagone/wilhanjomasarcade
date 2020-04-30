public class Zombie{
  //Position
  private int x;
  private float y;
  private int spriteWidth;
  private int spriteHeight;
  private float exponent;
  private int frame;
  private int startFrameRate;
  private int oldFrame;
  private int oldHeight;
  private int health;
  //State
  private boolean hit;
  private boolean alive;
  private boolean delete;
  private boolean attack;
  private boolean shooting;
  //Image
  private PImage sprite;
  Zombie(PImage model, int HEALTH){
    sprite = model;
    health = HEALTH;
    spawn();
  }
  public void spawn(){
    alive = true;
    delete = false;
    hit = false;
    shooting = false;
    x = Math.round(random(width*.47, width*.53));
    y = height*.45;
    exponent = 6.3;
    exponent = 6.3;
    spriteWidth = (int)Math.round(Math.pow(2, exponent));
    spriteHeight = spriteWidth*(24/11);
    frame = 1;
    startFrameRate = 60;
    image(sprite, x, y, spriteWidth, spriteHeight);
  }
  public void update(){
    if(!delete){
      if(!alive){
        dying();
      }
      else{
        if(hit){
          hit();
        }
        else if(attack){
          attacking();
        }
        else{
          move();
        }
      }
      imageMode(CENTER);
      image(sprite, x, y, spriteWidth, spriteHeight);
    }
  }
  public void move(){
    spriteWidth = (int)Math.round(Math.pow(2, exponent));
    if(frame<=startFrameRate/7.5){
      sprite = Guard_Run_Frame_One;
      spriteHeight = spriteWidth*(46/23);
    }
    else if(frame<=startFrameRate/7.5*2){
      sprite = Guard_Run_Frame_Two;
      spriteHeight = spriteWidth*(47/23);
    }
    else if(frame<=startFrameRate/7.5*3){
      sprite = Guard_Run_Frame_Three;
      spriteHeight = spriteWidth*(46/23);
    }
    else if(frame<=startFrameRate/7.5*4){
      sprite = Guard_Run_Frame_Four;
      spriteHeight = spriteWidth*(47/23);
      if(frame+1>=startFrameRate/7.5*4){
        frame = 1;
        startFrameRate = Math.round(frameRate);
      }
    }
    frame++;
    if(spriteHeight<height*.7){
      exponent+=(height*.000003472)/(frameRate/60);
      y+=(height*.00010416)/(frameRate/60);
    }
    else{
      attack = true;
      startFrameRate = Math.round(frameRate);
    }
    //spriteHeight = spriteWidth*(24/11);
  }
  public boolean hitCheck(){
    if(playerPistol.isPlaying() && !player.weapon.doneFire || playerMachineGun.isPlaying() && !player.weapon.doneFire){
      if(alive && mouseX<=x+spriteWidth/2 && mouseX>=x-spriteWidth/2 && mouseY<=y+spriteHeight/2 && mouseY>=y-spriteHeight/2){
        health--;
        if(health<=0){
          alive = false;
          player.money+=10;
          oldHeight = spriteHeight;
          frame = 1;
          startFrameRate = Math.round(frameRate);
          return true;
        }
        else{
          hit=true;
          oldFrame = frame;
          frame = 1;
          startFrameRate = Math.round(frameRate);
          return true;
        }
      }
    }
    return false;
  }
  public void hit(){
    if(frame<=startFrameRate/(60/4)){
      sprite = Guard_Shot_Alive;
      frame++;
    }
    else{
      hit = false;
      frame = oldFrame;
    }
  }
  public void dying(){
    if(frame<=startFrameRate/(30/2)){
      sprite = Guard_Shot_Frame_One;
      spriteHeight = spriteWidth*(48/26);
    }
    else if(frame<=startFrameRate/(30/6)){
      sprite = Guard_Shot_Frame_Two;
      spriteHeight = spriteWidth*(52/34);
      if(frame+1>=startFrameRate/(30/6)){
        y+=oldHeight*.06;
      }
    }
    else if(frame<=startFrameRate/(30/7)){
      sprite = Guard_Shot_Frame_Three;
      spriteHeight = spriteWidth*(49/37);
      if(frame+1>=startFrameRate/(30/7)){
        y+=oldHeight*.06;
      }
    }
    else if(frame<=startFrameRate/(30/8)){
      sprite = Guard_Shot_Frame_Four;
      spriteHeight = spriteWidth*(41/38);
      if(frame+1>=startFrameRate/(30/8)){
        y+=oldHeight*.06;
      }
    }
    else if(frame<=startFrameRate/6*10){
      sprite = Guard_Shot_Frame_Five;
      spriteHeight = spriteWidth;
      if(frame>=startFrameRate/6*10){
        delete = true;
        frame = 1;
      }
    }
    frame++;
  }
  public void attacking(){
    if(frame<=startFrameRate*(4/3)){
      sprite = Guard_Attack_Frame_One;
      spriteWidth = Math.round(spriteHeight*.583);
    }
    else if(frame<=startFrameRate*2){
      sprite = Guard_Attack_Frame_Two;
      if(frame+1>=startFrameRate*2){
        shooting = false;
      }
    }
    if(shooting==false){
      sprite = Guard_Attack_Frame_Three;
      shooting = true;
      guardPistol = minim.loadFile("Sounds/Guard_Pistol.mp3",2048);
      guardPistol.play();
      player.health--;
      startFrameRate = Math.round(frameRate);
      frame=startFrameRate*(4/3)+1;
    }
    frame++;
  }
}