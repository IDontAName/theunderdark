hsp = 0;
vsp = 0;
grv = 0.2;
move_speed = 4;

hp = 13
flash = 0;
image_xscale = 1;
image_yscale = 1;

// AI timers
stroll_timer = 0;        // time left in current strolling direction
shoot_timer = 0;         // cooldown for shooting
shoot_cooldown = 90;     // frames between shots

// Movement target
stroll_dir = choose(-1, 0, 1); // -1 = left, 0 = stand still, 1 = right

// Jump
jump_speed = -5; // negative for upward movement
on_ground = false;

// Stuck detection
last_x = x;
stuck_timer = 0;