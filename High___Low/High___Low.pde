class Trump {
  int trumpDeck[]=new int[52];//トランプの山札の順番を決める変数
  Boolean trumpYet[]=new Boolean[52];//どのカードが現れたかを記憶する変数
  int count=0; //今が山札の何番目を参照しているかを記憶する変数
  int cardx=50; //カードの大きさを指定する変数
  int cardy=90;//カードの大きさを指定する変数
  Trump() {
    int buffer=0;
    int random=0;
    for (int j=0; j<1; j++) {
      for (int i=0; i<trumpDeck.length; i++) {
        trumpDeck[i]=i;
        trumpYet[i]=false;
      }
      for (int i=0; i<trumpDeck.length; i++) {
        random=int(random(trumpDeck.length));
        buffer=trumpDeck[i];
        trumpDeck[i]=trumpDeck[random];
        trumpDeck[random]=buffer;
      }
    }
  }
  
  void judgeCardColor(int i) { //引数で与えられたカーその色を判別するメソッド
    if (i/13==0||i/13==2) {
      fill(125,125, 125);
    } else {
      fill(220, 0, 0);
    }
  }
}

class HighLow extends Trump { //class Trumpを継承
  int score=0; //スコアを記憶する変数
  int time=0; //場面転換用の一時保存用の変数
  int dlay=0; //場面転換用の一時保存用の変数
  HighLow() {
    super();
  }
  void displaycard() { //現在のカードと既に出たカードを表示するメソッド
    judgeCardColor(trumpDeck[count]); 
    rect(width/5, height/5, cardx*3, cardy*3);
    fill(0);
    textSize(30);
    text(trumpDeck[count]%13+1, width/5+cardx/2*2.5, height/5+cardy/2*3);
    for (int i=0; i<trumpDeck.length; i++) {
      if (trumpYet[i]) {
        judgeCardColor(i);
      } else {
        fill(255);
      }
      rect(width/2+(i%13)*cardx, height/3+int(i/13)*cardy, cardx, cardy);
      textSize(15);
      if (trumpYet[i]) {
        fill(0);
        text(i%13+1, width/2+(i%13)*cardx+cardx/2.5, height/3+int(i/13)*cardy+cardy/2);
      }
    }
  }
  
  void displayNextcard(Boolean hyde) { //引数で裏向きか表向きかを指定し次のカードを表示するメソッド
    if (hyde) {
      fill(125, 125, 255);
    } else {
      judgeCardColor(trumpDeck[count+1]);
    }  
    rect(width/5, height*3/5, cardx*3, cardy*3);
    fill(0);
    textSize(30);
    if (!hyde) {
      text(trumpDeck[count+1]%13+1, width/5+cardx/2*2.5, height*3/5+cardy/2*3);
    }
  }
  
  void displaychar() { //説明文を表示するメソッド
    textSize(30);
    text("Guess if the next card is bigger or smaller than the one above, which is displayed now!", 100, 100);
    text("Up key is High. Down key is Low.", 100, 140);
    text("or push High or Low", 120, 180);
    fill(100, 100, 255);
    rect(50, 600, 150, 150);
    fill(255, 100, 100);
    rect(550, 600, 150, 150);
    fill(0);
    text("Low", 100, 680);
    text("High", 600, 680);
    text("score:"+score, width/5, height/2+50);
  }
  
  void update() { //画面転換用の秒数を測定するメソッド
    deck.displayNextcard(false);
    trumpYet[trumpDeck[count]]=true;
    dlay++;
    if (dlay>100) {
      time=0;
      dlay=0;
      count++;
    }
  }
  
  void judgeHighLow() { //ハイかローが成功しているかを判別するメソッド
    if (time==1) {
      update();
    } else if (time==2) {
      update();
    } else {
      if (((keyPressed == true)&&(keyCode == UP))||((mousePressed== true)&&(550 <mouseX&&mouseX<700&&600<mouseY&&mouseY<750))) {
        time=1;
        deck.displayNextcard(false);
        if ((trumpDeck[count]%13)<(trumpDeck[count+1]%13)) {
          score+=10;
        } else if ((trumpDeck[count]%13)==(trumpDeck[count+1]%13)) {
          score+=5;
        }
      } else if (((keyPressed == true)&&(keyCode == DOWN))||((mousePressed== true)&&(50 <mouseX&&mouseX<200&&600<mouseY&&mouseY<750))) {
        time=2;
        deck.displayNextcard(false);
        if ((trumpDeck[count]%13)>(trumpDeck[count+1]%13)) {
          score+=10;
        } else if ((trumpDeck[count]%13)==(trumpDeck[count+1]%13)) {
          score+=5;
        }
      } else {
        deck.displayNextcard(true);
      }
    }
  }
}

HighLow deck =new HighLow(); //インスタンスの生成

void setup() {
  size(1500, 1000);
}

void draw() {
  background(50, 200, 50);
  deck.displaycard();
  deck.displaychar();
  deck.judgeHighLow();
}
