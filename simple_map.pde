float slope = 0.8;
int[][] rgb = {{255,102,102},  //red
               {255,255,102},  //yellow
               {102,255,255}}; //blue rgb[0][0]
color[] colors = {color(rgb[0][0],rgb[0][1],rgb[0][2]),
                  color(rgb[1][0],rgb[1][1],rgb[1][2]),
                  color(rgb[2][0],rgb[2][1],rgb[2][2])}; //red yellow blue
int[] tp = {128,256,0}; //transparency
int[] colors_y = {250,150,50};
float tp_range = 1.1;
int z = 1; // current dimension
boolean[] keys = new boolean[128];
float apart = 100; //space between parals
float factor = 0; //1.00
boolean in_portal = false; // in_portal but not important lul
int dir = 0; //1=left 2=right


int size = 50; //player size
int speed = 3; //player speed
int x=50,y=425; //player
int px = 125; //portal pos
int py = 425; //portal pos

void setup(){
    size(300,500);
    background(224);
    strokeWeight(10);
}

void draw(){
    background(224);
    paral(80,colors_y[0],200,80,0,tp[0]);
    paral(80,colors_y[1],200,80,1,tp[1]);
    paral(80,colors_y[2],200,80,2,tp[2]);
    text(250+int(apart*factor),100,130);
    text(factor,100,100);
    check(150,200);
    line(0,400,300,400);
    player();
    portal();
  
}

void paral(int x, int y, int w, int h, int c, float t){ //Parallelogram
    y = colors_y[c] + int(apart*factor); 
    t = -1*abs((y*tp_range-150*tp_range)*128/100)+256;
    stroke(colors[c],t);
    line(x,y,x+w,y);
    line(x+w,y,x+w-(h*slope),y+h);
    line(x+w-(h*slope),y+h,x-(h*slope),y+h);
    line(x-(h*slope),y+h,x,y);
    
    text(colors_y[c],100,200+(30*c));
    text(y,130,200+(30*c));
}

void keyPressed(){
    keys[keyCode] = true;
}

void keyReleased(){
    keys[keyCode]  = false;
}

void player(){
    if(keys[LEFT]) x-=speed;
    else if(keys[RIGHT]) x+=speed;
    if(x<-60) x=360;
    else if(360<x) x=-60;
    fill(colors[1]);
    noStroke();
    rect(x,y,size,size);
}

void portal(){
    int i;
    fill(100,127);
    rect(px,py,size,size);
    if(px-size<x&&x<px+size){
        if(!in_portal){
            if(x<px) dir = 1;
            else dir = 2; 
            in_portal = true;
        }
        if(dir==1){
             factor = (float(x) - (float(px) - float(size)))/100;
          
        }else if(dir==2){
             factor = ((float(px) + float(size)) - float(x))/100;
        }
      
      
    }else if(in_portal){
      
        
            for(i=0;i<3;i++){
                colors_y[i] = colors_y[i] + int(apart*factor); 
            }
            factor = 0;
          
        
        
        in_portal = false;
    }
}

void check(int x, int y){ 
    stroke(0);
    line(x-10,y-15,x,y);
    line(x,y,x+10,y-15);
}
