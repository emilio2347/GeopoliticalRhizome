import processing.javafx.*;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.TimeZone;

import java.util.Map;
import java.math.BigInteger;
import java.security.SecureRandom;

SecureRandom random = new SecureRandom();

PFont sBold, sLight, sRegular, sItalic, 
mBold, mLight, mRegular, mItalic, 
lBold, lLight, lRegular, lItalic;



void init() {
    loadMap();
    loadFonts();
    initProjectData();
    initGraphics();
    initModules();
    
}

void loadMap(){
    worldMap = new WorldMap();
}

void initProjectData() {
    projectData = new ProjectData();
}

void initModules() {
    
    // Module Array containing intro modules
    introModules = new Module[2];
    
    introModules[0] = new IntroModule(this); // Intro 
    introModules[0].setPosition(360, 60);
    introModules[0].setSize(240, 420);
    introModules[0].setPGraphics(introGraphics);
    introModules[0].init();

    introModules[1] = new NewProjectModule(); // New Project
    introModules[1].setPosition(240, 60);
    introModules[1].setSize(480, 420);
    introModules[1].setPGraphics(newProjectGraphics);
    introModules[1].init();

    
    // Module Array containing core modules
    modules = new Module[3];
    
    modules[0] = new TemporalModule(); // Temporal
    modules[0].setPosition(180, 360);
    modules[0].setSize(temporalGraphics.width, temporalGraphics.height);
    modules[0].setPGraphics(temporalGraphics);
    
    modules[1] = new SpatialModule(); // Spatial
    modules[1].setPosition(180, 0);
    modules[1].setSize(spatialGraphics.width, spatialGraphics.height);
    modules[1].setPGraphics(spatialGraphics);

    modules[2] = new SocialModule(); // Social
    modules[2].setPosition(540, 0);
    modules[2].setSize(socialGraphics.width, socialGraphics.height);
    modules[2].setPGraphics(socialGraphics);

}

void initGraphics() {
    introGraphics = createGraphics(240, 420, P2D);
    newProjectGraphics = createGraphics(480, 420, P2D);
    temporalGraphics = createGraphics(780, 180, P2D);
    spatialGraphics = createGraphics(360, 360, P2D);
    socialGraphics = createGraphics(420, 360, P2D);
    
}

void loadFonts() {
    int sScl = 10;
    int mScl = 14;
    int lScl = 16;
    
    sBold = createFont("Polymath-Bold", sScl);
    sLight = createFont("Polymath-Light", sScl);
    sRegular = createFont("Polymath-Medium", sScl);
    sItalic = createFont("Polymath-Italic", sScl);
    
    mBold = createFont("Polymath-Bold", mScl);
    mLight = createFont("Polymath-Light", mScl);
    mRegular = createFont("Polymath-Regular", mScl);
    mItalic = createFont("Polymath-Italic", mScl);
    
    lBold = createFont("Polymath-Bold", lScl);
    lLight = createFont("Polymath-Light", lScl);
    lRegular = createFont("Polymath-Regular", lScl);
    lItalic = createFont("Polymath-Italic", lScl);
    
}

