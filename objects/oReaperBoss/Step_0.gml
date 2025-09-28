vsp = vsp + grv;

//Horiz collisions
if (place_meeting(x+hsp,y,oWall))
{
	while (!place_meeting(x+sign(hsp),y,oWall))
	{
		x = x + sign(hsp);
	}
	hsp = 0;
}

x = x + hsp;

//Verti collisions
if (place_meeting(x,y+vsp,oWall))
{
	while (!place_meeting(x,y+sign(vsp),oWall))
	{
		y = y + sign(vsp);
	}
	vsp = 0;
}

y = y + vsp;

//Animation
if (!place_meeting(x,y+1,oWall))
{
	sprite_index = ReaperIdle2;
	image_speed = 0;
	if (sign(vsp) > 0) image_index = 1; else image_index = 0
//this is gonna be jump
}
else
{
	image_speed = 1
	if (hsp == 0)
	{
		sprite_index = ReaperIdle2;
	}
	else
	{
		sprite_index = ReaperWalk
	}
}

if (hsp != 0) image_xscale = -sign(hsp);

// ---------------------------
// Random strolling AI
// ---------------------------
stroll_timer -= 1;

if (stroll_timer <= 0) {
    stroll_dir = choose(-1, 0, 1);
    stroll_timer = irandom_range(60, 180); // stroll for 1–3 seconds
}

// Move boss horizontally
hsp = stroll_dir * move_speed;

// collisions with walls
if (place_meeting(x + hsp, y, oWall)) {
    hsp = 0; // stop moving into walls
}

x += hsp;

// ---------------------------
// target player AI
// ---------------------------
var _player = instance_nearest(x, y, oWizard);
if (_player != noone) {
    if (x < _player.x - 50) hsp = move_speed;
    else if (x > _player.x + 50) hsp = -move_speed;
}

// ---------------------------
// Shooting at player
// ---------------------------
shoot_timer -= 1;
if (shoot_timer <= 0 && _player != noone) {
    var _proj = instance_create_layer(x, y, "Instances", oEProjectile);
    
    // Calculate direction
    var dx = _player.x - x;
    var dy = _player.y - y;
    var dist = sqrt(dx*dx + dy*dy);
    
    _proj.hsp = dx / dist * 6; // projectile speed 6
    _proj.vsp = dy / dist * 6;
    
    shoot_timer = shoot_cooldown; // reset cooldown
}
if (hp <= 0) {
    //spawn death animation, etc.
    
    // Immediately switch the room
    room_goto(Level2); 

    instance_destroy(); // destroy the enemy
}

