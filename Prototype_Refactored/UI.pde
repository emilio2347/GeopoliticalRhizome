interface Button{
    void render();
    void setPosition(float x, float y);
    void setSize(float w, float h);
    void setPGraphics(PGraphics pg);
    void setLabel(String label);
    void setActive(boolean active);
    
    float getX();
    float getY();
    float getWidth();
    float getHeight();
    String getLabel();
    PGraphics getPGraphics();
    boolean getActive();
}



class MainButton implements Button{
    float x, y, w, h;
    PGraphics pg;
    String label;
    boolean active;
    
    
    
    void render() {
        int activeVal = int(active); // 0 or 1 based on 'active'
        
        pg.pushMatrix();
        pg.translate(x, y);
        pg.stroke(0);
        pg.strokeWeight(1);
        pg.fill(255 * activeVal);
        pg.rect(0, 0, w, h);
        
        pg.fill(255 * (1 - activeVal));
        pg.noStroke();
        pg.textFont(mLight);
        pg.textAlign(CENTER, CENTER);
        pg.text(label, w / 2, h / 2);
        pg.popMatrix();
    }
    
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
    
    public void setLabel(String label) {
        this.label = label;
    }
    
    public void setActive(boolean active) {
        this.active = active;
    }
    
    public float getX() { return x; }
    public float getY() { return y; }
    public float getWidth() { return w; }
    public float getHeight() { return h; }
    public PGraphics getPGraphics() { return pg; } 
    public String getLabel() { return label; } 
    public boolean getActive() { return active; } 
    
}

class SmallButton implements Button{
    float x, y, w, h;
    PGraphics pg;
    String label;
    boolean active;
    
    
    
    void render() {
        int activeVal = int(active); // 0 or 1 based on 'active'
        
        pg.pushMatrix();
        pg.translate(x, y);
        pg.stroke(0);
        pg.strokeWeight(1);
        pg.fill(255 * activeVal);
        pg.rect(0, 0, w, h);
        
        pg.fill(255 * (1 - activeVal));
        pg.noStroke();
        pg.textFont(sLight);
        pg.textAlign(CENTER, CENTER);
        pg.text(label, w / 2, h / 2);
        pg.popMatrix();
    }
    
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
    
    public void setLabel(String label) {
        this.label = label;
    }
    
    public void setActive(boolean active) {
        this.active = active;
    }
    
    public float getX() { return x; }
    public float getY() { return y; }
    public float getWidth() { return w; }
    public float getHeight() { return h; }
    public PGraphics getPGraphics() { return pg; } 
    public String getLabel() { return label; } 
    public boolean getActive() { return active; } 
    
}

interface TextBoxInput{
    void render();
    void setPosition(float x, float y);
    void setSize(float w, float h);
    void setPGraphics(PGraphics pg);
    void setLabel(String label);
    void setPrompt(String prompt);
    void setInput(String input);
    void setActive(boolean active);
    void setInputting(boolean inputting);
    float getX();
    float getY();
    float getWidth();
    float getHeight();
    String getLabel();
    String getPrompt();
    String getInput();
    PGraphics getPGraphics();
    boolean getActive();
    boolean getInputting();
    
}

class TextInput implements TextBoxInput{
    
    float x, y, w, h;
    PGraphics pg;
    String label, prompt, input;
    boolean active, inputting;
    
    void render() {
        pg.pushMatrix();
        pg.translate(x, y);
        
        // Border
        pg.stroke(0);
        pg.strokeWeight(1 + max(int(inputting), int(active) * 0.25));
        pg.fill(255);
        pg.rect(0, 0, w, h);
        
        // Selector 
        float selectorScl = 4;
        pg.fill(0);
        
        if(inputting){pg.rect(- selectorScl, 0, selectorScl, selectorScl);}
        pg.noStroke();

        pg.textFont(sRegular);
        pg.textAlign(LEFT, BOTTOM);
        pg.text(label, 0, -4);
        
        pg.textAlign(LEFT);

        pg.textFont(sLight);
        if (input.length() >= 0 && inputting) {
            pg.fill(120.0 * norm(sin(float(frameCount) * 0.01), -1, 1));
            pg.text(input + "|", 4, 4, w, h);
        } else if (input.length() == 0 && !inputting) {
            pg.fill(120);
            pg.text(prompt, 4, 4, w, h);
            
        } else {
            pg.fill(40);
            pg.text(input , 4, 4, w, h);
            
        }
        
        
        
        
        pg.popMatrix();
        
    }
    
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
    
    public void setLabel(String label) {
        this.label = label;
    }
    
    public void setPrompt(String prompt) {
        this.prompt = prompt;
    }
    
    public void setInput(String input) {
        this.input = input;
    }
    
    public void setActive(boolean active) {
        this.active = active;
    }
    
    public void setInputting(boolean inputting) {
        this.inputting = inputting;
    }
    
    
    
    public float getX() { return x; }
    public float getY() { return y; }
    public float getWidth() { return w; }
    public float getHeight() { return h; }
    public PGraphics getPGraphics() { return pg; } 
    public String getLabel() { return label; } 
    public String getPrompt() { return prompt; } 
    public String getInput() { return input; } 
    public boolean getInputting() { return inputting; } 
    public boolean getActive() { return active; } 
}

class ZoomableMap {
    WorldMap worldMap;
    float zoom = 1;
    float offsetX = 0;
    float offsetY = 0;
    float prevMouseX, prevMouseY;
    boolean isDragging = false;
    PVector hoverCoord = new PVector(0, 0);
    boolean hovering = false;
    PVector boxStart = null;
    PVector boxEnd = null;
    boolean drawingBox = false;

    float viewWidth, viewHeight;

    ZoomableMap(WorldMap worldMap, float viewWidth, float viewHeight) {
        this.worldMap = worldMap;
        this.viewWidth = viewWidth;
        this.viewHeight = viewHeight;
        fitToBounds();
    }

    void fitToBounds() {
        if (!(worldMap instanceof WorldMapSubset)) return;

        WorldMapSubset subset = (WorldMapSubset) worldMap;

        PVector pMin = latLonToPixel(subset.minLatLon.x, subset.minLatLon.y, viewWidth, viewHeight);
        PVector pMax = latLonToPixel(subset.maxLatLon.x, subset.maxLatLon.y, viewWidth, viewHeight);

        float minX = min(pMin.x, pMax.x);
        float maxX = max(pMin.x, pMax.x);
        float minY = min(pMin.y, pMax.y);
        float maxY = max(pMin.y, pMax.y);

        float subsetW = maxX - minX;
        float subsetH = maxY - minY;

        float padding = 20;
        float zoomW = (viewWidth - 2 * padding) / subsetW;
        float zoomH = (viewHeight - 2 * padding) / subsetH;
        zoom = min(zoomW, zoomH);

        float centerX = (minX + maxX) / 2;
        float centerY = (minY + maxY) / 2;

        float canvasCenterX = viewWidth / 2;
        float canvasCenterY = viewHeight / 2;

        offsetX = canvasCenterX - centerX * zoom;
        offsetY = canvasCenterY - centerY * zoom;
    }

    void display(PGraphics pg, int w, int h) {
        pg.beginDraw();
        pg.background(255);
        pg.pushMatrix();
        pg.translate(offsetX, offsetY);
        pg.scale(zoom);

        ArrayList<ArrayList<ArrayList<PVector>>> countries = worldMap.countryPolygons;
        pg.stroke(0);
        pg.strokeWeight(0.25f / zoom);
        pg.noFill();
        for (ArrayList<ArrayList<PVector>> country : countries) {
            for (ArrayList<PVector> poly : country) {
                pg.beginShape();
                for (PVector pt : poly) {
                    pg.vertex(pt.x, pt.y);
                }
                pg.endShape(CLOSE);
            }
        }

        if (boxStart != null && boxEnd != null) {
            pg.stroke(255, 0, 0);
            pg.strokeWeight(1.0f / zoom);
            pg.noFill();

            float x = min(boxStart.x, boxEnd.x);
            float y = min(boxStart.y, boxEnd.y);
            float size = max(abs(boxEnd.x - boxStart.x), abs(boxEnd.y - boxStart.y));
            pg.rect(x, y, size, size);
        }

        pg.popMatrix();
        pg.endDraw();
    }

    void handleScroll(float e, float mx, float my, int viewW, int viewH) {
        float prevZoom = zoom;
        float factor = 1.05f;
        if (e > 0) {
            zoom *= factor;
        } else {
            zoom /= factor;
        }
        zoom = constrain(zoom, 1, 200);

        float scaleChange = zoom / prevZoom;
        offsetX = mx - (mx - offsetX) * scaleChange;
        offsetY = my - (my - offsetY) * scaleChange;
        clampOffset(viewW, viewH);
    }

    void updateHover(float x, float y) {
        float tx = (x - offsetX) / zoom;
        float ty = (y - offsetY) / zoom;
        hoverCoord.set(tx, ty);
        hovering = true;
    }

    void startBox(float x, float y) {
        drawingBox = true;
        boxStart = new PVector((x - offsetX) / zoom, (y - offsetY) / zoom);
        boxEnd = boxStart.copy();
    }

    void updateBox(float x, float y) {
        if (drawingBox && boxStart != null) {
            boxEnd = new PVector((x - offsetX) / zoom, (y - offsetY) / zoom);
        }
    }

    void endBox() {
        drawingBox = false;
        if (boxStart != null && boxEnd != null) {
            enforceSquareBox();
        }
    }

    void enforceSquareBox() {
        float dx = boxEnd.x - boxStart.x;
        float dy = boxEnd.y - boxStart.y;
        float size = max(abs(dx), abs(dy));
        boxEnd.x = boxStart.x + (dx >= 0 ? size : -size);
        boxEnd.y = boxStart.y + (dy >= 0 ? size : -size);
    }

    void resetView() {
        fitToBounds();
    }

    void startDrag(float x, float y) {
        isDragging = true;
        prevMouseX = x;
        prevMouseY = y;
    }

    void drag(float x, float y, int viewW, int viewH) {
        if (isDragging) {
            offsetX += x - prevMouseX;
            offsetY += y - prevMouseY;
            prevMouseX = x;
            prevMouseY = y;
            clampOffset(viewW, viewH);
        }
    }

    void endDrag() {
        isDragging = false;
    }

    void clampOffset(int viewW, int viewH) {
        float zoomedWidth = viewW * zoom;
        float zoomedHeight = viewH * zoom;

        float maxOffsetX = 0;
        float maxOffsetY = 0;
        float minOffsetX = min(0, viewW - zoomedWidth);
        float minOffsetY = min(0, viewH - zoomedHeight);

        offsetX = constrain(offsetX, minOffsetX, maxOffsetX);
        offsetY = constrain(offsetY, minOffsetY, maxOffsetY);
    }

    PVector clampLatLon(PVector latlon) {
        float lat = constrain(latlon.x, -85.0511f, 85.0511f);
        float lon = constrain(latlon.y, -180, 180);
        return new PVector(lat, lon);
    }
}
