var len, n, m, gap;
var bricks = [];
var player;
var ball;
var ff = false;
var total = 0;

function setup() {
    createCanvas(windowWidth*(4.5/10), windowHeight*(9/10));
    //frameRate(600);
    
    len = width/10;
    gap = width/20;
    n = (width-2*gap)/len;
    m = n;
  
    for (var i = 0; i < n; i++){
        var temp = [];
        for (var j = 0; j < m; j++){
            temp.push(new Brick(len*i+gap, height/20+len*j/4, len));
        }
        bricks.push(temp);
    }
    
    player = new Player();  
    ball = new Ball(player);
  
}

function draw() {
	if (ff || total>=m*n) {
		textAlign(CENTER);
		textSize(32);
		text("Game Over!", width/2, height/2);
		return;
	}

    for (var q = 0; q < 10; q++){
        background(50);
    
        for (var i = 0; i < n; i++){
          for (var j = 0; j < m; j++){
            bricks[i][j].show();
          }
        }
        
        player.show();
        ball.show();
        //player.x = constrain(ball.x-player.len/2, 0, width-player.len);
        
        if (keyIsDown(LEFT_ARROW)){
            player.x = max(player.x-width/960, 0);
        }
        if (keyIsDown(RIGHT_ARROW)){
            player.x = min(player.x+width/960, width-player.len);
        } 
    }
    
}

function checkOverlap(R, Xc, Yc, X1, Y1, X2, Y2) { 
    var Xn = max(X1, min(Xc, X2)); 
    var Yn = max(Y1, min(Yc, Y2)); 
    var Dx = Xn - Xc; 
    var Dy = Yn - Yc; 
    return (Dx * Dx + Dy * Dy) <= R * R; 
}

class Brick{
    constructor(x_, y_, len_){
        this.x = x_;
        this.y = y_;
        this.len = len_;
        this.c = color(240, 45, 240);
        this.isGone = false;
    }
    
    show(){
        fill(this.c);
        noStroke();
        rect(this.x+this.len/8, this.y+this.len/16, 3*this.len/4, (this.len/4)/2);
    }

    check(){
        if (!checkOverlap(ball.radius, ball.x, ball.y, this.x+this.len/8, this.y+this.len/16, this.x+this.len*(7/8), this.y+this.len*(3/16))){   	
        	return false;
        }

        if (this.isGone) return false;
        this.isGone = true;
        this.c = color(50, 50, 50);
        total++;

        if (ball.x<this.x || ball.x>this.x+this.len*(7/8)){
        	ball.th = -ball.th;
        }else{
        	ball.th = PI-ball.th;
        }
        return true;
    }
    
}

class Player{
    constructor(){
        this.len = width/10;
        this.x = width/2-this.len/2;
    }
    
    show(){
        fill(255, 99, 71);
        rect(this.x, height-this.len/2, this.len, this.len/4);
    }

    check(){
        if (checkOverlap(ball.radius, ball.x, ball.y, player.x, height-player.len/2, player.x+player.len, height-player.len/4)){
			//text(ball.th, 500, 500);        	
        	return true;
        }
        return false;
    }
}

class Ball{
    constructor(player_){
        this.radius = width/80;
        this.x = width/2;
        this.y = height-player_.len/2-this.radius;
        this.vel = width/960;
        this.th = random(-PI/2+PI/6, PI/2-PI/6);
        this.isActive = true;
    }
    
    show(){
        fill(255, 255, 0);
        ellipse(this.x, this.y, this.radius*2);
        this.x += this.vel*sin(this.th);
        this.y -= this.vel*cos(this.th);
        this.update();
    }
    
    update(){
        if (this.x<this.radius || this.x>width-this.radius){
        	if (cos(this.th)>=0){
        		this.th = -this.th;
        	}else{
        		this.th = 2*PI-(this.th)
        	}
        	return;
        }
        if (this.y<this.radius || this.y>height-this.radius){
        	this.th = PI-this.th;
        	return;
        }
        if (this.y>height){
        	this.isActive = false;
        	return;
        }
        if (player.check()){
    		if (this.x<player.x || this.x>player.x+player.len){
	        	this.th = 2*PI-(this.th)
	        }else{
	        	this.th = PI-this.th;
	        }
        	return;	
        }
        for (var i = 0; i < n; i++){
        	for (var j = 0; j < m; j++){
            	if (bricks[i][j].check()) return;
        	}
    	}
    }
}
