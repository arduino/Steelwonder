// Author: Antonio Navarro
// URL: http://www.thingiverse.com/AntonioNav/
//
// Licencia: CC BY-SA 3.0
//  http://creativecommons.org/licenses/by-sa/3.0/
//

use <Includes/nuts_and_bolts.scad>
use <Includes/roundCornersCube.scad>

$fn=50;

//***********************************************************//
//***** Use 'to_print_part1' and 'to_print_part2' ***********//
//***** to generate stl files.                    ***********//

//to_show();
to_print();
//to_print_part1(); 
//to_print_part2(); 

module to_show(){
	color("orange"){
		back_support();
		bed();
	}
	color("gray"){
		varillas();
	}
	color("green"){
		translate([35,-2-1.5,19.1])
			rotate([90,0,0])
				stopper();
	translate([35,5.1,30])
		rotate([90,0,0])
			endstop_support();
	}
}

module to_print(){
	to_print_part1();
	translate([30,0,0])
		to_print_part2();	
}

module to_print_part1(){
	translate([0,0,2])
	rotate([0,180,0])
	stopper();
}

module to_print_part2(){
	translate([0,0,(16.85)/2])
		rotate([0,90,0])
			endstop_support();
}

module clamp(long=12.85, alt=3.9){

	translate([-long/2,-2,0])
	union(){
		translate([0,0,alt-0.1])
			difference(){
				cube([long,3,3]);
				translate([-1,4,0])
					rotate([45,0,0])
						cube([long+2,2.5,6]);
			}
		translate([0,0,0])
			cube([long,1.5,alt]);
	}

}

module endstop_support(){
	long=13.85;
	width=5.75;
	alt=6.65;
	sep=14.65;

	union(){
		translate([0,width/2+1,0])
			cube([long+3,2,sep], center=true);
		translate([0,(width+3)/2,sep/2-2])
			rotate([-90,0,0])
				clamp(long+3);
		rotate([0,180,0])
		translate([0,(width+3)/2,sep/2-2])
			rotate([-90,0,0])
				clamp(long+3);

	translate([long/2-0.5,(width+0.1)/2,0])
		rotate([0,-90,90])
			clamp(sep,width+0.2);

	rotate([0,180,0])
	translate([long/2-0.5,(width+0.1)/2,0])
		rotate([0,-90,90])
			clamp(sep,width+0.2);
	
//support for print
	translate([0,-width/2-0.5,0])
		cube([long,1,sep], center=true);
	}

}

module endstop(long=12.85, width=5.75, alt=6.65){
	color("black")
		cube([long,width,alt], center=true);
}


module varillas(){
	translate([85,100,24])
		rotate([90,0,0])
			cylinder(d=8,h=200, center=true);
	translate([-85,100,24])
		rotate([90,0,0])
			cylinder(d=8,h=200, center=true);
}

module stopper(){

		difference(){
			base_square();
			//Taladro tornillo M3
			hull(){
				translate([0,-8,0])
					cylinder(d=3, h=11, center=true);
				translate([0,-25,0])
					cylinder(d=3, h=11, center=true);
			}

/*			hull(){
				translate([0,-8,1])
					cylinder(r=3.2, h=2.4);
				translate([0,-25,1])
					cylinder(r=3.2, h=2.4);
			}
*/
			hull(){
				translate([0,-8,-3.4])
					rotate([0,0,30])
						nutHole(3);
				translate([0,-25,-3.4])
					rotate([0,0,30])
						nutHole(3);
			}
		}
}

module base_square(alt=4, diam=3){
	hull(){
		translate([10,2,0])
				cylinder(d=diam, h=alt, center=true);
		translate([-10,2,0])
				cylinder(d=diam, h=alt, center=true);
		translate([10,6,0])
				cylinder(d=diam, h=alt, center=true);
		translate([-10,6,0])
				cylinder(d=diam, h=alt, center=true);
	}
	hull(){
		translate([10,2,0])
				cylinder(d=diam, h=alt, center=true);
		translate([-10,2,0])
				cylinder(d=diam, h=alt, center=true);
		translate([3,-11,0])
				cylinder(d=diam, h=alt, center=true);
		translate([-3,-11,0])
				cylinder(d=diam, h=alt, center=true);
	}

	hull(){
		translate([3,-11,0])
				cylinder(d=diam, h=alt, center=true);
		translate([-3,-11,0])
				cylinder(d=diam, h=alt, center=true);
		translate([3,-30,0])
				cylinder(d=diam, h=alt, center=true);
		translate([-3,-30,0])
				cylinder(d=diam, h=alt, center=true);
	}
}

module back_support(){
	translate([-140.5,-1.5,32])
			rotate([-90,0,0])
				linear_extrude(height=3)
					import("./Includes/Frontal_y_Trasero.dxf");
}

module bed(){

	translate([0,85,36.5]){
		bed_base();
		bed_supports();
	}
}
	
module bed_base(){

		rotate([0,0,-90])
			translate([-122.5,-109.5,-1.5])
				linear_extrude(height=3)
					import("./Includes/Base_cama.dxf");
}

module bed_supports(){
	translate([85,-35,-1.5])
		rotate([0,180,0])
			rotate([0,0,90]){
				i2_y_bushing();
				translate([-1.5,0,3.5])
				rotate([0,0,90])
					bearing();
		}

	translate([85,35,-1.5])
		rotate([0,180,0])
			rotate([0,0,90]){
				i2_y_bushing();
				translate([-1.5,0,3.5])
				rotate([0,0,90])
					bearing();
		}

	translate([-85,-35,-1.5])
		rotate([0,180,0])
			rotate([0,0,90]){
				i2_y_bushing();
				translate([-1.5,0,3.5])
				rotate([0,0,90])
					bearing();
		}

	translate([-85,35,-1.5])
		rotate([0,180,0])
			rotate([0,0,90]){
				i2_y_bushing();
				translate([-1.5,0,3.5])
				rotate([0,0,90])
					bearing();
		}

}

module i2_y_bushing(){
		rotate([0,0,90])
					import("./Includes/Pieza_Final (Meshed).stl");
}

module bearing(){
	translate([0,0,7.5])
		rotate([90,0,0])
			translate([0,0,-12])
					import("./Includes/PrintableBearing_M8.stl");
}
