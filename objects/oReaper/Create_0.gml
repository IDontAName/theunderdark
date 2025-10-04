// ----------------------
// Physics & movement
hsp = 0;
vsp = 0;
grv = 0.15;
move_speed = 2;
jump_speed = -4;

// ----------------------
// Health
hp = 13;
flash = 0;

// ----------------------
// Sprite scale
image_xscale = 1;
image_yscale = 1;

// ----------------------
// Attack / Melee
attacking = false;
attack_timer = 0;
attack_speed = 0.15;       // fps for attack animation
attack_frame_hit = 7;      // frame where melee hit occurs
melee_range = 40;
stop_distance = 10;        // distance to stop in front of player
attack_cooldown = 30;      // frames between melee attacks
attack_cool_timer = 0;

// ----------------------
// Projectile attack
proj_cooldown = 60;        // frames between projectiles
proj_cool_timer = 0;

// ----------------------
// FSM / State
state = "idle";

// ----------------------
// Death
dying = false;