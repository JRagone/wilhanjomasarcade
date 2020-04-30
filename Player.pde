public class Player{
  private int health;
  private int money;
  private boolean alive = true;
  private boolean victory = false;
  Weapon weapon;
  Player(){
    spawn();
  }
  public void spawn(){
    money = 0;
    health = 10;
    weapon = new Pistol(Gun_Raised_Pre_Fire);
  }
  public void update(){
    textSize(width*.0390625);
    text("$" + money, width*.1, height*.9);
    text("Health: " + health, width*.85, height*.9);
    if(health>0){
      fire();
      weapon.update();
    }
    else{
      alive = false;
      freezeFrame = get();
    }
  }
  public void fire(){
    weapon.fire();
  }
  public void reset(){
    victory = false;
    alive = true;
    money = 0;
    health = 10;
    weapon = new Pistol(Gun_Raised_Pre_Fire);
  }
}