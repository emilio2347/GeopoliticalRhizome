interface Module {
    void run();  // All modules will implement their own render logic
    void init();
    void mouseClickedEvent();
    void keyPressedEvent();
    void mouseWheelEvent(float e);
    
    void mousedPressedEvent();
    void mouseDraggedEvent();
    void mouseReleasedEvent();
    
    // Methods to get/set position and size
    void setPosition(float x, float y);
    void setSize(float w, float h);
    void setPGraphics(PGraphics pg);
    
    float getX();
    float getY();
    float getWidth();
    float getHeight();
    PGraphics getPGraphics();
}



class TemporalModule implements Module{
    float x, y, w, h;
    PGraphics pg;
    
    
    void init() {
    }
    
    
    
    void run() {
        render();
    }
    
    void render() {
        pg.beginDraw();  // Start drawing on the PGraphics buffer
        pg.background(255);
        
        // make sure to load ui elements here !!!
        pg.endDraw();  // End drawing on the PGraphics buffer
        displayGraphics(pg, x, y, w, h);
        
    }
    
    //  ——————————————————————————————————————————————————————————————————————————————————  ||  INIT
    
    //  ——————————————————————————————————————————————————————————————————————————————————  ||  RUN
    
    //  ——————————————————————————————————————————————————————————————————————————————————  || RENDER
    
    //  ——————————————————————————————————————————————————————————————————————————————————  ||  INTERACTION
    
    //  ——————————————————————————————————————————————————————————————————————————————————  ||  SET
    
    //  ——————————————————————————————————————————————————————————————————————————————————  ||  GET
    
    
    void mouseClickedEvent() {}
    void keyPressedEvent() {}
    void mouseWheelEvent(float e) {}
    void mousedPressedEvent() {}
    void mouseDraggedEvent() {}
    void mouseReleasedEvent() {}
    
    public void setPosition(float x, float y) {
        this.x = x;
        this.y = y;
    }
    
    public void setSize(float w, float h) {
        this.w = w;
        this.h = h;
    }
    
    public void setPGraphics(PGraphics pg) {
        this.pg = pg;
    }
    
    public float getX() { return x; }
    public float getY() { return y; }
    public float getWidth() { return w; }
    public float getHeight() { return h; }
    public PGraphics getPGraphics() { return pg; }
}

class SpatialModule implements Module{
    float x, y, w, h;
    PGraphics pg;
    WorldMapSubset mapSubset;
    ZoomableMap zoomableSubset;
    PGraphics subsetMapGraphic;
    
    //  ——————————————————————————————————————————————————————————————————————————————————  ||  INIT
    void init() {
        enterProjectData();
    }
    
    void enterProjectData() {
        PVector start = parseLatLon(projectData.startBB);
        PVector end = parseLatLon(projectData.endBB);
             println("Parsed Bounds:");
    println("Start: " + start);
    println("End: " + end);
        mapSubset = new WorldMapSubset(start, end, w, h);
        zoomableSubset = new ZoomableMap(mapSubset, w, h);
        
    }
    
    //  ——————————————————————————————————————————————————————————————————————————————————  ||  RUN
    void run() {
        render();
    }
    
    //  ——————————————————————————————————————————————————————————————————————————————————  || RENDER
    
    void render() {
        subsetMapGraphic = mapSubset.getMap(floor(w), floor(h));
        if (zoomableSubset == null) {
            println("zoomableSubset is null");
            return;
        }
        if (subsetMapGraphic == null) {
            println("subsetMapGraphic is null");
            return;
        }
 

        zoomableSubset.display(subsetMapGraphic, floor(w), floor(h));
        pg.beginDraw();  // Start drawing on the PGraphics buffer
        pg.background(255);
        pg.image(subsetMapGraphic, 0, 0);
        pg.endDraw();  // End drawing on the PGraphics buffer
        displayGraphics(pg, x, y, w, h);
        
    }
    
    
    //  ——————————————————————————————————————————————————————————————————————————————————  ||  INTERACTION
    
    //  ——————————————————————————————————————————————————————————————————————————————————  ||  SET
    
    //  ——————————————————————————————————————————————————————————————————————————————————  ||  GET
    
    
    
    
    void keyPressedEvent() {  
    }
    
    void mouseClickedEvent() {  
    }
    
    void mouseWheelEvent(float e) {
    }
    
    void mousedPressedEvent() {}
    void mouseDraggedEvent() {}
    void mouseReleasedEvent() {}
    
    public void setPosition(float x, float y) {
        this.x = x;
        this.y = y;
    }
    
    public void setSize(float w, float h) {
        this.w = w;
        this.h = h;
    }
    
    public void setPGraphics(PGraphics pg) {
        this.pg = pg;
    }
    
    public float getX() { return x; }
    public float getY() { return y; }
    public float getWidth() { return w; }
    public float getHeight() { return h; }
    public PGraphics getPGraphics() { return pg; }
}

class SocialModule implements Module{
    float x, y, w, h;
    PGraphics pg;
    //  ——————————————————————————————————————————————————————————————————————————————————  ||  INIT
    
    //  ——————————————————————————————————————————————————————————————————————————————————  ||  RUN
    
    //  ——————————————————————————————————————————————————————————————————————————————————  || RENDER
    
    //  ——————————————————————————————————————————————————————————————————————————————————  ||  INTERACTION
    
    //  ——————————————————————————————————————————————————————————————————————————————————  ||  SET
    
    //  ——————————————————————————————————————————————————————————————————————————————————  ||  GET
    void init() {
    }
    
    void run() {
        render();
    }
    
    void render() {
        pg.beginDraw();  // Start drawing on the PGraphics buffer
        pg.background(255);
        pg.endDraw();  // End drawing on the PGraphics buffer
        displayGraphics(pg, x, y, w, h);
        
    }
    
    void mouseClickedEvent() {
        
    }
    
    void keyPressedEvent() {
        
    }
    void mouseWheelEvent(float e) {
        
    }
    
    void mousedPressedEvent() {}
    void mouseDraggedEvent() {}
    void mouseReleasedEvent() {}
    
    public void setPosition(float x, float y) {
        this.x = x;
        this.y = y;
    }
    
    public void setSize(float w, float h) {
        this.w = w;
        this.h = h;
    }
    
    public void setPGraphics(PGraphics pg) {
        this.pg = pg;
    }
    
    public float getX() { return x; }
    public float getY() { return y; }
    public float getWidth() { return w; }
    public float getHeight() { return h; }
    public PGraphics getPGraphics() { return pg; } 
}



public class IntroModule implements Module{
    private final PApplet pa;
    float x, y, w, h;
    PGraphics pg;
    
    Button[] buttons;
    
    float paddingSides = 10;
    float paddingTop = 14;
    //  ——————————————————————————————————————————————————————————————————————————————————  ||  INIT
    
    IntroModule(PApplet p) {
        pa = p;
    }
    
    void init() {
        initButtons();
        
    }
    
    void initButtons() {
        buttons = new Button[2];
        
        float xScl = 150;
        float yScl = 30; 
        
        buttons[0] = new MainButton();
        buttons[0].setPosition((w - xScl) / 2, 300);
        buttons[0].setSize(xScl, yScl);
        buttons[0].setLabel("Load Project");
        buttons[0].setActive(false);
        buttons[0].setPGraphics(introGraphics);
        
        buttons[1] = new MainButton();
        buttons[1].setPosition((w - xScl) / 2, 300 + yScl + 30);
        buttons[1].setSize(xScl, yScl);
        buttons[1].setLabel("New Project");
        buttons[1].setActive(false);
        buttons[1].setPGraphics(introGraphics);
    }
    
    
    
    //  ——————————————————————————————————————————————————————————————————————————————————  ||  RUN
    
    void run() {
        checkButtons();
        render();
    }
    
    void checkButtons() {
        PVector m = new PVector(mouseX, mouseY);
        for (Button b : buttons) {
            PVector bPos = new PVector(b.getX() + x, b.getY() + y);
            if (intersectRect(m, bPos, b.getWidth(), b.getHeight())) {
                b.setActive(true);
            } else {
                b.setActive(false);
            }
        }
    }
    
    
    //  ——————————————————————————————————————————————————————————————————————————————————  || RENDER
    
    
    void render() {
        
        
        pg.beginDraw();  // Start drawing on the PGraphics buffer
        pg.background(255);
        pg.fill(0);
        pg.textFont(lBold);
        pg.textAlign(LEFT, TOP);
        pg.text("GEOPOLITICAL\nMAPPING", paddingSides, paddingTop);
        
        // make sure to load ui elements here !!!
        for (Button b : buttons) {
            b.render();
        }
        pg.endDraw();  // End drawing on the PGraphics buffer
        displayGraphics(pg, x, y, w, h);
        
    }
    
    //  ——————————————————————————————————————————————————————————————————————————————————  ||  INTERACTION
    
    
    void keyPressedEvent() {}
    
    void mouseClickedEvent() {
        if (buttons[0].getActive()) {
            pa.selectInput("SELECT JSON PROJECT", "loadProjectPrompt", null, this);
        } else if (buttons[1].getActive()) {
            programRunner.programState = 1;
            surface.setTitle("New Project");
        }
    }  
    
    public void loadProjectPrompt(File selection) {
        if (selection == null) {
            // add notification here!
        } else {
            loadProjectData(selection.getAbsolutePath());
            modules[1].init();
            programRunner.programState = 2;
            println("fileSelected");
            surface.setTitle(projectData.projectName);
        }
    }
    
    void mousedPressedEvent() {}
    void mouseDraggedEvent() {}
    void mouseReleasedEvent() {}
    void mouseWheelEvent(float e) {}
    
    
    
    //  ——————————————————————————————————————————————————————————————————————————————————  ||  SET
    
    public void setPosition(float x, float y) {
        this.x = x;
        this.y = y;
    }
    
    public void setSize(float w, float h) {
        this.w = w;
        this.h = h;
    }
    
    public void setPGraphics(PGraphics pg) {
        this.pg = pg;
    }
    
    //  ——————————————————————————————————————————————————————————————————————————————————  ||  GET
    
    public float getX() { return x; }
    public float getY() { return y; }
    public float getWidth() { return w; }
    public float getHeight() { return h; }
    public PGraphics getPGraphics() { return pg; } 
    
}

class NewProjectModule implements Module{
    float x, y, w, h;
    PGraphics pg;
    float paddingSides = 10;
    float paddingTop = 20;
    
    PVector mapPos = new PVector(200, 70);
    float mapScl = 250;
    
    ZoomableMap zoomableMap;
    PGraphics newProjectMap;        
    
    TextBoxInput[] textBoxInputs;
    Button[] buttons;
    
    
    //  ——————————————————————————————————————————————————————————————————————————————————  ||  INIT
    
    void init() {
        initTextBoxes();
        initButtons();
        initMap();
    }
    
    void initButtons() {
        buttons = new Button[2]; // 0 - createProject, 2 - resetBB
        
        float xScl = 150;
        float yScl = 30; 
        
        buttons[0] = new MainButton();
        buttons[0].setPosition((w - xScl) / 2, 370);
        buttons[0].setSize(xScl, yScl);
        buttons[0].setLabel("Create Project");
        buttons[0].setActive(false);
        buttons[0].setPGraphics(newProjectGraphics);
        
        buttons[1] = new SmallButton();
        buttons[1].setLabel("Reset Bounds");
        buttons[1].setSize(textWidth(buttons[1].getLabel()) + 4, 18);
        
        buttons[1].setPosition((mapPos.x + mapScl) - buttons[1].getWidth(), mapPos.y + mapScl + 8);
        buttons[1].setActive(false);
        buttons[1].setPGraphics(newProjectGraphics);
    }
    
    void initTextBoxes() {
        textBoxInputs = new TextBoxInput[4]; // 0 - name, 1 - description, 2 - startDate, 3 - endDate
        
        textBoxInputs[0] = new TextInput();
        textBoxInputs[0].setPosition(30, 70);
        textBoxInputs[0].setSize(130, 18);
        textBoxInputs[0].setPGraphics(pg);
        textBoxInputs[0].setLabel("Project Name");
        textBoxInputs[0].setPrompt("Untitled");
        textBoxInputs[0].setInput("");
        textBoxInputs[0].setActive(false);
        textBoxInputs[0].setInputting(false);
        
        textBoxInputs[1] = new TextInput();
        textBoxInputs[1].setPosition(30, 120);
        textBoxInputs[1].setSize(130, 80);
        textBoxInputs[1].setPGraphics(pg);
        textBoxInputs[1].setLabel("Project Description");
        textBoxInputs[1].setPrompt("Type...");
        textBoxInputs[1].setInput("");
        textBoxInputs[1].setActive(false);
        textBoxInputs[1].setInputting(false);
        
        
        textBoxInputs[2] = new TextInput();
        textBoxInputs[2].setPosition(30, 320 - 68);
        textBoxInputs[2].setSize(80, 18);
        textBoxInputs[2].setPGraphics(pg);
        textBoxInputs[2].setLabel("Start Date");
        textBoxInputs[2].setPrompt("DD/MM/YYYY");
        textBoxInputs[2].setInput("");
        textBoxInputs[2].setActive(false);
        textBoxInputs[2].setInputting(false);
        
        textBoxInputs[3] = new TextInput();
        textBoxInputs[3].setPosition(30, 320 - 18);
        textBoxInputs[3].setSize(80, 18);
        textBoxInputs[3].setPGraphics(pg);
        textBoxInputs[3].setLabel("End Date");
        textBoxInputs[3].setPrompt("DD/MM/YYYY");
        textBoxInputs[3].setInput("");
        textBoxInputs[3].setActive(false);
        textBoxInputs[3].setInputting(false);
    }
    
    void initMap() {
        zoomableMap = new ZoomableMap(worldMap, w, h);
        newProjectMap = worldMap.getMap(mapScl, mapScl);
    }
    
    
    //  ——————————————————————————————————————————————————————————————————————————————————  ||  RUN
    
    void run() {
        checkTextBoxes();
        checkButtons();
        render();
    }
    
    void checkTextBoxes() {
        PVector m = new PVector(mouseX, mouseY);
        for (TextBoxInput tb : textBoxInputs) {
            PVector tbPos = new PVector(tb.getX() + x, tb.getY() + y);
            if (intersectRect(m, tbPos, tb.getWidth(), tb.getHeight())) {
                tb.setActive(true);
            } else {
                tb.setActive(false);
            }
        }
        
    }
    
    void checkButtons() {
        PVector m = new PVector(mouseX, mouseY);
        for (Button b : buttons) {
            PVector bPos = new PVector(b.getX() + x, b.getY() + y);
            if (intersectRect(m, bPos, b.getWidth(), b.getHeight())) {
                b.setActive(true);
            } else {
                b.setActive(false);
            }
        }
    }
    
    boolean checkFieldComlpetion() {
        boolean result = true;
        for (TextBoxInput tb : textBoxInputs) {
            if (tb.getInput().length() <= 0) {
                result = false;
            }
        }
        
        if (zoomableMap.boxStart == null || zoomableMap.boxEnd == null) {
            result = false;
        }
        return result;
    }
    //  ——————————————————————————————————————————————————————————————————————————————————  || RENDER
    
    void render() {
        if (intersectRect(new PVector(mouseX, mouseY), mapPos.copy().add(new PVector(x, y)), mapScl, mapScl)) {
            zoomableMap.updateHover(mouseX - x - mapPos.x, mouseY - y - mapPos.y);
            
        }
        
        zoomableMap.display(newProjectMap, floor(mapScl), floor(mapScl));
        pg.beginDraw(); 
        pg.background(255);
        pg.fill(0);
        
        
        for (TextBoxInput tb : textBoxInputs) {
            tb.render();
        }
        
        pg.fill(0);
        pg.textFont(sRegular);
        pg.textAlign(LEFT, BOTTOM);
        pg.text("Project Bounds", mapPos.x, mapPos.y - 4);
        
        pg.fill(120);
        pg.textAlign(LEFT, TOP);
        pg.textFont(sItalic);
        PVector cursorCordinates = pixelToLatLon(zoomableMap.hoverCoord.x, zoomableMap.hoverCoord.y, floor(mapScl), floor(mapScl));
        
        pg.text(cursorCordinates.x + ", " + cursorCordinates.y, mapPos.x, mapPos.y + mapScl + 8);
        
        pg.image(newProjectMap, mapPos.x, mapPos.y);
        pg.stroke(0);
        pg.strokeWeight(1);
        pg.noFill();
        pg.rect(mapPos.x, mapPos.y, mapScl, mapScl);
        
        for (Button b : buttons) {
            b.render();
        }
        
        pg.endDraw(); 
        displayGraphics(pg, x, y, w, h);
        
    }
    
    
    //  ——————————————————————————————————————————————————————————————————————————————————  ||  INTERACTION
    
    void keyPressedEvent() {
        for (TextBoxInput tb : textBoxInputs) {
            if (tb.getInputting()) {
                if (key >= 32 && key <= 126) {
                    tb.setInput(tb.getInput() + key);
                } else if (key == BACKSPACE && tb.getInput().length() > 0) {
                    tb.setInput(tb.getInput().substring(0, tb.getInput().length() - 1));
                }
            }
        }
        
        
    }
    
    void mouseClickedEvent() {
        boolean hit = false;
        
        for (TextBoxInput tb : textBoxInputs) {
            tb.setInputting(false);
            if (tb.getActive()) {
                tb.setInputting(true);
                hit = true;
            }
        }
        if (hit == false) {
            for (TextBoxInput tb : textBoxInputs) {
                tb.setInputting(false);
            }
        }
        
        if (buttons[0].getActive()) {
            if (checkFieldComlpetion()) {
                projectData.projectName = textBoxInputs[0].getInput();
                projectData.projectDescription = textBoxInputs[1].getInput();
                String[] sDate = parseDateField(textBoxInputs[2].getInput()); 
                projectData.startDate = formatDate(int(sDate[2]), int(sDate[1]), int(sDate[0]), 0, 0, 0, 0);
                String[] eDate = parseDateField(textBoxInputs[3].getInput()); 
                projectData.endDate = formatDate(int(eDate[2]), int(eDate[1]), int(eDate[0]), 0, 0, 0, 0);

                PVector sBB = pixelToLatLon(zoomableMap.boxStart.x, zoomableMap.boxStart.y, floor(mapScl), floor(mapScl));
                PVector eBB = pixelToLatLon(zoomableMap.boxEnd.x, zoomableMap.boxEnd.y, floor(mapScl), floor(mapScl));                
              
                projectData.startBB = str(sBB.x) + ", " + str(sBB.y);
                projectData.endBB = str(eBB.x) + ", " + str(eBB.y);
                saveProjectData("data/saves/" + projectData.projectName);
                
                modules[1].init();
                
                programRunner.projectLoaded = true;
                programRunner.programState = 2;
                surface.setTitle(projectData.projectName);

            }
        }
        
    }

    String[] parseDateField(String date) {
        String[] parts = split(date, "/");
        if (parts.length != 3) return new String[] {"Invalid date format"};
        return parts;
    }
    
    void mousedPressedEvent() {
        PVector m = new PVector(mouseX, mouseY);
        if (intersectRect(m, new PVector(x + mapPos.x, y + mapPos.y), floor(mapScl), floor(mapScl))) {
            if (mousePressed && mouseButton == RIGHT) {
                zoomableMap.startBox(m.x - x - mapPos.x, m.y - y - mapPos.y);
            } else {
                zoomableMap.startDrag(m.x, m.y);
            }
        }
    }
    
    void mouseDraggedEvent() {
        PVector m = new PVector(mouseX, mouseY);
        if (intersectRect(m, new PVector(x + mapPos.x, y + mapPos.y), floor(mapScl), floor(mapScl))) {
            if (zoomableMap.drawingBox) {
                zoomableMap.updateBox(m.x - x - mapPos.x, m.y - y - mapPos.y);
            } else {
                zoomableMap.drag(m.x, m.y, floor(mapScl), floor(mapScl));
            }
        }
    }
    
    void mouseReleasedEvent() {
        PVector m = new PVector(mouseX, mouseY);
        if (intersectRect(m, new PVector(x + mapPos.x, y + mapPos.y), floor(mapScl), floor(mapScl))) {
            if (zoomableMap.drawingBox) {
                zoomableMap.endBox();
            } else {
                zoomableMap.endDrag();
            }
        }
        
    }
    
    void mouseWheelEvent(float e) {
        PVector m = new PVector(mouseX, mouseY);
        if (intersectRect(m, new PVector(x + mapPos.x, y + mapPos.y), mapScl, mapScl)) {
            zoomableMap.handleScroll(e, m.x - x - mapPos.x, m.y - y - mapPos.y, floor(mapScl), floor(mapScl));
        }
    }
    
    
    //  ——————————————————————————————————————————————————————————————————————————————————  ||  SET
    
    public void setPosition(float x, float y) {
        this.x = x;
        this.y = y;
    }
    
    public void setSize(float w, float h) {
        this.w = w;
        this.h = h;
    }
    
    public void setPGraphics(PGraphics pg) {
        this.pg = pg;
    }
    
    
    //  ——————————————————————————————————————————————————————————————————————————————————  ||  GET
    
    public float getX() { return x; }
    public float getY() { return y; }
    public float getWidth() { return w; }
    public float getHeight() { return h; }
    public PGraphics getPGraphics() { return pg; } 
    
}

