var n;
var ratio;

function setup() {
  createCanvas(windowWidth*0.95, windowWidth*0.95);
  n = 8;
  ratio = (width*0.9)/n;
}

function draw() {
  background(200);
  translate(width*0.05, width*0.05);
  drawBoard();
}

function drawBoard(){
    fill(255);
    for (var i = 0; i < n; i++){
        for (var j = 0; j < n; j++){
            if ((i+j)%2==0) {
                fill(0);
            }else{
                fill(255);
            }
            rect(i*ratio, j*ratio, ratio, ratio);
        }
    }
}

function drawKing(x, y){
    text("KING", x*ratio, y*ratio);
}