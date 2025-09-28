// ---------------------------
// Position and aim
x = oWizard.x + 3;
y = oWizard.y - 3;

image_angle = point_direction(x, y, mouse_x, mouse_y);

// ---------------------------
// Recoil and firing delay
firingdelay -= 1;
recoil = max(0, recoil - 1);

// ---------------------------
// Fire projectile if mouse pressed
if (mouse_check_button(mb_left) && firingdelay < 0) {
    
    firingdelay = 20; // frames between shots
    recoil = 4;
    
    // Use default layer for projectile
    var _proj = instance_create_layer(x, y, layer, oProjectile); 
    _proj.speed = 8;
    _proj.direction = image_angle + random_range(-3, 3);
    _proj.image_angle = _proj.direction;
}

// ---------------------------
// Apply recoil effect
x -= lengthdir_x(recoil, image_angle);
y -= lengthdir_y(recoil, image_angle);

// ---------------------------
// Flip sprite vertically if aiming backward
if (image_angle > 90 && image_angle < 270) {
    image_yscale = -1;
} else {
    image_yscale = 1;
}
