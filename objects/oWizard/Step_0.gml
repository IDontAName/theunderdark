/// ----- Input -----
var key_left  = keyboard_check(vk_left)  || keyboard_check(ord("A"));
var key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var key_jump  = keyboard_check_pressed(vk_space);

// Horizontal movement
var move = key_right - key_left;
hsp = move * walksp;

// Apply gravity
vsp += grv;

// Ground check
var on_ground = place_meeting(x, y + 1, oWall);

// Jumping
if (key_jump && on_ground) {
    vsp = -jumpsp;
}

// ----------------------
// Horizontal Collision
if (place_meeting(x + hsp, y, oWall)) {
    while (!place_meeting(x + sign(hsp), y, oWall)) {
        x += sign(hsp);
    }
    hsp = 0;
}
x += hsp;

// Vertical Collision
if (place_meeting(x, y + vsp, oWall)) {
    while (!place_meeting(x, y + sign(vsp), oWall)) {
        y += sign(vsp);
    }
    vsp = 0;
}
y += vsp;

// ----------------------
// Animation
if (!on_ground) {
    sprite_index = WizardIdle;
    image_speed = 0;
    if (vsp > 0) image_index = 1; // falling
    else image_index = 0;          // jumping up
} else {
    if (hsp == 0) {
        sprite_index = WizardIdle;
    } else {
        sprite_index = WizardMove;
    }
    image_speed = 1;
}

// Flip sprite based on movement
if (hsp != 0) image_xscale = -sign(hsp);

// ----------------------
// Shooting
firingdelay = max(firingdelay - 1, 0);
recoil = max(recoil - 1, 0);

if (mouse_check_button(mb_left) && firingdelay <= 0) {
    firingdelay = 20; // frames between shots
    recoil = 4;

    var _proj = instance_create_layer(x, y, layer, oProjectile);
    _proj.speed = 8;
    _proj.direction = point_direction(x, y, mouse_x, mouse_y) + random_range(-3, 3);
    _proj.image_angle = _proj.direction;

    // Optional casting animation
    sprite_index = WizardCast;
    image_index = 0;
}

// Revert from casting animation
if (sprite_index == WizardCast && image_index >= image_number - 1) {
    sprite_index = WizardIdle;
    image_index = 0;
}

// ----------------------
// Health check
if (hp <= 0) {
    show_message("Game Over");
    game_end();
}
