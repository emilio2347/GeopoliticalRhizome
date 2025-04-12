void run(int programState) {
    switch(programState) {
        case 0:
            introModules[0].run();
            break;
        case 1:
            introModules[1].run();
            break;
        case 2:
            modules[0].run();
            modules[1].run();
            modules[2].run();
            break;
    }
    
}


void displayGraphics(PGraphics pg, float x, float y, float w, float h) {
    image(pg, x, y);
    noFill();
    stroke(0);
    strokeWeight(1);
    rect(x, y, w, h);
}

void mouseClicked() {
    switch(programRunner.programState) {
        case 0:
            introModules[0].mouseClickedEvent();
            break;
        case 1:
            introModules[1].mouseClickedEvent();
            break;
        case 2:
            modules[0].mouseClickedEvent();
            modules[1].mouseClickedEvent();
            modules[2].mouseClickedEvent();
            break;
    } 
}

void mousePressed() {
    switch(programRunner.programState) {
        
        case 1:
            introModules[1].mousedPressedEvent();
            break;
        
    } 
}

void mouseDragged() {
    switch(programRunner.programState) {
        
        case 1:
            introModules[1].mouseDraggedEvent();
            break;
        
    } 
}

void mouseReleased() {
    switch(programRunner.programState) {
        
        case 1:
            introModules[1].mouseReleasedEvent();
            break;
        
    } 
}

void keyPressed() {
    switch(programRunner.programState) {
        
        case 1:
            introModules[1].keyPressedEvent();
            break;
        
    } 
}

void mouseWheel(MouseEvent event) {
    float mouseWheelSensitivity = -0.005;
    float e = event.getCount();
    e *= mouseWheelSensitivity;
    
    switch(programRunner.programState) {
        
        case 1:
            introModules[1].mouseWheelEvent(e);
            break;
        
    } 
}







class ProgramRunner{
    boolean projectLoaded;
    int programState;
    
    ProgramRunner() {
        projectLoaded = false;
        programState = 0;
    }
    
    
}