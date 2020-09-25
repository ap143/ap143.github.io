class Node{
	float x, y;
	float r;
	color c;
	float vx, vy;

	Node(){
		x = random(0, width);
		y = random(0, height);
		r = random(1, 2);
		c = color(random(255), random(255), random(255));
		vx = random(-10, 10);
		vy = random(-10, 10);
	}

	void draw(){
		fill(c);
		noStroke();
		circle(this.x, this.y, 2*this.r);
    fill(255);
    noStroke();
    circle(this.x, this.y, this.r/2);
		this.update();
	}

	void update(){
    float sp = dist(0, 0, this.vx, this.vy);
    this.r = map(sp, 0, 10, 1, 3);
		this.x += vx;
		this.y += vy;
		if (this.x<0 || this.x > width){
			vx = -vx/2;
			vy = vy/2;
			if (this.x < 0){
				this.x = 0;
			}else{
				this.x = width;
			}
		}
		if (this.y < 0 || this.y > height){
			vy = -vy/2;
			vx = vx/2;
			if (this.y < 0){
				this.y = 0;
			}else{
				this.y = height;
			}
		}
    float len = dist(this.x, this.y, mouseX, mouseY);
    if (len < 100){
      vx = (this.x-mouseX);
      vy = (this.y-mouseY);
    }else{
      vx /= 1000;
      vy /= 1000;
    }
	}

}
