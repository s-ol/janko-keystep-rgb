range = [ 0 : 11 ];

base_pos = [-66.68750, -28.00167 - 3.5, 6];
key_names = ["C", "Cs", "D", "Ds", "E", "F", "Fs", "G", "Gs", "A", "As", "B"];

* translate([0, 0, 10])
import("source/Keycap.stl", convexity=3);

for (i = range)
  key(i);

step_x = 24.245 / 2;
step_y = 42.00223 / 2;
function mountpos(i, row) =
    base_pos +
    [
        step_x * i,
        step_y * (row + i % 2),
        0
    ];

module ledspace(upper, depth) {
    rotate([0,0,45]) {
        // cut a 2mm hole for the LED to rest in
        cube([3.75, 3.55, 4], center=true);

        difference() {
            // 3.3x3.x3mm shaft for cables
            cube([3.3, 3.3, upper ? 42 : 32], center=true);

            // little bridge to hold LED
            translate([0, 0, -2.01 - 1.5/2])
                cube([1.5, 4, 1.5], center=true);
        }
    };

    translate([0, upper ? -2 : 2, -13.5 + depth * 2])
        cube([3.1, 5, 3], center=true);
}

module key(i) {
    difference() {
        import(str("source/Key ", key_names[i], ".stl"), convexity=3);

        translate(mountpos(i, 0))
          ledspace(false, i % 2);
        translate(mountpos(i, 2))
          ledspace(true, 2 + i % 2);
    }
}
