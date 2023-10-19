Walker[] bob;
void setup() {
 size(500,500);
 noStroke();
 bob = new Walker[1000];
  for (int i = 0; i < bob.length; i++) {
   bob[i] = new Walker();
 }
}

boolean foodPlaced = false;
boolean flee = false;
int foodX, foodY, foodTimer;

void draw() {
 background(0);
 for (int i = 0; i < bob.length; i++) {
   bob[i].show();
   if(flee) bob[i].flee();
   else bob[i].walk();
 }
 if (foodPlaced) {
   fill(255);
   ellipse(foodX,foodY,foodTimer*50/1000.0,foodTimer*50/1000.0);
 }
 if(foodTimer <= 0) foodPlaced = false;
 int bobsAround = 0;
 for(int i = 0; i < bob.length; i++) if (dist(bob[i].myX,bob[i].myY,foodX,foodY) < 25 && foodPlaced) bobsAround++;
 foodTimer-=bobsAround/10+1;
}

void mousePressed() {
  if (mouseButton == LEFT) {
    foodPlaced = false;
    flee = true;
    for (int i = 0; i < bob.length; i++) {
     }
  }
  else if (mouseButton == RIGHT) {
    flee = false;
    foodPlaced = true;
    if (foodPlaced) {
      foodX = mouseX;
      foodY = mouseY;
    }
    foodTimer = 1000;
  }
}

class Walker {
 int myX, myY;
 color myColor;
 Walker() {
  //myX = (int)(Math.random()*250)+125; 
  //myY = (int)(Math.random()*250)+125; 
  myX = (int)(Math.random()*500);
  myY = (int)(Math.random()*500);
  myColor = color((int)(Math.random()*256),(int)(Math.random()*256),(int)(Math.random()*256));
 }
 void walk() {
   if(foodPlaced) {
      myX += (int)(Math.random()*7)-3+xFoodOffset(myX);
      myY += (int)(Math.random()*7)-3+yFoodOffset(myY);
   }
   else {
      myX += (int)(Math.random()*7)-3;
      myY += (int)(Math.random()*7)-3;
   } 
 }
 void flee() {
   myX += (int)(Math.random()*7)-3-xOffset(myX);
   myY += (int)(Math.random()*7)-3-yOffset(myY);
 }
 void randomColor() {
  myColor = color((int)(Math.random()*256),(int)(Math.random()*256),(int)(Math.random()*256));
 }
 void show() {
  fill(myColor);
  ellipse(myX,myY,10,10); 
 }
}

int xOffset(int xpos) {
  if (mouseX > xpos) return 1;
  else if (mouseX < xpos) return -1;
  else return 0;
}
int yOffset(int ypos) {
  if (mouseY > ypos) return 1;
  else if (mouseY < ypos) return -1;
  else return 0;
}
int xFoodOffset(int xpos) {
  if (foodX > xpos+50) return 2;
  else if (foodX < xpos-50) return -2;
  else if (foodX > xpos+25) return 1;
  else if (foodX < xpos-25) return -1;
  else return 0;
}
int yFoodOffset(int ypos) {
  if (foodY > ypos+50) return 2;
  else if (foodY < ypos-50) return -2;
  else if (foodY > ypos+25) return 1;
  else if (foodY < ypos-25) return -1;
  else return 0;
}
