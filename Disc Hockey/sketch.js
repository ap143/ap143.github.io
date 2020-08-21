var player, comp;
var ball;
//var score = 0;
//var scoreBox;
//var highest;
//var high = 0;

function setup() {
    createCanvas(windowWidth/2, 9*windowHeight/10);
    
    player = new Player();
    comp = new Comp();
    ball = new Ball();
    //scoreBox = document.getElementById("Score");
    //highest = document.getElementById("highest");
    
}

function draw() {
    
    for (var q = 0; q < 20; q++){
        background(50);
        fill(50);
        stroke(255, 255, 0);
        strokeWeight(5);
        rect(0, 0, width, height);
        
        player.draw();
        comp.draw();
        ball.draw();  
        
        comp.x = constrain(ball.x-width/20, 0, width-width/10);
        //player.x = constrain(ball.x-width/20, 0, width-width/10);

        if (keyIsDown(LEFT_ARROW)){
            player.x = constrain(player.x-1, 0, width-width/10);
        }
        if (keyIsDown(RIGHT_ARROW)){
            player.x = constrain(player.x+1, 0, width-width/10);
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

function Player(){
    this.x = width/4;
    this.y = height-width/20;
}
Player.prototype = {
    draw: function(){
        fill(255, 255, 0);
        rect(this.x ,this.y, width/10, width/80);
    },
    
    check(){
        if (!checkOverlap(ball.radius, ball.x, ball.y, this.x, this.y, this.x+width/10, this.y+width/80)){    

            return false;
        }

        if (ball.x<this.x || ball.x>this.x+width/10){
            ball.th = -ball.th;
        }else{
            if (ball.y>this.y && cos(ball.th)<0){
                //scoreBox.innerHTML = "Score: " + score;
                //highest.innerHTML = "Highest achieved: " + high;
            }
            ball.th = PI-ball.th;
        }
        return true;
    }
}

function Comp(){
    this.x = 3*width/4;
    this.y = width/(20);
}
Comp.prototype = {
    draw: function(){
        fill(255, 255, 0);
        rect(this.x ,this.y, width/10, width/80);
    },
    
    check(){
        if (!checkOverlap(ball.radius, ball.x, ball.y, this.x, this.y, this.x+width/10, this.y+width/80)){      
            return false;
        }

        if (ball.x<this.x || ball.x>this.x+width/10){
            ball.th = -ball.th;
        }else{
            ball.th = PI-ball.th;
        }
        return true;
    }
}

function Ball(){
    this.radius = width/80;
    this.x = width/2;
    this.y = height/2;
    this.vel = 1;
    this.th = random(-PI/2+PI/36, PI/2-PI/36);
    this.isActive = true;
}

Ball.prototype = {
    
    draw: function(){
        fill(255, 0, 255);
        noStroke();
        ellipse(this.x, this.y, this.radius*2);
        this.x += this.vel*sin(this.th);
        this.y -= this.vel*cos(this.th);
        this.update();
    },
    
    update: function(){
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
            //score--;
            //scoreBox.innerHTML = "Score: " + score;
            return;
        }
        if (player.check()){
            return;
        }
        if (comp.check()){
            return;
        }
    }
}
