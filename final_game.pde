
/////////////////////// declaring global vars

import processing.video.*;
import processing.sound.*;

Player p1;
Boss b1;

Movie Intro;
Movie BossIntro;
Movie Outro;

SoundFile bossMusic;
SoundFile waveMusic;
SoundFile loseMusic;
SoundFile titleMusic;
SoundFile winMusic;
SoundFile aboutMusic;
SoundFile shootSound;
SoundFile bossShoot;
SoundFile enemyDeath;

boolean spawnEnemy;

int startTime;
int waveStartTime;
int currentTime;
int waveCurrentTime;

int textStartTime;

int textCurrentTime;

int bossAttackStart;
int bossAttackCurrent;
int attackStart;
int attackCurrent;

int intervalWave1 = 1000;
int intervalWave2 = 700;
int intervalWave3 = 400;

int wave1Speed = 5;
int wave2Speed = 6;
int wave3Speed = 8;

int waveTime = 35000;

int textTime = 2000;

int bossAttackTime = 8000;
int attackTime = 2000;

color textColor;

//////// LISTS ////////////

ArrayList<Bullet> bulletList;
ArrayList<Enemy> enemyList;


//////// ANIMATION ////////////

PImage map;
PImage loseScreen;
PImage title;
PImage winScreen;
PImage startButton;
PImage aboutButton;
PImage quitButton;
PImage nextButton;
PImage titleB;
PImage aboutPage;
PImage titleBg;

//////// BOOLEANS ///////////

boolean isActive;
boolean isHit;

///////// STATES & BUTTONS ///////////

int state = 0;

Button start;
Button about;
Button quit;

Button next;

Button titleButton;

////////////////////////////// SETUP!!! ////////////////////////////////////

void setup() {
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER);

  size(900, 900);

  map = loadImage("background.PNG");
  loseScreen = loadImage("lose_screen.PNG");
  loseScreen.resize(width, height);
  winScreen = loadImage("winScreen.jpg");
  //winScreen.resize(width,height);
  map.resize(width, height);

  startButton = loadImage("start_button.PNG");
  startButton.resize(200, 100);
  aboutButton = loadImage("about_button.PNG");
  aboutButton.resize(200, 100);
  quitButton = loadImage("quit_button.PNG");
  quitButton.resize(200, 100);
  nextButton = loadImage("next_button.PNG");
  nextButton.resize(200, 100);
  titleB = loadImage("title_button.PNG");
  titleB.resize(200, 100);

  titleBg = loadImage("title_background.PNG");
  titleBg.resize(width, height);

  aboutPage = loadImage("About_Page.png");
  aboutPage.resize(width, height);


  Intro = new Movie(this, "TDA_intro.mp4");

  BossIntro = new Movie(this, "TDA_BossIntro.mp4");

  Outro = new Movie(this, "TDA_Outro.mp4");

  title = loadImage("TDA_Title.PNG");
  title.resize(700, 310);

  /////////// SOUND

  bossMusic = new SoundFile(this, "natty_boss_music.mp3");

  waveMusic = new SoundFile(this, "basic_battle_music.mp3");

  loseMusic = new SoundFile(this, "lose_music_hehe.mp3");
  
  titleMusic = new SoundFile(this, "title_screen_music.mp3");
  
  winMusic = new SoundFile(this, "win_screen_music.mp3");
  
  aboutMusic = new SoundFile(this, "about_music.mp3");
  
  shootSound = new SoundFile(this, "shoot_sound.mp3");
  
  bossShoot = new SoundFile(this, "boss_shoot_sound.mp3");
  
  enemyDeath = new SoundFile(this, "enemy_dying_sound.mp3");

  //////////// initializing vars

  p1 = new Player();

  b1 = new Boss(width/2, 800, 50, color(#FC8FD8), 100);

  bulletList = new ArrayList<Bullet>();
  enemyList = new ArrayList<Enemy>();

  start = new Button(width/4, height/5*4, color(#9074BF));
  about = new Button(width/2, height/5*4, color(#9074BF));
  quit = new Button(width/4*3, height/5*4, color(#9074BF));

  next = new Button(850, 800, color(#5DCAFF));

  titleButton = new Button(80, 50, color(#FF0303));

  startTime = millis();
  waveStartTime = millis();

  //textStartTime = millis();

  bossAttackStart = millis();
  attackStart = millis();

  textColor = color(#BFA6CB);
}

////////////////////////////// DRAW!!! ////////////////////////////////////

void draw() {

  println(state);

  textStartTime = millis();

  /////////////// STATE MACHINE /////////////////
  switch (state) {

  case 0:

    /// TITLE SCREEN ///
    background(#3D224B);
    
    if (titleMusic.isPlaying() == false){
      titleMusic.play();
    }

    image(titleBg, width/2, height/2);

    p1.health = 100;
    b1.hp = 30;
    loseMusic.stop();
    winMusic.stop();
    aboutMusic.stop();

    image (title, width/2, 200);

    start.drawButton();
    image(startButton, width/4, height/5*4);
    start.inButtonDetect();

    about.drawButton();
    image(aboutButton, width/2, height/5*4);
    about.inButtonDetect();

    quit.drawButton();
    image(quitButton, width/4*3, height/5*4);
    quit.inButtonDetect();

    break;

  case 1:

    background(0);
    
    titleMusic.stop();

    Intro.play();

    image(Intro, width/2, height/2);
    movieEvent(Intro);

    Intro.read();

    if (Intro.time() >= Intro.duration() - 0.05) {
      state = 2;
      waveStartTime = millis();
    }


    //image(nextButton, 820, 800);
    //next.inButtonDetect();

    textStartTime = millis();

    break;

  case 2:

    /// WAVE ONE ///
    image(map, width/2, height/2);

    if (waveMusic.isPlaying() == false) {
      waveMusic.play();
    }

    Intro.stop();

    textCurrentTime = millis();

    if (textCurrentTime - textStartTime <= textTime) {
      textSize(50);
      fill(textColor);
      text("'s' to shoot", 770, 800);
    }

    waveCurrentTime = millis();

    gameFunction(intervalWave1, wave1Speed);
    healthText();

    if (waveCurrentTime - waveStartTime >= waveTime) {
      enemyList.clear();
      bulletList.clear();
      state = 3;
      waveStartTime = millis();
      textStartTime = millis();
    }

    break;

  case 3:

    /// WAVE TWO ///

    image(map, width/2, height/2);

    Intro.stop();
    
    if (waveMusic.isPlaying() == false) {
      waveMusic.play();
    }

    textCurrentTime = millis();

    if (textCurrentTime - textStartTime <= textTime) {
      textSize(50);
      fill(textColor);
      text("wave two", 780, 800);
    }

    gameFunction(intervalWave2, wave2Speed);
    healthText();

    waveCurrentTime = millis();

    // gameFunction(intervalWave1, wave1Speed);
    if (waveCurrentTime - waveStartTime >= waveTime) {
      enemyList.clear();
      bulletList.clear();
      state = 4;
      waveStartTime = millis();
      textStartTime = millis();
    }

    break;

  case 4:

    /// WAVE THREE //

    image(map, width/2, height/2);

    Intro.stop();
    
    if (waveMusic.isPlaying() == false) {
      waveMusic.play();
    }

    textCurrentTime = millis();

    if (textCurrentTime - textStartTime <= textTime) {
      textSize(50);
      fill(textColor);
      text("final wave", 775, 800);
    }

    gameFunction(intervalWave3, wave3Speed);
    healthText();

    waveCurrentTime = millis();

    // gameFunction(intervalWave1, wave1Speed);
    if (waveCurrentTime - waveStartTime >= waveTime) {
      enemyList.clear();
      bulletList.clear();
      state = 9;
      waveStartTime = millis();
    }

    break;

  case 5:

    /// BOSS STAGE ///

    image(map, width/2, height/2);

    waveMusic.stop();

    if (bossMusic.isPlaying() == false) {
      bossMusic.play();
    }

    Intro.stop();

    bossAttackCurrent = millis();

    p1.render();
    healthText();
    bossHealthText();

    for (int index = 0; index <=bulletList.size()-1; index++) {

      bulletList.get(index).render();
      bulletList.get(index).move();
    }

    for (int i = bulletList.size()-1; i >= 0; i=i-1) {
      Bullet aBullet = bulletList.get(i);

      aBullet.collision2(b1);

      if (aBullet.shouldRemove == true) {
        bulletList.remove(aBullet);
      }
    }

    b1.drawBoss();
    b1.move();
    b1.wallDetect();

    if (bossAttackCurrent - bossAttackStart >= bossAttackTime) {
      //b1.attack(p1);
      state = 6;
      bossAttackStart = millis();
      attackStart = millis();
    }

    break;

  case 6:

    /// BOSS ATTACK ///

    image(map, width/2, height/2);

    attackCurrent = millis();

    b1.x=width/2;
    b1.y=height/2;

    p1.render();
    healthText();
    bossHealthText();

    b1.attackRender();

    for (int index = 0; index <=bulletList.size()-1; index++) {

      bulletList.get(index).render();
      bulletList.get(index).move();
    }

    for (int i = bulletList.size()-1; i >= 0; i=i-1) {
      Bullet aBullet = bulletList.get(i);

      aBullet.collision2(b1);

      if (aBullet.shouldRemove == true) {
        bulletList.remove(aBullet);
      }
    }

    b1.drawBossAttack();
    b1.wallDetect();


    if (attackCurrent - attackStart >= attackTime) {
      state = 5;
      bossAttackStart = millis();
      attackStart = millis();
      b1.attack(p1);
    }

    break;

  case 7:

    /// LOSE STATE ///

    bossMusic.stop();
    waveMusic.stop();

    if (loseMusic.isPlaying() == false) {
      loseMusic.play();
    }

    background(#F6E5FF);
    image(loseScreen, width/2, height/2);

    image(titleB, 100, 45);
    titleButton.inButtonDetect();

    break;

  case 8:

    /// WIN STATE ///

    bossMusic.stop();

    background(0);

    Outro.play();
    Outro.noLoop();
    image(Outro, width/2, height/2);
    movieEvent(Outro);

    image(titleB, 100, 45);
    titleButton.inButtonDetect();

    break;

  case 9:

    // BOSS INTRO //

    image(map, width/2, height/2);

    p1.render();

    waveMusic.stop();

    BossIntro.play();
    image(BossIntro, width/2, height/2);
    movieEvent(BossIntro);

    if (BossIntro.time() >= BossIntro.duration() - 0.05) {
      state = 5;
    }


    break;

  case 10:
  
  //// ABOUT PAGE

    background(0);
    
    titleMusic.stop();
    
    if(aboutMusic.isPlaying() == false){
      aboutMusic.play();
    }

    image(aboutPage, width/2, height/2);

    image(titleB, 100, 45);
    titleButton.inButtonDetect();

    break;


  default:
    background(color(random(0, 255), random(0, 255), random(0, 255)));
    println ("you did an oopsie!! D:");
  }

  if (p1.health <= 0) {
    state = 7;
  }
}

///////////////////////// KEYPRESSED /////////////////////////////

void keyPressed() {
  println("presssssssssssss");
  if (key == 's') {
    bulletList.add(new Bullet(p1.x, p1.y, mouseX, mouseY));
    shootSound.play();
  }
  if (key == 'a') {
    enemyList.add(new Enemy(random(0, width), height, 2, p1));
  }
  if (key == '1') {
    state = 2;
  }
  if (key == '2') {
    state = 3;
  }
  if (key == '3') {
    state = 4;
  }
  if (key == 'b') {
    state = 5;
  }
  if (key == 'l') {
    state = 7;
  }
  if (key == 'i') {
    state = 9;
  }
  if (key == '9') {
    state = 10;
  }
}

///////////////////////// MOUSEPRESSED /////////////////////////////

void mousePressed() {
  if (start.inButtonDetect()) {
    state = 1;
  }
  if (about.inButtonDetect()) {
    state = 10;
  }
  if (quit.inButtonDetect()) {
    exit();
  }
  if (next.inButtonDetect()) {
    state = 2;
  }
  if (titleButton.inButtonDetect()) {
    state = 0;
  }
}

void gameFunction(int wave, int speed) {

  currentTime = millis();

  p1.render();

  for (Enemy anEnemy : enemyList) {
    p1.collision(anEnemy);
  }

  for (int index = 0; index <= enemyList.size()-1; index++) {

    enemyList.get(index).render();
    enemyList.get(index).move();
  }

  for (int index = 0; index <=bulletList.size()-1; index++) {

    bulletList.get(index).render();
    bulletList.get(index).move();
  }

  for (int i = bulletList.size()-1; i >= 0; i=i-1) {
    Bullet aBullet = bulletList.get(i);

    for (Enemy anEnemy : enemyList) {
      aBullet.collision(anEnemy);
    }

    if (aBullet.shouldRemove == true) {
      bulletList.remove(aBullet);
    }
  }

  for (int i = enemyList.size()-1; i >=0; i=i-1) {
    Enemy anEnemy = enemyList.get(i);

    if (anEnemy.shouldRemove == true) {
      enemyList.remove(anEnemy);
    }
  }

  if (currentTime - startTime >= wave) {

    enemyList.add(new Enemy(random(0, width), height, speed, p1));

    startTime = millis();
  }
}

void healthText() {
  textSize(50);
  fill(#F50004);
  text(p1.health, 50, 50);
}

void bossHealthText() {
  textSize(50);
  fill(#43CEFF);
  text(b1.hp, 850, 800);
}

void movieEvent(Movie m) {
  m.read();
}
