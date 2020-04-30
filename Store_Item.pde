public class Store_Item{
  private int x;
  private int y;
  private float w;
  private float h;
  private int price;
  private boolean forSale;
  private PImage sprite;
  Store_Item(PImage SPRITE, int POSITION_X, int POSITION_Y, float WIDTH, float HW_RATIO, int PRICE, boolean FOR_SALE){
    sprite = SPRITE;
    x = POSITION_X;
    y = POSITION_Y;
    w = WIDTH;
    h = w*HW_RATIO;
    price = PRICE;
    forSale = FOR_SALE;
  }
  public void update(){
    imageMode(CENTER);
    image(sprite, x, y, w, h);
    textSize(width*.015625);
    text(price, x, height*.45);
  }
  public boolean purchase(){
    if(mouseX>=x - w/2 && mouseX<=x+w/2 && mouseY>=y-h/2 && mouseY<=y+h/2){
      return true;
    }
    return false;
  }
}