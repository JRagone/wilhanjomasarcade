public class Wave{
  private int zombieCount;
  private int stagger;
  private int prevTime;
  private int zombieHealth;
  private boolean pause;
  private AQueue<Zombie> allZombies; //Data Structures
  private AList<Zombie> livingZombieList;
  Wave(int NUM_ZOMBIES, int SPAWN_STAGGER, int ZOMBIE_HEALTH){
    zombieCount = NUM_ZOMBIES;
    stagger = SPAWN_STAGGER * 45;
    zombieHealth = ZOMBIE_HEALTH;
    waveStart();
  }
  public void waveStart(){ //Called once at start
    prevTime = frameCount;
    livingZombieList = new AList(zombieCount);
    allZombies = new AQueue(zombieCount);
    pause = false;
    for(int i = 1; i<=zombieCount; i++){
      allZombies.enqueue(new Zombie(Guard_Standing_Front, zombieHealth));
    }
  }
  public void update(){ //Redraws
    if(frameRate<5){
      clearScreen();
    }
    if(!pause){
      if(allZombies.length()>0 && frameCount - prevTime>=stagger){
        livingZombieList.append(allZombies.dequeue());
        prevTime = frameCount;
      }
    }
    if(mousePressed){
      hitCheck();
    }
    livingZombieList.moveToEnd();
    livingZombieList.prev();
    for(int i = livingZombieList.length(); i>=1; i--){
      if(pause && !(livingZombieList.getValue().sprite==Guard_Shot_Frame_Five)){
        image(livingZombieList.getValue().sprite, livingZombieList.getValue().x, livingZombieList.getValue().y, livingZombieList.getValue().spriteWidth, livingZombieList.getValue().spriteHeight);
      }
      else{
        livingZombieList.getValue().update();
      }
      livingZombieList.prev();
    }
  }
  public void waveAppend(Zombie zombie){
    allZombies.enqueue(zombie);
  }
  public void hitCheck(){ //Iterates and checks
    if(!pause){
      livingZombieList.moveToStart();
      for(int i = 1; i<=livingZombieList.length(); i++){
        if(livingZombieList.getValue().hitCheck()){
          return;
        }
        livingZombieList.next();
      }
    }
  }
  public void clearScreen(){
    livingZombieList.clear();
  }
  public void reset(){
    allZombies.clear();
    livingZombieList.clear();
    for(int i = 1; i<=zombieCount; i++){
      allZombies.enqueue(new Zombie(Guard_Standing_Front, zombieHealth));
    }
  }
}