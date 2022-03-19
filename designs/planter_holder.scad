/*
 * planter_holder.scad
 * ===================
 *
 * This design aims to be used as a holder for yogurt containers. In Spain, regular
 * yogurt containers are perfect for growing seeds. The idea is to have some sort
 * of structure that can hold many of this things to build a seedbed.
 *
 * author: Felipe Torres González<torresfelipex1@gmail.com>
 * date: 20220319
 * version: 1.0
 */

use <../mods/half_cube.scad>

/*
 * Generic parameters
 * ==================
 *
*/
// Dimension tolerance. Applied to all dimensions that interact with external objects.
g_TOLERANCE = 0.5;
// X&Y Scaling factor. Easily scale the entire model along X&Y axis.
g_XYSCALE_FACTOR = 1.0;

/*
 * Planter shape
 * =============
 * 
 * Define the dimensions of the planter.
 *
 */
// External diameter of the planter
plt_external_d = 56;
// Border size of the wings (minimum)
plt_border = 5;

/*
 * Holder definitions
 *
 */
// Borders height of the object
hldr_border_ht = 3.5;
// X size of the lateral wings
hldr_xwing_size = plt_border + 2;
// Y size of the lateral wings
hldr_ywing_size = plt_border + 15;

/*
 * Customization of the Y wings
 */
// Size of the bevel
bevel_cube_size = 15;
// Distance from the X wing border to the start of the bevel
hldr_corner = 6;


/* 
 * ADJUST(x): Applies the tolerance value and the scaling factor
 */

function XYADJUST(x) = (x + g_TOLERANCE) * g_XYSCALE_FACTOR;
function ZADJUST(x) = (x + g_TOLERANCE);

/*
 * module: holder_shaper
 *         This module defines the shape of the cut to be given to the
 *         Y wing of the plant holder. 
 *         Requires the module `half_cube`.
 */
module holder_shaper ( length, width, heigth, cut = 50 ) {
    union() {
        color("grey", 1.0)
        translate([
            -length+width/2,
            0,
            0])
        rotate([0,0,90])
        half_cube(width,heigth+2);

        color("grey", 1.0)
        translate([
            length-width/2,
            0,
            0])
        rotate([0,0,0])
        half_cube(width,heigth+2);

        color("grey", 1.0)
        translate([0,0,0])
        cube([
            length*2-width*2+0.5, 
            width, 
            heigth+2], 
            center = true);
    }
}




i_plt_external_d = XYADJUST(plt_external_d);
i_hldr_border_ht = ZADJUST(hldr_border_ht);
i_hldr_xwing_size = XYADJUST(hldr_xwing_size);
i_hldr_ywing_size = XYADJUST(hldr_ywing_size);

$fn = 50;


i_hldr_external_x_size = i_plt_external_d + i_hldr_xwing_size * 2;
i_hldr_external_y_size = i_plt_external_d + i_hldr_ywing_size * 2;
i_half_holder_x_size = i_hldr_external_x_size/2;
i_half_holder_y_size = i_hldr_external_y_size/2;

difference() {
    // Part design
    cube([i_hldr_external_x_size,
          i_hldr_external_y_size,
          i_hldr_border_ht], 
          center = true
    );
    
    i_bevel_cube_size = bevel_cube_size;
    i_hldr_corner = hldr_corner;

    // Ghost part: planter
    color("grey", 1.0)
    cylinder(h = i_hldr_border_ht+4, r = i_plt_external_d/2, center = true);

    translate([0,-i_half_holder_y_size+i_bevel_cube_size/2, 0])
    holder_shaper( i_half_holder_x_size-i_hldr_corner, 
                   i_bevel_cube_size+1, 
                   hldr_border_ht );

    translate([0,i_half_holder_y_size-i_bevel_cube_size/2, 0])
    rotate([0,0,180])
    holder_shaper( i_half_holder_x_size-i_hldr_corner, 
                   i_bevel_cube_size+1, 
                   hldr_border_ht );   
}
