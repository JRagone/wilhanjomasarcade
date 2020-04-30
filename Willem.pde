
public class Willem {
  
  playerBlock bob = new playerBlock();
  ball jill = new ball();
  opponentBlock bill = new opponentBlock();
  
  boolean startScreen = true;
  
  //Start Screen Variables
  float titleSize;
  String title = "PONG";
  float titleX;
  float titleY;
  String easy = "Easy";
  float easyY;
  String medium = "Medium";
  float mediumY;
  String hard = "Hard";
  float hardY;
  String impossible = "Literally Impossible";
  float impossibleY;
  boolean easyMode = false;
  boolean mediumMode = false;
  boolean hardMode = false;
  boolean impossibleMode = false;
  boolean pongemStart=true;
  
  //playerBlock Variables
  float pBlockX;
  float pBlockY;
  float pBlockW;
  float pBlockH;
  float pBlockV;
  
  //ball Variables
  float bX;
  float bY;
  float bR;
  float bInitialV;
  float bXV;
  float bYV;
  
  //opponentBlock Variables
  float oBlockX;
  float oBlockY;
  float oBlockW;
  float oBlockH;
  float oBlockV;
  
  int pScore = 0;
  int oScore = 0;
  
  //Audio
  AudioPlayer paddle;
  AudioPlayer wall;
  AudioPlayer bounds;
  
  void setupWillem(){
   
  }
  
  void resetMode(){
    easyMode = false;
    mediumMode = false;
    hardMode = false;
    impossibleMode = false;
  }
  
  void drawWillem(){
    background(0);
    if(startScreen){
      titleSize = width*.06;
      textSize(titleSize);
      textAlign(CENTER);
      titleX = width*.5;
      titleY = height*.1;
      easyY = titleY*3;
      mediumY = titleY*4.2;
      hardY = titleY*5.4;
      impossibleY = titleY*6.6;
      text(title, titleX, titleY);
      if(mouseY>easyY-titleSize*.75 && mouseY<easyY){
        fill(188, 188, 188);
        text(easy, titleX, easyY);
        fill(255, 255, 255);
        text(medium, titleX, mediumY);
        text(hard, titleX, hardY);
        text(impossible, titleX, impossibleY);
      }
      else if(mouseY>mediumY-titleSize*.75 && mouseY<mediumY){
        fill(188, 188, 188);
        text(medium, titleX, mediumY);
        fill(255, 255, 255);
        text(easy, titleX, easyY);
        text(hard, titleX, hardY);
        text(impossible, titleX, impossibleY);
      }
      else if(mouseY>hardY-titleSize*.75 && mouseY<hardY){
        fill(188, 188, 188);
        text(hard, titleX, hardY);
        fill(255, 255, 255);
        text(easy, titleX, easyY);
        text(medium, titleX, mediumY);
        text(impossible, titleX, impossibleY);
      }
      else if(mouseY>impossibleY-titleSize*.75 && mouseY<impossibleY){
        fill(188, 188, 188);
        text(impossible, titleX, impossibleY);
        fill(255, 255, 255);
        text(easy, titleX, easyY);
        text(medium, titleX, mediumY);
        text(hard, titleX, hardY);
      }
      else{
        text(easy, titleX, easyY);
        text(medium, titleX, mediumY);
        text(hard, titleX, hardY);
        text(impossible, titleX, impossibleY);
      }
      
      if(mousePressed){
        if(mouseY>easyY-titleSize*.75 && mouseY<easyY){
          startScreen = false;
          easyMode = true;
          //oBlockV = 2;
        }
        else if(mouseY>mediumY-titleSize*.75 && mouseY<mediumY){
          startScreen = false;
          mediumMode = true;
          //oBlockV = 5;
        }
        else if(mouseY>hardY-titleSize*.75 && mouseY<hardY){
          startScreen = false;
          hardMode = true;
          //oBlockV = 8;
        }
        else if(mouseY>impossibleY-titleSize*.75 && mouseY<impossibleY){
          startScreen = false;
          //oBlockV = 1;
          impossibleMode = true;
        }
      }
    }
    else if(pScore>=10){
      resetMode();
      titleSize = width*.04;
      textSize(titleSize);
      text("Congratulations! You have bested the machine!", titleX, titleY);
      if(mousePressed){
        stage=0;
        tennisGod.pause();
        surface.setSize(displayWidth, displayHeight);
        arcadeScreen.loop();
         rectMode(CORNER);
        if(mouseY>hardY-titleSize/2 && mouseY<hardY+titleSize/2){
            text("Loading...", titleX, hardY);
            pScore = 0;
            oScore = 0;
            startScreen = true;
            delay(3000);
        }
      }
      else{
        text("Click here to return to the title Screen", titleX, hardY);
      }
    }
    else if(oScore>=10){
      resetMode();
      text("Alas! You have been bested!", titleX, titleY);
      titleSize = width*.04;
      textSize(titleSize);
      if(mousePressed){
        stage=0;
        tennisGod.pause();
        surface.setSize(displayWidth, displayHeight);
        arcadeScreen.loop();
        rectMode(CORNER);
        if(mouseY>hardY-titleSize/2 && mouseY<hardY+titleSize/2){
          text("Loading...", titleX, hardY);
          oScore = 0;
          pScore = 0;
          startScreen = true;
          delay(3000);
        }
      }
      else{
        text("Click here to return to the title Screen", titleX, hardY);
      }
    }
    else if(!startScreen && oScore<10 && pScore<10){
      bob.creation();
      bob.move();
      jill.creation();
      jill.move();
      bill.creation();
      bill.move();
      textSize(titleSize);
      text(pScore, width*.5+titleSize, height*.1);
      text(oScore, width*.5-titleSize, height*.1);
    }
  }
  
  class playerBlock {
    
    boolean start = true;
    
    playerBlock(){
    }
    
    void creation(){
      if(start){
        pBlockX = width - width*.05;
        pBlockY = height*.5;
        pBlockW = width*.02;
        pBlockH = height*.15;
        pBlockV = height*.015;
        start = false;
      }
      rectMode(CENTER);
      rect(pBlockX, pBlockY, pBlockW, pBlockH);
    }
    
    void move(){
      if(keyPressed){
        if(keyCode == UP && pBlockY-pBlockH/2>0){
          pBlockY-=height*.015;
        }
        if(keyCode == DOWN && pBlockY+pBlockH/2<height){
          pBlockY+=height*.015;
        }
      }
    }
    
  }
  
  class ball {
    
    boolean start = true;
    
    ball(){
    }
    
    void creation(){
      if(start){
        bX = width*.5;
        bY = height*.5;
        bR = width*.03;
        bInitialV = height*.004;
        bXV = bInitialV;
        bYV = bInitialV;
        start = false;
      }
      ellipse(bX, bY, bR, bR);
    }
    
    void move(){
      if(bX-bR/2<=oBlockX+oBlockW/2 && bY+bR/2<=oBlockY+oBlockH/2 && bY-bR/2>=oBlockY-oBlockH/2){
        bXV +=width*.001;
        bXV = -bXV;
        paddle = minim.loadFile("Sounds/PongPaddle.mp3");
        paddle.play();
      }
      if(bX<=0){
        bounds = minim.loadFile("Sounds/PongBounds.mp3");
        bounds.play();
        reset();
        pScore+=1;
      }
      if(bX+bR/2>=pBlockX-pBlockW/2 && bY+bR/2<=pBlockY+pBlockH/2 && bY-bR/2>=pBlockY-pBlockH/2){
        bXV-=width*.001;
        bXV = -bXV;
        paddle = minim.loadFile("Sounds/PongPaddle.mp3");
        paddle.play();
      }
      if(bX>=width){
        bounds = minim.loadFile("Sounds/PongBounds.mp3");
        bounds.play();
        reset();
        oScore+=1;
      }
      if(bY+bR/2>=height){
        bYV +=height*.0005;
        bYV = -bYV;
        wall = minim.loadFile("Sounds/PongWall.mp3");
        wall.play();
      }
      if(bY-bR/2<=0){
        bYV-=height*.0005;
        bYV = -bYV;
        wall = minim.loadFile("Sounds/PongWall.mp3");
        wall.play();
      }
      bX-=bXV;
      bY+=bYV;
    }
    
    void reset(){
      bX = width*.5;
      bY = height*.5;
      if(bXV>0){
        bXV = random(-bInitialV, -bInitialV-3);
      }
      else{
        bXV = random(bInitialV, bInitialV+3);
      }
      if(bYV>0){
        bYV = random(-bInitialV, -bInitialV-3);
      }
      else{
        bYV = random(bInitialV, bInitialV+3);
      }
    }
  }
  
  class opponentBlock {
    boolean start = true;
    
    opponentBlock(){
    }
    
    void creation(){
      if(start){
        oBlockX = width*.05;
        oBlockY = height*.5;
        oBlockW = width*.02;
        oBlockH = height*.15;
        if(easyMode){
          oBlockV = pBlockV*.3;
        }
        if(mediumMode){
          oBlockV = pBlockV*.5;
        }
        if(hardMode){
          oBlockV = pBlockV*.8;
        }
        if(impossibleMode){
          oBlockV = 1;
        }
        start = false;
      }
      rectMode(CENTER);
      rect(oBlockX, oBlockY, oBlockW, oBlockH);
    }
    
    void move(){
      if(impossibleMode){
        while(oBlockY<bY && oBlockY+oBlockH/2<=height){
          oBlockY+=oBlockV;
        }
        while(oBlockY>bY && oBlockY-oBlockH/2>=0){
          oBlockY-=oBlockV;
        }
      }
      else{
        if(oBlockY<bY && oBlockY+oBlockH/2<=height){
          oBlockY+=oBlockV;
        }
        if(oBlockY>bY && oBlockY-oBlockH/2>=0){
          oBlockY-=oBlockV;
        }
      }
    }
  }
  
}