// ----------------------
// Death handling
if (hp <= 0 && !dying) {
    dying = true;
    hsp = 0;
    vsp = 0;
    sprite_index = ReaperDeath;
    image_index = 0;
    alarm[0] = 30;       // switch room after death
    exit;
}

// ----------------------
// Apply gravity
vsp += grv;
vsp = clamp(vsp, -10, 10);

// ----------------------
// Pixel-perfect horizontal movement
var hsp_abs = abs(hsp);
for (var i = 0; i < hsp_abs; i++) {
    // Stop if colliding with wall or player hitbox
    if (!place_meeting(x + sign(hsp), y, oWall) &&
        !place_meeting(x + sign(hsp), y, oWizard)) {
        x += sign(hsp);
    } else {
        hsp = 0;
        break;
    }
}

// Pixel-perfect vertical movement
var vsp_abs = abs(vsp);
for (var i = 0; i < vsp_abs; i++) {
    if (!place_meeting(x, y + sign(vsp), oWall)) y += sign(vsp);
    else {
        vsp = 0;
        break;
    }
}

// ----------------------
// Nearest player
var player_inst = instance_nearest(x, y, oWizard);

// ----------------------
// Reduce cooldowns
if (attack_cool_timer > 0) attack_cool_timer -= 1;
if (proj_cool_timer > 0) proj_cool_timer -= 1;

// ----------------------
// Determine distance
var dist = noone;
if (player_inst != noone) dist = point_distance(x, y, player_inst.x, player_inst.y);

// ----------------------
// Attack FSM logic
if (!dying && player_inst != noone) {
    // Start melee attack if in range and cooldown ready
    if (!attacking && dist <= melee_range && attack_cool_timer <= 0) {
        attacking = true;
        attack_timer = 0;
        damage_done = false;
        sprite_index = ReaperAttack;
        attack_target = player_inst;
    }
    // Projectile attack if in mid-range
    else if (!attacking && dist <= 300 && dist > melee_range && proj_cool_timer <= 0) {
        var _proj = instance_create_layer(x, y - sprite_height/4, layer, oEProjectile);
        _proj.direction = point_direction(_proj.x, _proj.y, player_inst.x, player_inst.y);
        _proj.speed = 6;
        _proj.image_angle = _proj.direction;
        proj_cool_timer = proj_cooldown;
    }
}

// ----------------------
// Handle melee attack animation
if (attacking) {
    attack_timer += 1;

    // Deal damage once at start
    if (!damage_done && attack_target != noone &&
        point_distance(x, y, attack_target.x, attack_target.y) <= melee_range &&
        variable_instance_exists(attack_target, "hp")) 
    {
        attack_target.hp -= 1;
        damage_done = true;
    }

    // Allow movement toward player while attacking, but stop at player hitbox
    if (player_inst != noone) {
        if (!place_meeting(x + ((player_inst.x < x) ? -move_speed : move_speed), y, oWizard)) {
            hsp = (player_inst.x < x) ? -move_speed : move_speed;
        } else {
            hsp = 0; // stop at player's hitbox
        }

        // Jump if blocked and player is above
        if (place_meeting(x + sign(hsp), y, oWall) && (player_inst.y < y - 4)) {
            vsp = jump_speed;
        }
    }

    // Finish attack animation
    if (attack_timer >= sprite_get_number(sprite_index)) {
        attacking = false;
        attack_cool_timer = attack_cooldown;
    }
}

// ----------------------
// Chasing (when not attacking)
if (!attacking && player_inst != noone) {
    if (dist > melee_range) {
        if (!place_meeting(x + ((player_inst.x < x) ? -move_speed : move_speed), y, oWizard)) {
            hsp = (player_inst.x < x) ? -move_speed : move_speed;
        } else {
            hsp = 0; // stop at player's hitbox
        }

        // Jump if blocked and player is above
        if (place_meeting(x + sign(hsp), y, oWall) && (player_inst.y < y - 4)) {
            vsp = jump_speed;
        }
    } else {
        hsp = 0;
    }
}

// ----------------------
// Animation handling
if (!attacking) {
    if (!place_meeting(x, y + 1, oWall)) {
        sprite_index = ReaperIdle;
        if (vsp > 0) image_index = 1; // falling
        else image_index = 0;         // jumping
    } else {
        if (hsp == 0) sprite_index = ReaperIdle;
        else sprite_index = ReaperWalk;
    }
}

// ----------------------
// Flip sprite only when moving
if (abs(hsp) > 0.1) image_xscale = -sign(hsp);
