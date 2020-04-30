public class Pistol extends Weapon{
  private float x;
  private float y;
  private int frame;
  private boolean fire;
  private PImage sprite;
  Pistol(PImage model){
    super(model);
  }
  public void spawn(){
    x = width*.5 - getSprite().width*(12/25) + mouseX/10 - width*.5*.1;
    y = height*.5 - getSprite().height/2+mouseY/10;
    frame = 1;
    doneFire = true;
    fire = false;
    sprite = getSprite();
    imageMode(CENTER);
    image(sprite, x, y, width*.15625, width*.18125);
  }
  public void update(){
    fire();
    fireAnimation();
    x = width*.5 + mouseX/10 - width*.5*.1;
    y = height - width*.090625+mouseY/10;
    imageMode(CENTER);
    image(sprite, x, y, width*.15625, width*.18125);
  }
  public void fire(){
    if(!playerPistol.isPlaying() && mousePressed){
      frame = 1;
      doneFire = false;
      fire = true;
      playerPistol = minim.loadFile("Sounds/Pistol.mp3",2048);
      playerPistol.play();
    }
  }
  public void fireAnimation(){
    if(fire){
      if(frame<=3){
        sprite = Gun_Raised_Fire_Frame_One;
        frame++;
        if(frame>=3){
          doneFire = true;
        }
      }
      else if(frame<=4){
        sprite = Gun_Raised_Fire_Frame_Two;
        frame++;
      }
      else if(frame<=7){
        sprite = Gun_Raised_Fire_Frame_Three;
        frame++;
        if(frame>=8){
          fire=false;
          frame = 1;
          sprite = Gun_Raised_Pre_Fire;
        }
      }
    }
  }
}