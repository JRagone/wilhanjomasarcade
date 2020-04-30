public class Store{
  private LList<Store_Item> items;
  private boolean buy;
  private boolean pause;
  Store(){
    spawn();
  }
  public void spawn(){
    pause = false;
    buy = false;
    items = new LList();
    //items.append(new Store_Item(Ammo_Store, Math.round(width*.32), Math.round(height*.3333333), width*.1, .666666, 20)); 
    items.append(new Store_Item(Machine_Gun_Store, Math.round(width*.25), Math.round(height*.3333333), width*.2, .37777, 100, true));
    items.append(new Store_Item(Gatling_Gun_Store, Math.round(width*.8), Math.round(height*.333333333), width*.25, .3448, 500, true));
  }
  public void update(){
    if(pause){
      textSize(width*.0390625);
      text("STORE", width*.5, height*.07);
      items.moveToStart();
      for(int i = 1; i<=items.cnt; i++){
        if(buy){
          buy();
        }
        items.getValue().update();
        items.next();
      }
    }
  }
  public void buy(){
    if(items.getValue().forSale && items.getValue().sprite==Machine_Gun_Store && player.money>=items.getValue().price){
      items.getValue().forSale=false;
      player.money-=items.getValue().price;
      player.weapon = new Machine_Gun(Machine_Gun_Raised_Pre_Fire);
      buy = false;
    }
  }
  public void reset(){
    items.clear();
    items.append(new Store_Item(Machine_Gun_Store, Math.round(width*.25), Math.round(height*.3333333), width*.2, .37777, 100, true));
    items.append(new Store_Item(Gatling_Gun_Store, Math.round(width*.8), Math.round(height*.333333333), width*.25, .3448, 500, true));
  }
}