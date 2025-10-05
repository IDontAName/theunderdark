/// oSpider Step Event

// =========================
// --- Death handling ---
// =========================
if (hp <= 0) {
    if (!dying) {
        dying = true;
        hsp = 0;
        vsp = 0;
        sprite_index = SpiderDeath;
        image_speed = 0.4;
        image_index = 0;
        alarm[0] = sprite_get_number(SpiderDeath) * 2;
    }
    exit;
}

// =========================
// --- Gravity ---
// =========================
vsp += grv;
vsp = clamp(vsp, -12, 12);

// =========================
// --- Move horizontally ---
// =========================
if (!place_meeting(x + hsp, y, oWall)) {
    x += hsp;
} else {
    while (!place_meeting(x + sign(hsp), y, oWall)) {
        x += sign(hsp);
    }
    hsp = 0;
}

// =========================
// --- Move vertically ---
// =========================
if (!place_meeting(x, y + vsp, oWall)) {
    y += vsp;
} else {
    var landed = (vsp > 0);
    while (!place_meeting(x, y + sign(vsp), oWall)) {
        y += sign(vsp);
    }
    vsp = 0;

    if (landed) {
        if (slam_active && !slam_damage_done) {
            var target = instance_nearest(x, y, oWizard);
            if (target != noone) {
                if (target.y > y && abs(target.x - x) < 40) {
                    if (variable_instance_exists(target, "hp")) target.hp -= 1;
                }
            }
            slam_damage_done = true;
        }

        slam_active = false;
        sprite_index = SpiderIdle;
        image_speed = 0.3;
    }
}

// =========================
// --- Targeting AI ---
// =========================
player = instance_nearest(x, y, oWizard);
if (player == noone) exit;

// Face player
image_xscale = (player.x < x) ? -1 : 1;

// =========================
// --- Jump logic ---
// =========================
if (place_meeting(x, y + 1, oWall)) {
    jump_timer--;
    if (jump_timer <= 0) {
        var dx = player.x - x;
        var dy = player.y - y;

        // Jump power tuned
        var jump_x = clamp(dx * 0.08, -move_speed * 2.2, move_speed * 2.2);
        var jump_y = jump_strength;

        hsp = jump_x;
        vsp = jump_y;
        sprite_index = JumpSpider;
        image_speed = 0.5;

        slam_active = true;
        slam_damage_done = false;

        jump_timer = clamp(irandom_range(25, 65) - (abs(dx) / 50), 20, 80);
    }
}

// =========================
// --- Ground movement sprite ---
// =========================
if (place_meeting(x, y + 1, oWall) && !slam_active) {
    if (abs(hsp) > 0.5) {
        sprite_index = SpiderWalk;
        image_speed = 0.4;
    } else {
        sprite_index = SpiderIdle;
        image_speed = 0.3;
    }
}

// =========================
// --- Flash when hit ---
// =========================
if (flash > 0) flash--;
