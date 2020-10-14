var x, y;
const scale = 20;

var ar;
var temp;

var start, pause, reset; 

var active;
var toStart;

function setup(){
    
  active = false;
  toStart = true;
    
  start = document.getElementById("start");
  pause = document.getElementById("pause");
  reset = document.getElementById("reset");
  buttons();
    
  ww = windowWidth*0.95;
  hh = windowHeight*0.95;
  ww = int(ww);
  hh = int(hh);
  
  this.y = int(ww/scale);
  this.x = int(this.y/2);

  var cv = createCanvas(this.y*scale, this.x*scale);
  cv.style("{margin: 0px 50px;}");
  
  ar = new Array(x);
  temp = new Array(x);
  
  for (let i = 0; i < x; i++){
    ar[i] = new Array(this.y);
    for (let j = 0; j < y; j++){
      ar[i][j] = false;
    }
  }
  
  for (let i = 0; i < x; i++){
    temp[i] = new Array(this.y);
    for (let j = 0; j < y; j++){
      temp[i][j] = false;
    }
  }
  
  //initial();
  
  background(200);
  drawGrids();
  
  frameRate(8);
  
}

function draw(){
  if (!active) return;
    
  background(200);
  
  drawGrids();
  
  drawPoints();
  
  update();
}

function drawGrids(){
  stroke(50);
  for (let i = 0; i < this.x; i++){
    line(0, i*scale, width, i*scale);
  }
  for (let i = 0; i < this.y; i++){
    line(i*scale, 0, i*scale, height);
  }
}

function drawPoints(){
  fill(255, 255, 0);
  stroke(255, 0, 0);
  for (let i = 0; i < x; i++){
    for (let j = 0; j < y; j++){
      if (ar[i][j]){
        rect(j*scale, i*scale, scale, scale);
      }
    }
  }
}

function initial(){
  let pt = [
    [1, 0],
    [2, 1],
    [2, 2],
    [1, 2],
    [0, 2] 
  ];
  for (let i = 0; i < pt.length; i++){
    ar[pt[i][0]][pt[i][1]] = true;
  }
}

function count(i, j){
  let res = 0;
  if (i-1>=0 && j-1>=0){
    if (ar[i-1][j-1]) res++;
  }
  if (i-1>=0){
    if (ar[i-1][j]) res++;
  }
  if (i-1>=0 && j+1<this.y){
    if (ar[i-1][j+1]) res++;
  }
  if (j-1>=0){
    if (ar[i][j-1]) res++;
  }
  if (j+1<this.y){
    if (ar[i][j+1]) res++;
  }
  if (i+1<this.x && j-1>=0){
    if (ar[i+1][j-1]) res++;
  }
  if (i+1<this.x){
    if (ar[i+1][j]) res++;
  }
  if (i+1<this.x && j+1<this.y){
    if (ar[i+1][j+1]) res++;
  }
  
  return res;
}

function update(){
  for (let i = 0; i < x; i++){
    for (let j = 0; j < y; j++){
      temp[i][j] = ar[i][j];
    }
  }
  for (let i = 0; i < x; i++){
    for (let j = 0; j < y; j++){
      let res = count(i, j);
      if (res<2 && ar[i][j]){
        temp[i][j] = false;
      }else if (res<=3&&res>=2&&ar[i][j]){
        continue;
      }else if (ar[i][j]&&res>3){
        temp[i][j] = false;
      }else if (!ar[i][j]&&res==3){
        temp[i][j] = true;
      }
    }
  }
  for (let i = 0; i < x; i++){
    for (let j = 0; j < y; j++){
      ar[i][j] = temp[i][j];
    }
  }
}

function buttons(){
  start.addEventListener("click", function() {
     active = true; 
     toStart = false;
  });
  pause.addEventListener("click", function() {
     active = false;
  });
  reset.addEventListener("click", function() {
     active = false;
     toStart = true;
     for (let i = 0; i < x; i++){
        for (let j = 0; j < y; j++){
          ar[i][j] = false;
      }
     }
     background(200);
     drawGrids();
  });
}

function mouseClicked(){
  if (!toStart) return;
  if (mouseX<=0||mouseX>=width) return;
  if (mouseY<=0||mouseY>=height) return;
  let yy = int(mouseX/scale);
  let xx = int(mouseY/scale);
  ar[xx][yy] = !ar[xx][yy];
  background(200);
  drawGrids();
  drawPoints();
}