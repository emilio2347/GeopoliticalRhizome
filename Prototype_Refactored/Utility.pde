boolean intersectRect(PVector a, PVector b, float bw, float bh) {
    if (a.x > b.x && a.x <= b.x + bw && a.y > b.y && a.y <= b.y + bh) {
        return true;
    } else {
        return false;
    }
}

boolean pointInPolygon(float x, float y, ArrayList<PVector> poly) {
  boolean inside = false;
  int n = poly.size();
  for (int i = 0, j = n - 1; i < n; j = i++) {
    float xi = poly.get(i).x, yi = poly.get(i).y;
    float xj = poly.get(j).x, yj = poly.get(j).y;

    boolean intersect = ((yi > y) != (yj > y)) &&
                        (x < (xj - xi) * (y - yi) / (yj - yi + 0.00001) + xi);
    if (intersect) inside = !inside;
  }
  return inside;
}

PVector parseLatLon(String coord) {
  String[] parts = split(trim(coord), ",");
  if (parts.length != 2) return null;
  float lon = float(trim(parts[0]));  // longitude first!
  float lat = float(trim(parts[1]));  // latitude second
  return new PVector(lon, lat);       // your code expects (lat, lon)
}


PVector latLonToPixel(float lat, float lon, float w, float h) {
  float x = (lon + 180.0) / 360.0;
  float sinLat = sin(radians(lat));
  float y = 0.5 - log((1 + sinLat) / (1 - sinLat)) / (4 * PI);
  x *= w;
  y *= h;
  return new PVector(x, y);
}




PVector pixelToLatLon(float x, float y, int w, int h) {
  float normX = x / w;  // [0,1] range
  float normY = y / h; // [0,1] range

  float lon = normX * 360.0 - 180.0;
  float latRad = PI * (1 - 2 * normY);
  float lat = degrees(asin(tanh(latRad)));

  return new PVector(lat, lon);
}

float tanh(float x) {
  float ex = exp(x);
  float exNeg = exp(-x);
  return (ex - exNeg) / (ex + exNeg);
}

PGraphics extractRegion(PGraphics source, PVector topLeft, PVector bottomRight) {
  int x = int(min(topLeft.x, bottomRight.x));
  int y = int(min(topLeft.y, bottomRight.y));
  int w = int(abs(bottomRight.x - topLeft.x));
  int h = int(abs(bottomRight.y - topLeft.y));

  PGraphics subset = createGraphics(w, h);
  subset.beginDraw();
  subset.image(source, -x, -y);  // Shift so target area is drawn at (0, 0)
  subset.endDraw();
  return subset;
}


Calendar DateToCalendar(Date date) {
    Calendar calendar = Calendar.getInstance();
    calendar.setTime(date);
    return calendar;
}

Date ISOToDate(String ISODate) {
    try {
        SimpleDateFormat isoFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
        return isoFormat.parse(ISODate);
    }
    catch(Exception e) {
        e.printStackTrace();
        return null;
    }
}

int calculateDaysBetween(String date1, String date2) {
    Date startDate = ISOToDate(date1);
    Date endDate = ISOToDate(date2);
    long diffInMillies = Math.abs(endDate.getTime() - startDate.getTime());
    long diffInDays = diffInMillies / (1000 * 60 * 60 * 24);
    return(int) diffInDays;
}

String getWeekDay(Calendar calendar) {
    return weekdayTitle(calendar.get(Calendar.DAY_OF_WEEK));
}

String weekdayTitle(int i) {
    String[] days = {"-", "Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"};
    return days[i];
}

String monthTitle(int i) {
    String[] months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "Novermber", "December"};
    return months[i];
}

int[] parseDate(String date) {
    int[] dateValues;
    String TZ = date.substring(19, date.length());
    String rawDate = date.substring(0, 19);
    dateValues = int(splitTokens(rawDate, "-T:"));
    if (TZ == "Z") TZ = "0";
    dateValues = append(dateValues, int(TZ));
    return dateValues;
}

String formatDate(int YYYY, int MM, int DD, int hh, int mm, int ss, int TZ) {
    String offsetMarker = "Z";
    if (TZ != 0) offsetMarker = nfp(TZ, 0);
    String formattedDate = nf(YYYY, 4) + "-" + nf(MM, 2) + "-" + nf(DD, 2) + "T" +
        nf(hh, 2) + "-" + nf(mm, 2) + "-" + nf(ss, 2) + offsetMarker;
    return formattedDate;
}



float sinh(float x) {
    return(exp(x) - exp( -x)) / 2.0;
}

String generateRandomID() {
    BigInteger BIntID = new BigInteger(128, random);
    return BIntID.toString(16);
}