$fn = 50;

//add ~0.5mm factor to hole diameters for 3d printing
r_motor = (0.4+20)/2; //radius of circular part
flat_part = (0.4+15)/2; //center to flat line distance
r_nail = (2.37+.5)/2; //original, 3.4mm

border = 2;
thickness = 3; //How thick you want the linear extrude of this part
//NOTE THIS SEEMS GOOD, PRINT A GOOD PAIR AND TEST
gear_distance = 1.5+36-2.44/2-1.98/2;
padding = 14; //controls how much material you want on the bottom (under motor) needs to be adjusted so it is flat bottom at padding=0

rect1 = gear_distance + r_nail + border;

module motorshape () {
	intersection() {
		polygon([[-100,-flat_part],[100,-flat_part],[100,flat_part],[-100,flat_part]]);
		circle(r_motor);
	}
}

module motorshapeborder () {
	intersection() {
		polygon([[-100,-(flat_part+border)],[100,-(flat_part+border)],[100,(flat_part+border)],[-100,(flat_part+border)]]);
		circle(r_motor+border);
	}
}

module innerholes () {
	motorshape();
	translate([gear_distance,0,0]) {circle(r_nail);}
	translate([-5,-11,0]) {circle(2);}
	translate([5,-11,0]) {circle(2);}
}

module mainbody() {
	linear_extrude(height=thickness) {
		difference() {
			hull() {
				union () {
					motorshapeborder();
					translate([gear_distance,0,0]) { circle(r_nail+border); }
					polygon([[-(r_motor+border),-padding],[-(r_motor+border),0],[rect1,0],[rect1,-padding]]);
				}
			}
			innerholes();	
		}
	}
}


mainbody();
