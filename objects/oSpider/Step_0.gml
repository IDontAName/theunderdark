// ---------------------------
// Apply gravity
vsp += grv;

// ---------------------------
// Random strolling
stroll_timer -= 1;
if (stroll_timer <= 0) {
    stroll_dir = choose(-1, 0, 1);
    stroll_timer = irandom_range(60, 180);
}

hsp = stroll_dir * move_speed;

// ---------------------------
// Horizontal collisions
if (place_meeting(x + hsp, y, oWall)) {
    hsp = 0;
}
x += hsp;

// ---------------------------
// Vertical collisions
if (place_meeting(x, y + vsp, oWall)) {
    while (!place_meeting(x, y + sign(vsp), oWall)) {
        y += sign(vsp);
    }
    vsp = 0;
    on_ground = true;
} else {
    y += vsp;
    on_ground = false;
}

// ---------------------------
// Stuck detection: jump if blocked
if (on_ground && x == last_x && stroll_dir != 0) {
    vsp = jump_speed; // jump over obstacle
}

// ---------------------------
// Shooting AI
var _player = instance_nearest(x, y, oWizard);
shoot_timer -= 1;

if (_player != noone && shoot_timer <= 0) {
    // Shoot projectile
    var dx = _player.x - x;
    var dy = _player.y - y;
    var dist = sqrt(dx*dx + dy*dy);

    var _proj = instance_create_layer(x, y, "Instances", oEProjectile);
    _proj.hsp = dx / dist * 6;
    _proj.vsp = dy / dist * 6;

    shoot_timer = shoot_cooldown;

    sprite_index = ReaperAttack;
    image_index = 0;
    image_speed = 1;
} 
else if (on_ground) {
    // Switch back to idle or walk
    sprite_index = (hsp == 0) ? ReaperIdle2 : ReaperWalk;
    image_speed = 1;
}

// ---------------------------
// Flip sprite based on movement
if (hsp != 0) image_xscale = -sign(hsp);

last_x = x;
