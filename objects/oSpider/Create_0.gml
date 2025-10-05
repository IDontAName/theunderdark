// --- Movement + physics ---
hsp = 0;
vsp = 0;
grv = 0.4;
move_speed = 2;
jump_strength = -9;

// --- Combat / AI ---
hp_max = 6;
hp = hp_max;
dying = false;
player = noone;
slam_active = false;
slam_damage_done = false;
jump_timer = irandom_range(30, 60);
flash = 0;

// --- Sprite ---
sprite_index = SpiderIdle;
image_speed = 0.3;
image_xscale = 1;
