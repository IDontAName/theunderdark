// Movement
move_speed = 2;
hsp = 0;
vsp = 0;
grv = 0.3;
// Spider health
hp = 5;       // starting health
hp_max = 5;   // maximum health
// Flash effect (used for hit effect)
flash = 0;

// AI
stroll_dir = choose(-1, 0, 1);
stroll_timer = 0;

// Jump (optional)
jump_speed = -5;
on_ground = false;
last_x = x;
d
// Shooting
shoot_timer = 0;
shoot_cooldown = 90; // frames between shots

// Sprites
sprite_index = SpiderIdle;
image_speed = 1;
