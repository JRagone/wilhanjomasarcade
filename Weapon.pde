public class Weapon {
  protected int frame;
  protected boolean fire = false;
  protected boolean doneFire = false;
  private PImage sprite;
  Weapon(PImage model){
    sprite = model;
    spawn();
  }
  public void spawn(){
    //Choose position for spawnpoint
  }
  public void update(){
    //Redraw the weapon
  }
  public void  fire(){
    fire = true;
    //Set's up for fireAnimation
  }
  public void fireAnimation(){
    //Animation when gun is fired
  }
  public PImage getSprite(){
    return sprite;
  }
  public boolean getFire(){
    return fire;
  }
  public boolean getDoneFire(){
    return doneFire;
  }
}