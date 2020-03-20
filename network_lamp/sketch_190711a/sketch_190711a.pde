import processing.serial.*;
import java.net.*;

import java.io.*;
import java.util.*;

//String feed="https://blog.arduino.cc/feed/";
//String feed="https://scheepersblog.com/2018/07/10/erich-fromm-love/";
String feed = "https://programminginarduino.wordpress.com/2016/02/29/projecte-3/";

int interval =5*60*1000;
int lastTime;

int love=0;
int peace=0;
int arduino=0;
int light=0;

Serial port;
color c;
String cs;

String buffer = "";
PFont font;

void setup(){
  size(640,480);
  //size(1000,480);
  frameRate(10);
  
  font=createFont("Helvetica",24);
  fill(255);
  textFont(font,32);
  
  println(Serial.list());
  
  //String arduinoPort=Serial.list()[2];
  String arduinoPort=Serial.list()[Serial.list().length-1];
  
  port=new Serial(this, arduinoPort,9600);
  
  lastTime=millis();
  fetchData();
  
}

void draw(){
//("ding");
  background(c);
  text("Arduino Networked lamp", 10, 40);

  
  int n = (lastTime + interval - millis())/1000;
  
  //create a color based on 3 values
  c = color(peace, love, arduino);
  cs = "#"+hex(c,6); //send to arduino
  
  text("Arduino Networked lamp", 10, 40);
  text("Reading feed",10,100);
  text(feed,10,140);
  
  text("Next update in "+n + " seconds",10,450);
  text("peace", 10, 200);
  text(" " + peace, 130,200);
  rect(200,172, peace ,28);
  
  text("love " , 10, 240);
  text(" "+ love, 130,240);
  rect(200,212,love,28);
  
  text("arduino ", 10,280);
  text(" "+ arduino, 130,280);
  rect(200,252, arduino,28);
  
  text("sending", 10,340);
  
  text(cs,200,340);

  text("light level",10, 380);
  rect(200,352,light/10.23,28);//max1023, max 100
  
  if(n<=0){
    fetchData();
    lastTime=millis();
  }
  
  port.write(cs);//send data to arduino
  
  if(port.available()>0){
    
    
    println("sending");
    
    int inByte = port.read();
    if(inByte !=10){
      buffer=buffer+char(inByte);
    } else{
      //check if there exists data
      if(buffer.length()>1){
        buffer=buffer.substring(0,buffer.length()-1);
        
        light=int(buffer);
        
        buffer="";
        
        port.clear();
      }
    }
  }
}

void fetchData(){
  String data;
  String chunk;
  
  love=0;
  peace=0;
  arduino=0;
  
  try{
    URL url=new URL(feed);
    URLConnection conn = url.openConnection();
    conn.connect();
    println("yes");
    
    BufferedReader in = new BufferedReader(
    new InputStreamReader(conn.getInputStream()));
    
    while((data=in.readLine())!=null){
      StringTokenizer st = new StringTokenizer(data, "\"<>,.()[] ");
      
      while( st.hasMoreTokens()) {
        chunk = st.nextToken().toLowerCase();
        //println(chunk);
        
        if(chunk.indexOf("love")>=0)
          {
            //println("tt");
          love++;}
        
        if(chunk.indexOf("peace")>=0)
          peace++;
          
        if(chunk.indexOf("arduino")>=0){
          //println("tt");
          arduino++;
        }
        
      }
      
    }
    print(arduino);
    
    if (peace>64) peace = 64; 
    if (love>64) love = 64;
    if (arduino>64) arduino = 64;
    
    peace = peace*4;
    love=love*4;
    arduino = arduino*4;
  }
  
  catch(Exception ex){
    ex.printStackTrace();
    System.out.println("Error: "+ ex.getMessage());
  }
}

  
  
  
  
  
