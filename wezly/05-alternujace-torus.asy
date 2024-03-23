defaultpen(fontsize(12 pt));
settings.prc = false;


import graph3;

size(200,0);
currentprojection=orthographic(4,0,2);

//inner radius
real R=2;
//outer radius
real a=0.75;

//surface:
triple f(pair t) {
  return ((R+a*cos(t.y))*cos(t.x),(R+a*cos(t.y))*sin(t.x),a*sin(t.y));
}

//path:
real x(real t) {return cos(t*3)*(R + a*cos(t));}
real y(real t) {return sin(t*3)*(R + a*cos(t));}
real z(real t) {return a*sin(t);}

pen p=blue+opacity(0.33);
// make surface and path
surface s=surface(f,(0,0),(2pi,2pi),8,8,Spline);
path3 q=graph(x,y,z,0,6*pi,operator ..);

// draw surface and path
draw(s,surfacepen=material(diffusepen=blue+opacity(0.33), emissivepen=blue));
real linewidth = 2pt;
draw(q, p=linewidth + orange);
