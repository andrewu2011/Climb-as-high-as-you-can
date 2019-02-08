//Final project/Yujing Andrew Wu 
// Game name is Climb as you can
// Control: Use mouse to select options and use arrow key 'up' 'left' and 'right' to control charectar 


// Credit: With the help of TA and classmates, I created this program. Some of the ideas come from them but I wrote the whole code

// I create 6 classes, the main classes are Bars and Tom.  

// the Tricky part of this game is the logic part. I used boolean to control the page change and use a lot boolean to
// control the interection.

// Music part, I input 3 different music into the code, a background music, a fail music and a buttonMusic. 
// And I also use a lot of photoes input in the game to make it nice to play.
// Difficult part, Jump function and intersect function.  






// import music 
import ddf.minim.* ;

Minim minim;
AudioPlayer song;
AudioPlayer buttonClick;
AudioPlayer failMusic;

int fakeTimer = 0; 
boolean gameOver = false;
boolean introduction = true; 

boolean ifGuide = false ;


IntroductionPage introductionPage ;
EndPage endPage;
Tom tom ;
Guide guide;
AddPoint addPoint ;
Bars[] bars = new Bars[1]; 
PImage backgroundPhoto;


void setup () {
     
    size (800,800); 
  // background(backgroundPhoto);
  // initialte the objects 
    tom = new Tom(450,800); 
    bars[0] = new Bars(0,0,int(random(50,300))); 
    introductionPage = new IntroductionPage();
    endPage = new EndPage();
    addPoint = new AddPoint();
    guide = new Guide();   
    minim = new Minim(this);
    song = minim.loadFile("backgroundMusic.mp3");
  
    song.play();
    song.loop();
    
    buttonClick = minim.loadFile("buttonClick.mp3");
    failMusic = minim.loadFile("failMusic.mp3");
    
  }  // end of setup 


void draw() {
 
   backgroundPhoto = loadImage("3.jpg");
   backgroundPhoto.resize(width, height);

  if(introduction == true) {  // introduction page introduce
    
    introductionPage.display();
  
  
  } else if ( introduction == false ) {
    if (gameOver == false) {
    
     
    // image(backgroundPhoto,0,0);
    background(backgroundPhoto);  // ****** Main Game  
     stroke(1);
     fill(230);
     strokeWeight(1);
     for(int i= 0 ; i< width; i = i+30) {
     triangle(0+i,0,15+i,15,30+i,0);
     } // loop for the down trap 
       for(int i= 0 ; i< width; i = i+30) {
     triangle(0+i,800,15+i,785,30+i,800);
     } // loop for the upper trap 
     
     tom.move() ;
     tom.display () ; 
     
     
     for (int i =0 ; i < bars.length ; i++ ) {   // bar created with the time passed 
     bars[i].display() ; 
     bars[i].move() ;
     } 
     fakeTimer ++ ; 
     if (fakeTimer %45 == 0)  {
     Bars extra_bars = new Bars (random(0, width-50), 0 , random(100,300));
     bars = (Bars[]) append (bars, extra_bars); 
     }

     tom.ifIntersect();      
     addPoint.ifPoint();
     addPoint.display();
    
    
    if (tom.ifDead()== true) {
      gameOver = true ;
      if (bars.length >0) {
    for(int i =0 ; i <= bars.length; i ++) {
     bars = (Bars[]) shorten(bars);
     }  
      }  //  resetthe bars 
    
     } // ***** end of Main Game 
    } // end of if gameover 
  }   // end of introduction 
  
  
  if( ifGuide == true)  { // show the guide page  
  guide.display();
  }  

  if (gameOver == true) {
    endPage.drawPoint();
  }   // end of gameOver 
  
  
} // end of draw


void mousePressed() {
  
    if( ifGuide == true)  {  // back to main page in guide page
   
   guide.display();
   
   if (mouseX >=100 && mouseX <=200 && mouseY >= 600 && mouseY <=650){
     buttonClick.rewind();
      buttonClick.play();
     ifGuide = false ;
   }
   }
  

if (introduction == true) {
 if( mouseX >=600 && mouseX <=700 && mouseY >= 100 && mouseY <=150) {
   
  buttonClick.rewind();
  buttonClick.play();
  
 introduction = false ;
    
 }  
 
 if( mouseX >=600 && mouseX <=700 && mouseY >= 200 && mouseY <=250){
  exit();
  }
  
  if( mouseX >=600 && mouseX <=700 && mouseY >= 300 && mouseY <=350){
   buttonClick.rewind();
   buttonClick.play();
   ifGuide = true ;
  }
 
 
  failMusic = minim.loadFile("failMusic.mp3");  // revalue the end music when restart the game
}  // end of if (introduction)
  
if(gameOver == true) {
  
   
  // Go back to Introduction page and restart the game 
 if( mouseX >=300 && mouseX <=480 && mouseY >= 320 && mouseY <=370) {
   buttonClick.rewind();
   buttonClick.play();
    song = minim.loadFile("backgroundMusic.mp3");
    song.play();
    failMusic.close();  
 
  introduction = true ;
   gameOver = false;
   Bars[] bars = new Bars[1]; 
    tom = new Tom(450,800); 
    bars[0] = new Bars(0,0,int(random(50,300))); 
    introductionPage = new IntroductionPage();
    endPage = new EndPage();
    addPoint.point = 0; 
   
  
 } else if (mouseX >=300 && mouseX <=480 && mouseY >= 420 && mouseY <=470) {  // exit the game in the end page
   buttonClick.rewind();
   buttonClick.play();
   
   exit();
 }
  
} // end of game over   
  

} // end of mousePressed 