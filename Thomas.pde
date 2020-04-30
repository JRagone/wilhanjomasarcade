
public class Thomas {

private int x = 10;
private int y = 250;
private int hdirection = RIGHT;
private int lives=5;
private int complives=5;
private int cx = 490;
private int cy = 250;
private int cdirection = LEFT;
private boolean start = true;
AList<PVector>trial = new AList<PVector>();


void setupThomas()
{
  background(0,0,0);
  fill(255);
  smooth();
  frameRate(100);
  keyCode = RIGHT;
}
//drawmethod
void drawThomas()
  {
    fill(255,255,255);
    rect(0,500,500,100);
    textSize(20);
    fill(0,0,0);
    text("User: "+lives,50,560);
    text("Computer: "+complives,350,560);
     if(complives==0)// the if statement for the user win
     {
      fill(255,0,0);
      textSize(64);
      textAlign(CENTER);
      text("YOU WIN",250,175);
      fill(255,255,255);
      textSize(20);
      textAlign(CENTER);
      text("CLICK TO RETURN TO THE MAIN MENU",250,450);
    
     }
     if(lives==0)//the if statement for the user lose
     {
      fill(255,0,0);
      textSize(64);
      textAlign(CENTER);
      text("YOU LOST",250,175);
      fill(255,255,255);
      textSize(20);
      textAlign(CENTER);
      text("CLICK TO RETURN TO THE MAIN MENU",250,450);
    
     }
    
    else
      {
        trial.append(new PVector(x,y));
        trial.append(new PVector(cx,cy));
        h();
        c();
      }
  }
  
  
void mousePressedThomas()//go back to the main menu
{
  if(lives<=0||complives<=0){
    stage=0;
    file.pause();
    arcadeScreen.loop();
    lives=5;
    complives=5;
   }
}
void gameOveruser()//gameoverfor user
    {
      trial.clear();
      lives--;
      background(0);
      keyCode = RIGHT;
      x = 10;
      y = 250;
      cx = 490;
      cy = 250;
    }
void gameOvercomp()//game over for computer
    {
      trial.clear();
      complives--;
      background(0);
      keyCode = RIGHT;
      x = 10;
      y = 250;
      cx = 490;
      cy = 250;
      
    }



void h()// method for the user
{
  

    stroke(51,255,255);
    strokeWeight(4);
    point(x,y);
    
    if(keyCode == RIGHT)
    {
      hdirection = RIGHT;
      x++;
    }
    else if(keyCode == UP)
    {
      hdirection = UP;
      
      y--;
      
    }
    else if(keyCode == DOWN)
    {
      hdirection = DOWN;
      y++;
    }
    else if(keyCode == LEFT)
    {
      if(hdirection!=RIGHT){
      hdirection = LEFT;
      x--;
      }
    }
    
    if(x>500||y>500||x<0||y<0)
    {
     gameOveruser();
    }
    
    
    for( int i=0; i<trial.length();i++)
    {
    trial.moveToPos(i);
    PVector k = trial.getValue();
    if(x==(int)k.x&&y==(int)k.y)
    {
    gameOveruser();
   
    }
    }
    
  
}

void c()//method for computer
{
    stroke(255,128,0);
    point(cx,cy);
    if(cdirection == LEFT)
    {
      cx--;
      if(get(cx-4,cy) != color(0,0,0))
      {
      if(random(1)>0.25)
       cdirection=DOWN;
       else
       cdirection=UP;
      }
    }
    else if(cdirection == RIGHT)
    {
      cx++;
      if(get(cx+4,cy) != color(0,0,0))
      {
      if(random(1)>0.5)
       cdirection=DOWN;
       else
       cdirection=UP;
      }
    }
    else if(cdirection == DOWN)
    {
      cy++;
      if(get(cx,cy+4) != color(0,0,0))
      {
      if(random(1)>0.5)
       cdirection=LEFT;
       else
       cdirection=RIGHT;
      }
    }
    else if(cdirection == UP)
    {
      cy--;
      if(get(cx,cy-4) != color(0,0,0))
      {
      if(random(1)>0.5)
       cdirection=LEFT;
       else
       cdirection=RIGHT;
      }
    }
    
    if(cx>496)
    {
      cdirection = UP;
    }
    if(cx<5)
    {
      cdirection = DOWN;
    }
    if(cy>496)
    {
      cdirection = RIGHT;
    }
    if(cy<4)
    {
      cdirection = LEFT;
    }
    
    if(cx>500||cy>500||cx<0||cy<0)
    {
      gameOvercomp();
    }
   
     for( int i=0; i<trial.length();i++)
    {
    trial.moveToPos(i);
    PVector k = trial.getValue();
    if(cx==(int)k.x&&cy==(int)k.y){
    gameOvercomp();
    }
    }
}
}