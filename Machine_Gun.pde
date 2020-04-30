public class Machine_Gun extends Weapon{
  private float x;
  private float y;
  private float w;
  private float h;
  private boolean doneFire;
  private PImage sprite;
  Machine_Gun(PImage model){
    super(model);
  }
  public void spawn(){
    x = width*.5 - getSprite().width*(12/25) + mouseX/10 - width*.5*.1;
    y = height*.5 - getSprite().height/2+mouseY/10;
    w = width*.15625;
    h = width*.18125;
    frame = 1;
    fire = false;
    doneFire = false;
    sprite = getSprite();
    imageMode(CENTER);
    image(sprite, x, y, width*.15625, width*.18125);
  }
  public void update(){
    x = width*.5 + mouseX/10 - width*.5*.1;
    y = height - width*.090625+mouseY/10;
    fireAnimation();
    imageMode(CENTER);
    image(sprite, x, y, w, h);
  }
  public void fire(){
    if(!playerMachineGun.isPlaying() && mousePressed){
      frame = 1;
      doneFire = false;
      fire = true;
      playerMachineGun = minim.loadFile("Sounds/Machine_Gun.mp3",2048);
      playerMachineGun.play();
    }
  }
  public void fireAnimation(){
    if(fire){
      if(frame<=1){
        x = x+width*.05;
        w = w*1.75;
        h = w*1.16;
        sprite = Machine_Gun_Fire_Frame_One;
        frame++;
        if(frame>=1){
          doneFire = true;
        }
      }
      else if(frame<=2){
        w = width*.15625;
        h = width*.18125;
        sprite = Machine_Gun_Fire_Frame_Two;
        frame++;
      }
      else if(frame<=3){
        sprite = Machine_Gun_Fire_Frame_Three;
        frame++;
        if(frame>=3){
          fire=false;
          frame = 1;
          sprite = Machine_Gun_Raised_Pre_Fire;
        }
      }
    }
  }
}