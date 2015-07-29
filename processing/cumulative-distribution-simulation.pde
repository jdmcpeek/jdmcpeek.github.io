// A visualization of the cumulative normal distribution. Drag the mouse to change the x 
// position along the axis. This will update both the density function and the cumulative
// distribution function. Emphasize that the cumulative function is merely the integral of 
// the density function.

// with higher standard deviations, the cumulative distribution function will not quite 
// reach 1.0 because there is still a non-negligible chance of an occurence outside of the
// x-axis bounds (on the outer levels of the standard deviation)

// features to add:
// 1. (done) the ability to alter the standard deviation. The plots should scale 
//    accordingly. 
// 2. code readability for reproducibility
// 3. rewrite code to work outside of the KA development environment; use it as a showcase on //    Github

int axis_x = 140;  // where the x-axis will be located for top graph
int axis_y = 200;
int length_x = 200;  // the length of the x-axis in pixels
int length_y = 90;
int cumulative_axis;  // x-axis for bottom graph
int center = 200;  // more descriptive
float variance = 1;         
float sd = 1;
int num_deviations = 10;  // number of deviations from 0 we're covering on both sides
float mean = 0; 
float dx = 200;
ArrayList<Float> integral;
boolean update = false;
float lever = 492;  // initial location of the lever. This will represent a standard dev. of 1 
ArrayList<float[]> cur = createCurve(); 


void setup() {
  size(900, 900);
  frameRate(30);
  frame.setResizable(true);
}

float ScaleX(float i) {
    // helper function to stretch actual x-values to pixel values
    return i * ((sd * num_deviations) / length_x);
}; 

float ScaleY(float y) {
    // helper function to stretch actual y-values to pixel values
    // divide by 0.5 because the scale only runs up to 0.5
    return y * (length_y / 0.5); 
};

float normal_dist(float x, float variance, float mean) {
    float principle = 1 / (variance * sqrt(2 * (float) Math.PI));
    float exponent = -1 * pow((x - mean), 2) / (2 * pow(variance, 2));
    return principle * pow((float) Math.E, exponent); 
}

ArrayList<float[]> createCurve() {
    // multi-dimensional array of line coordinates
    // patch together the lines to create a curve effect 
    ArrayList<float[]> cur = new ArrayList();
    float y = axis_y - 100;
    for (int i = 0; i < length_x; i++) {
        float[] lineSeg = {   y+i, 
                    axis_x, y+i, 
                    axis_x - ScaleY(normal_dist(ScaleX(i + y - center), variance, mean))
                };
        cur.add(lineSeg);
    }
    return cur;
};




void UpdateDist() {
    // normal_dist = CreateNormalFunc(variance, mean);
    cur = createCurve();
    update = false;   // reset `update` back to false when called
}; 

// float quadratic = function(x) {
//   return (pow(x, 2) + 0.5*x);   
// };


float AreaTrapezoid(float s1, float s2) {
    int height = 1;  // just so you know... we're doing it in pixels
    return height * ((s1 + s2) / 2);
};


ArrayList<Float> ApproximateIntegral(float bound, int total_length) {
    // approximates the integral under a curve by splitting the curve into many 
    // small trapezoids and adding up their areas 
    
    // an array of the areas under each pixel-length segment of the normal curve
    ArrayList<Float> integral = new ArrayList();  
    float area; 

    for (float i = -sd * (num_deviations/2); i <= ScaleX(bound - 200); i += ScaleX(1)) {
        area = AreaTrapezoid(normal_dist(i, variance, mean), normal_dist(i + ScaleX(1), variance, mean));
        integral.add(ScaleX(area));
    }
    return integral;
    
};


boolean OnBar() {
    // check if the mouse is near the normal curve for manipulation 
    return mouseY < height/2 - 80;
};

boolean OnLever() {
    // check if the mouse is near the lever for sd manipulation
    return (mouseY < 440 && mouseY > 380 &&
            mouseX < 662 && mouseX > 468);
}; 

void mouseDragged() {
    if (OnBar()) {
        dx = constrain(mouseX, 200, 600);
    }
    if (OnLever()) {
        lever = mouseX;
        float lever_start = 470;
        float lever_length = 194; 
        // variance can go from -1 to 4, so that's 5 units total
        variance = ((lever - lever_start + 26) / lever_length) * 4; 
        sd = sqrt(variance);
        update = true;
    }
};




void draw() {
    scale(2.0);
    background(255);
    // draw the axes
    stroke(0);
    line(axis_y,50, axis_y, axis_x);  // y-axis top
    line(axis_y - 120, 30, axis_y - 120, axis_x - 1);  // y-axis top
    line(80, axis_x, 320, axis_x);  // x-axis top
    line(axis_y - 120, 250, axis_y - 120, axis_x + 210);  // y-axis bottom
    line(80, axis_x + 211, 320, axis_x + 211);  // x-axis bottom
    textSize(13);
    text(String.valueOf((float) round(sd * -(num_deviations/2) * 100) / 100), 90, axis_x + 5, 50, 30); // x-topleft
    text("0", 194, axis_x + 5, 50, 30); // origin-topleft
    text(String.valueOf((float) round(sd * (num_deviations/2) * 100) / 100), 290, axis_x + 5, 50, 30); // x-topright
    text("0.0", 55, axis_x - 11, 50, 30);  // y-topleft
    text("0.5", 55, axis_x - 94, 50, 23);  // y-topright
    text("0", 67, 340, 50, 30);  // y-bottomleft
    text("1.0", 58, 250, 50, 38);  // y-topleft
    text(String.valueOf((float) round(sd * -(num_deviations/2) * 100) / 100), 99, axis_x + 219, 50, 30); // x-bottomleft
    text("0", 194, axis_x + 217, 50, 30); // origin-bottomleft
    text(String.valueOf((float) round(sd * (num_deviations/2) * 100) / 100), 290, axis_x + 217, 50, 30); // x-bottomright
    
    // label axes
    textSize(10);
    text("(density)", 55, 16, 50, 30);
    text("(x)", 326, 136, 50, 30);
    text("(probability)", 52, 235, 70, 30);
    text("(x)", 326, 346, 50, 30);
    
    // titles
    textSize(13);
    text("Probability density function", 125, 161, 201, 210);
    text("Cumulative distribution function", 119, 380, 300, 200);
    
    // some stats
    fill(251, 255, 0);
    rect(50, 188, 300, 36, 30);
    rect(281, 10, 107, 70, 30);
    fill(0);
    text("standard deviation = " + String.valueOf((float) round(sd * 100) / 100), 65, 200, 190, 17);
    
    // the lever to change the standard deviation
    line(235, 206, 330, 206);
    rect(lever/2, 196, 5, 20,20);
    
    // more stats in the topright box
    text("x = " + String.valueOf((float) round(ScaleX(dx/2-200) * 100)/100), 308, 24, 168, 20);
    text("density = " + String.valueOf((float) round(normal_dist(ScaleX(dx/2 - 200), variance, mean) * 100)/100), 291, 50, 100, 30);
    
    // update distribution function and curve if needed
    if (update) {
        UpdateDist(); 
    }
    
    strokeWeight(1); 
    
    // paint the curve
    for (int i = 0; i < cur.size(); i++) {
        if (cur.get(i)[0] < dx/2 -1) {
            stroke(27, 46, 212);
        } else {
            stroke(255, 255, 255);
        }
    
        line(cur.get(i)[0], cur.get(i)[1], cur.get(i)[2], cur.get(i)[3]);
        stroke(0); 
        strokeWeight(1.5);
        point(cur.get(i)[2], cur.get(i)[3]);
    }
    
    // color the integral bar yellow
    stroke(232, 232, 14);
    strokeWeight(4);
    

    // create the yellow integral bar to manipulate the area under the normal curve
    line(dx/2, axis_x, dx/2, axis_x - ScaleY(normal_dist(ScaleX(dx/2 - 200), variance, mean)));
    integral = ApproximateIntegral(dx/2, 200);
    fill(0);
    textSize(12);
    float cum_dist = 0;
    for(Float d : integral) {
        cum_dist += d;
    }

    textSize(12);
    
    // print current density value following the yellow integral bar
    if (dx/2 <= 200) {
        // keep on the left
        text(String.valueOf((float) round(normal_dist(ScaleX(dx/2 - 200), variance, mean) * 100)/100), dx/2 - 24, 
             axis_x - 20 - ScaleY(normal_dist(ScaleX(dx/2 - 200), variance, mean)), 109, 75);
    } else {
        // keep on the right
         text(String.valueOf((float) round(normal_dist(ScaleX(dx/2 - 200), variance, mean) * 100)/100), dx/2, 
             axis_x - 20 - ScaleY(normal_dist(ScaleX(dx/2 - 200), variance, mean)), 109, 75);
    }
    
    
    strokeWeight(2);
    stroke(245, 61, 5);
    int j = 0;
    float cum_so_far = 0;
    // create the integral curve based on the points we get from ApproximateIntegral
    int icurve = 0; 
    for (; icurve < dx/2 - 100; icurve++) {
        // add up the area "so far": at the current x-value and below
        cum_so_far += integral.get(icurve);  
        // simulate a curve with many points and scale using ScaleY
        point(icurve + 100 , -(ScaleY(cum_so_far)/2) + 350);
    }
    text(cum_dist, icurve + 104, -(ScaleY(cum_so_far)/2) + 350);
    
};







