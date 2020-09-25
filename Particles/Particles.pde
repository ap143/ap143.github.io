Node[] l;
int n;
boolean locked = false;
float t = 1;

void setup(){
  size(700, 700);
  frameRate(100);
  n = 200;
  l = new Node[n];

  for (int i = 0; i < n; i++){
  	l[i] = new Node();
  }

}

void draw(){
	background(0);
	for (int i = 0; i < n; i++){
		l[i].draw();
	}

  if (locked){
    t += 0.01;
    for (int i = 0; i < n; i++){
      float len = dist(l[i].x, l[i].y, mouseX, mouseY)/100;
      if ((mouseX-l[i].x)*(l[i].vx)<=0){
        l[i].vx += (mouseX-l[i].x)/10;
      }
      if ((mouseY-l[i].y)*(l[i].vy)<=0){
        l[i].vy += (mouseY-l[i].y)/10;
      }
    }
    System.out.println(exp(-t));
  }else{
    for (int i = 0; i < n; i++){
      l[i].update();
    }
  }

}

void mousePressed(){
  locked = true;  
}

void mouseReleased(){
  locked = false;
  t = 1;
}
