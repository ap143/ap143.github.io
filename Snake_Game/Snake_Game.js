class Food{  
  constructor(){
    this.radius = 10;
    this.x = round(random(1, m-1));
    this.y = round(random(1, n-1));
  }
  show(){
    noStroke();
    fill(255, 255, 0);
    circle(this.x*len, this.y*len, this.radius);
  }
  update(){
    this.x = round(random(1, m-1));
    this.y = round(random(1, n-1));
    for (var i = 0; i < snake.length; i++){
      if (this.x==snake[i].x && this.y==snake[i].y){
        this.update();
        break;
      }
    }
  }
}

class Snake{
  constructor(x, y){
    this.radius = 10;
    this.x = x;
    this.y = y;
  }
  show(){
    noStroke();
    fill(255);
    circle(this.x*len, this.y*len, this.radius);
  }
}

var food;
var snake = [];
var n, m;
var len;
var vel;
var fr = 10;
var isReset = false;

function setup() {
  createCanvas(windowWidth*(0.9), windowHeight*(0.9));
  frameRate(fr);
  len = 12;
  n = height/len;
  m = width/len;
  
  vel = new p5.Vector(1, 0);
  food = new Food();
  snake.push(new Snake(1, 1));
}


function draw() {
  background(0);
  
  if (isReset){
    fill(255);
    textAlign(CENTER);
    textSize(32);
    text('Game Over! \n Press Enter to start again', width/2, height/2);
  }
 
  food.show();
  
  stroke(255, 0, 0);
  line(0.5*len, 0.5*len, (m-0.5)*len, 0.5*len);
  line(0.5*len, 0.5*len, 0.5*len, (n-0.5)*len);
  line(0.5*len, (n-0.5)*len, (m-0.5)*len, (n-0.5)*len);
  line((m-0.5)*len, 0.5*len, (m-0.5)*len, (n-0.5)*len);
  
  for (var i = 0; i < snake.length; i++){
    snake[i].show();
  }
  
  if (check()){
    snake.push(new Snake(0, 0));
    for (i = snake.length-1; i >= 1; i--){
      snake[i].x = snake[i-1].x;
      snake[i].y = snake[i-1].y;
    }
    snake[0].x = food.x+vel.x;
    snake[0].y = food.y+vel.y;
    food.update();
    fr++;
    frameRate(fr);
  }else if (isGameOver()){
    isReset = true;
    vel.x = 0;
    vel.y = 0;
  }else{
    moveSnake();
  }
    
}

function moveSnake(){
  for (var i = snake.length-1; i >= 1; i--){
    snake[i].x = snake[i-1].x;
    snake[i].y = snake[i-1].y;
  }
  snake[0].x += vel.x;
  snake[0].y += vel.y;
}

function check(){
  if (snake[0].x==food.x && snake[0].y==food.y){
    return true;
  }else{
    return false;
  }
}

function isGameOver(){
  if (snake[0].x < 1 || snake[0].x > m-1 ||
      snake[0].y < 1 || snake[0].y > n-1){
    return true;
  }
  for (var i = 1; i < snake.length; i++){
    if (snake[0].x == snake[i].x && snake[0].y == snake[i].y){
      return true;
    }
  }
  return false;
}

function keyPressed() {
  if (keyCode === ENTER && isReset){
    isReset = false;
    snake = [];
    food.update();
    fr = 10;
    frameRate(fr);
    vel.x = 1;
    vel.y = 0;
    snake.push(new Snake(1, 1));
    isReset = false;
    Console.log(snake.length);
    return true;
  }
  if (keyCode === LEFT_ARROW && vel.x != 1) {
    vel.x = -1;
    vel.y = 0;
  } else if (keyCode === RIGHT_ARROW && vel.x != -1) {
    vel.x = 1;
    vel.y = 0;
  } else if (keyCode === UP_ARROW && vel.y != 1) {
    vel.x = 0;
    vel.y = -1;
  } else if (keyCode === DOWN_ARROW && vel.y != -1) {
    vel.x = 0;
    vel.y = 1;
  }
  return true;
}
