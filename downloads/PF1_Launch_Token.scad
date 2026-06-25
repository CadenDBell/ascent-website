// ============================================================
//  ASCENT  -  PF-1 "Grace" Launch Token   (hexagonal badge)
//  Top to bottom:  two chevrons  /  ASCENT  /  PF-1 (centre)  /
//  "Grace"  /  @ascent.aerospace.  Logo rebuilt natively
//  (chevrons = real polygons, text = real 3D text) - the original
//  SVG can't import into OpenSCAD.  Needs NO external file.
//
//  STL with no install: OpenSCAD web playground
//  (search "OpenSCAD playground", e.g. ochafik.com/openscad2) ->
//  paste this whole file -> export STL.  Print flat, no supports.
// ============================================================

/* [Body] */
hex_w     = 46;    // hexagon width, point to point (mm)
thickness = 4;     // token thickness (mm)
chamfer   = 1.2;   // bevelled edge (mm)
emboss    = 0.8;   // raised detail height (mm)

/* [Text] */
title    = "PF-1";
wordmark = "ASCENT";
subtitle = "\"Grace\"";          // displays as:  "Grace"
handle   = "@ascent.aerospace";

$fn = 120;

s = hex_w / 336;   // scale from the logo's 400x400 artboard

// logo geometry, centred (Y up): [ (x-200), (200-y) ]
hexpts   = [ [0,186],[168,103],[168,-103],[0,-186],[-168,-103],[-168,103] ];
chevpts  = [ [0,125],[110,-15],[80,-15],[0,83],[-80,-15],[-110,-15] ];  // outer
chevpts2 = [ [0,80],[90,-35],[65,-35],[0,38],[-65,-35],[-90,-35] ];     // inner

module hex2d() { polygon([ for (p = hexpts ) [p[0]*s, p[1]*s] ]); }
module chevA() { polygon([ for (p = chevpts ) [p[0]*s, p[1]*s] ]); }
module chevB() { polygon([ for (p = chevpts2) [p[0]*s, p[1]*s] ]); }

module body() {
    hull() {
        linear_extrude(thickness) offset(r = -chamfer) hex2d();
        translate([0,0,chamfer]) linear_extrude(thickness - 2*chamfer) hex2d();
    }
}

module label(txt, sz, y, bold=true) {
    translate([0, y, thickness])
        linear_extrude(emboss)
            text(txt, size = sz, halign = "center", valign = "center",
                 font = bold ? "Liberation Sans:style=Bold" : "Liberation Sans");
}

union() {
    body();
    translate([0, 11.6, thickness])                 // two chevrons (top)
        linear_extrude(emboss) scale([0.4, 0.4]) { chevA(); chevB(); }
    label(wordmark, 5,    6,  true);                // ASCENT
    label(title,    9,   -2,  true);                // PF-1  (centre)
    label(subtitle, 4.5, -10, true);                // "Grace"
    label(handle,   2.3, -16, false);               // @ascent.aerospace
}
