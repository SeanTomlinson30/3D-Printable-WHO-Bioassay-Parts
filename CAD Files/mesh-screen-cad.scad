$fn=36*2;

// A hollow tube
module tube(orad,irad,height) {

   difference() {
      cylinder( r=orad,h=height);
      translate([0,0,-1]) cylinder( r=irad,h=height+2);
   }

}

// Grid
module grid(width,length,strand, gap,do_offset) {//

   wh = width / 2;
   lh = length / 2;

   for ( ix = [-wh:strand+gap:wh]) {
	translate([-lh,ix,0]) cube([length,strand,strand]) ;
   }

   for ( iy = [-lh:strand+gap:lh]) {
	if (do_offset=="yes") {
		translate([iy,-wh,strand]) cube([strand,width,strand]) ;
	} else {
		translate([iy,-wh,0]) cube([strand,width,strand]) ;
	}
   }


}

// Module  : Sieve
// Params :
// 	od = Outer Dia of the cylinder
// 	strand = thickness of grid strands
// 	gap = gap between strands
// 	rim_thick=thickness of outer rim
// 	rim_height=height of outer rim
// 	do_offset=offset the strands ("yes" or "no")
//
module sieve(od,strand,gap,rim_thick,rim_height,do_offset) {
	
	or=od/2;
	
	difference() {
		grid(od,od,strand, gap,do_offset);
		translate([0,0,-1]) tube(od,or,rim_height+2);
	}
	tube(or,or-rim_thick,rim_height);
}

// test
sieve(45,
0.5,
1.5,
2,
1,
"yes");