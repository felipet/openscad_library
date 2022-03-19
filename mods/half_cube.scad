/*
 * module: half_cube
 *         This module generates a triangular prism taking a half of a
 *         cube defined by xy_dim and z_dim parameters. Using cut = 50,
 *         the cutting line will go from a vertex to the opposite one.
 *
 * author: Felipe Torres González<torresfelipex1@gmail.com>
 * date: 20220319
 * version: 1.0
 */
module half_cube( xy_dim, z_dim, cut = 50 ) {
    difference() {
        cube( [ xy_dim, xy_dim, z_dim ], center = true );
        rotate([0,0,45])
        translate([xy_dim*cut/100, 0, 0])
        cube( [ xy_dim, xy_dim*2, z_dim+4 ], center = true );
    }
}
