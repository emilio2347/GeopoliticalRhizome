
Module[] modules;
Module[] introModules; 
PGraphics introGraphics, newProjectGraphics;
PGraphics socialGraphics, spatialGraphics, temporalGraphics; 
ProjectData projectData;
WorldMap worldMap;





class Entity {
    String id;
    String label;
    PVector location; // null if non-spatial
    String category;
    String description;
}

class Event {
    String id;
    String label;
    String timestamp; // ISO 8601
    PVector location; // optional
    String description;
}

class Connection{
    String sourceId;
    String targetId;
    String type;
}

class WorldMap {
    JSONObject geojson;
    JSONArray features;
    ArrayList<ArrayList<ArrayList<PVector>>> countryPolygons = new ArrayList<>();

    int hoveredIndex = -1;

    WorldMap() {
        init();
    }

    void init() {
        loadGeoData();
    }

    void loadGeoData() {
        geojson = loadJSONObject("mapGeoJSON.geojson");
        features = geojson.getJSONArray("features");
    }

    void initGeometry(float w, float h) {
        for (int i = 0; i < features.size(); i++) {
            JSONObject feature = features.getJSONObject(i);
            JSONObject geometry = feature.getJSONObject("geometry");
            String type = geometry.getString("type");

            ArrayList<ArrayList<PVector>> country = new ArrayList<>();

            if (type.equals("Polygon")) {
                country.add(processPolygon(geometry.getJSONArray("coordinates"), w, h));
            } else if (type.equals("MultiPolygon")) {
                JSONArray polygons = geometry.getJSONArray("coordinates");
                for (int j = 0; j < polygons.size(); j++) {
                    country.add(processPolygon(polygons.getJSONArray(j), w, h));
                }
            }
            countryPolygons.add(country);
        }
    }

    PGraphics getMap(float w, float h) {
        initGeometry(w, h);
        PGraphics pg = createGraphics(floor(w), floor(h), P2D);
        pg.beginDraw();
        pg.background(255);

        pg.stroke(0);
        pg.strokeWeight(0.25);
        pg.noFill();

        for (int i = 0; i < countryPolygons.size(); i++) {
            ArrayList<ArrayList<PVector>> country = countryPolygons.get(i);
            for (ArrayList<PVector> poly : country) {
                pg.beginShape();
                for (PVector pt : poly) pg.vertex(pt.x, pt.y);
                pg.endShape(CLOSE);
            }
        }
        pg.endDraw();
        return pg;
    }

    ArrayList<PVector> processPolygon(JSONArray rings, float w, float h) {
        ArrayList<PVector> screenRing = new ArrayList<>();

        for (int i = 0; i < rings.size(); i++) {
            JSONArray ring = rings.getJSONArray(i);
            for (int j = 0; j < ring.size(); j++) {
                JSONArray coord = ring.getJSONArray(j);
                float lon = coord.getFloat(0);
                float lat = coord.getFloat(1);
                screenRing.add(latLonToPixel(lat, lon, w, h));
            }
        }

        return screenRing;
    }

    PGraphics getSubset(PVector latlonA, PVector latlonB, float fullMapW, float fullMapH) {
        PVector p1 = latLonToPixel(latlonA.x, latlonA.y, fullMapW, fullMapH);
        PVector p2 = latLonToPixel(latlonB.x, latlonB.y, fullMapW, fullMapH);

        int x = floor(min(p1.x, p2.x));
        int y = floor(min(p1.y, p2.y));
        int w = ceil(abs(p1.x - p2.x));
        int h = ceil(abs(p1.y - p2.y));

        PGraphics fullMap = getMap(fullMapW, fullMapH);
        PGraphics subset = createGraphics(w, h, P2D);
        subset.beginDraw();
        subset.image(fullMap, -x, -y);
        subset.endDraw();
        return subset;
    }

}

class WorldMapSubset extends WorldMap {
    PVector minLatLon;
    PVector maxLatLon;

    WorldMapSubset(PVector latlonA, PVector latlonB, float w, float h) {
        minLatLon = new PVector(min(latlonA.x, latlonB.x), min(latlonA.y, latlonB.y));
        maxLatLon = new PVector(max(latlonA.x, latlonB.x), max(latlonA.y, latlonB.y));

        loadGeoData();
        extractSubset(w, h);
    }

    void extractSubset(float w, float h) {
        for (int i = 0; i < features.size(); i++) {
            JSONObject feature = features.getJSONObject(i);
            JSONObject geometry = feature.getJSONObject("geometry");
            String type = geometry.getString("type");

            ArrayList<ArrayList<PVector>> country = new ArrayList<>();

            if (type.equals("Polygon")) {
                ArrayList<PVector> ring = parsePolygonToScreen(geometry.getJSONArray("coordinates"), w, h);
                if (!ring.isEmpty()) country.add(ring);
            } else if (type.equals("MultiPolygon")) {
                JSONArray polygons = geometry.getJSONArray("coordinates");
                for (int j = 0; j < polygons.size(); j++) {
                    ArrayList<PVector> ring = parsePolygonToScreen(polygons.getJSONArray(j), w, h);
                    if (!ring.isEmpty()) country.add(ring);
                }
            }

            if (!country.isEmpty()) countryPolygons.add(country);
        }
    }

    ArrayList<PVector> parsePolygonToScreen(JSONArray rings, float w, float h) {
        ArrayList<PVector> screenRing = new ArrayList<>();

        for (int i = 0; i < rings.size(); i++) {
            JSONArray ring = rings.getJSONArray(i);
            for (int j = 0; j < ring.size(); j++) {
                JSONArray coord = ring.getJSONArray(j);
                float lon = coord.getFloat(0);
                float lat = coord.getFloat(1);
                screenRing.add(latLonToPixel(lat, lon, w, h));
            }
        }
        return screenRing;
    }
}

//  ——————————————————————————————————————————————————————————————————————————————————  ||  PROJECT DATA

class ProjectData {
    ArrayList<Entity> entities;
    ArrayList<Event> events;
    ArrayList<Connection> connections;
    String projectName;
    String projectDescription;
    String startDate;
    String endDate;
    String startBB;
    String endBB;
    
    ProjectData() {
        entities = new ArrayList<Entity>();
        events = new ArrayList<Event>();
        connections = new ArrayList<Connection>();
    }
}

void saveProjectData(String filename) {
    JSONObject json = new JSONObject();
    JSONArray entitiesArr = new JSONArray();
    JSONArray eventsArr = new JSONArray();
    JSONArray connectionsArr = new JSONArray();
    
    for (Entity e : projectData.entities) {
        JSONObject o = new JSONObject();
        o.setString("id", e.id);
        o.setString("label", e.label);
        o.setString("category", e.category);
        o.setString("description", e.description);
        if (e.location != null) {
            o.setFloat("x", e.location.x);
            o.setFloat("y", e.location.y);
        }
        entitiesArr.append(o);
    }
    
    for (Event ev : projectData.events) {
        JSONObject o = new JSONObject();
        o.setString("id", ev.id);
        o.setString("label", ev.label);
        o.setString("timestamp", ev.timestamp);
        o.setString("description", ev.description);
        if (ev.location != null) {
            o.setFloat("x", ev.location.x);
            o.setFloat("y", ev.location.y);
        }
        eventsArr.append(o);
    }
    
    for (Connection c : projectData.connections) {
        JSONObject o = new JSONObject();
        o.setString("sourceId", c.sourceId);
        o.setString("targetId", c.targetId);
        o.setString("type", c.type);
        connectionsArr.append(o);
    }
    
    json.setJSONArray("entities", entitiesArr);
    json.setJSONArray("events", eventsArr);
    json.setJSONArray("connections", connectionsArr);
    json.setString("projectName", projectData.projectName);
    json.setString("projectDescription", projectData.projectDescription);
    json.setString("startDate", projectData.startDate);
    json.setString("endDate", projectData.endDate);
    json.setString("startBB", projectData.startBB);
    json.setString("endBB", projectData.endBB);
    saveJSONObject(json, filename);
}

void loadProjectData(String filename) {
    JSONObject json = loadJSONObject(filename);
    if (json == null) return;
    projectData = new ProjectData();
    projectData.projectName = json.getString("projectName", "");
    projectData.projectDescription = json.getString("projectDescription", "");

    projectData.startDate = json.getString("startDate", "");
    projectData.endDate = json.getString("endDate", "");

    projectData.startBB = json.getString("startBB", "");
    projectData.endBB = json.getString("endBB", "");
    
    JSONArray entitiesArr = json.getJSONArray("entities");
    for (int i = 0; i < entitiesArr.size(); i++) {
        JSONObject o = entitiesArr.getJSONObject(i);
        Entity e = new Entity();
        e.id = o.getString("id");
        e.label = o.getString("label");
        e.category = o.getString("category");
        e.description = o.getString("description");
        if (o.hasKey("x") && o.hasKey("y")) {
            e.location = new PVector(o.getFloat("x"), o.getFloat("y"));
        }
        projectData.entities.add(e);
    }
    
    JSONArray eventsArr = json.getJSONArray("events");
    for (int i = 0; i < eventsArr.size(); i++) {
        JSONObject o = eventsArr.getJSONObject(i);
        Event ev = new Event();
        ev.id = o.getString("id");
        ev.label = o.getString("label");
        ev.timestamp = o.getString("timestamp");
        ev.description = o.getString("description");
        if (o.hasKey("x") && o.hasKey("y")) {
            ev.location = new PVector(o.getFloat("x"), o.getFloat("y"));
        }
        projectData.events.add(ev);
    }
    
    JSONArray connectionsArr = json.getJSONArray("connections");
    for (int i = 0; i < connectionsArr.size(); i++) {
        JSONObject o = connectionsArr.getJSONObject(i);
        Connection c = new Connection();
        c.sourceId = o.getString("sourceId");
        c.targetId = o.getString("targetId");
        c.type = o.getString("type");
        projectData.connections.add(c);
    }
}