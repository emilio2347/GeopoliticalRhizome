ProgramRunner programRunner;

void setup(){
    size(960, 540, P2D);
    surface.setLocation(1600, 320);
    surface.setTitle("Home");

    pixelDensity(displayDensity(2));
    programRunner = new ProgramRunner();
    init();
}


void draw(){
    background(255);
    run(programRunner.programState);

   // modules[1].setPosition(mouseX, mouseY);
}

