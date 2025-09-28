var key_left  = keyboard_check(vk_left) || keyboard_check(ord("A"));
var key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var key_jump  = keyboard_check_pressed(vk_space);


//Calculate movement
var move = key_right - key_left;

hsp = move * walksp;

vsp = vsp + grv;
if (place_meeting(x,y+1,oWall)) && (key_jump)
{
	vsp = -7;
}


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
	sprite_index = WizardIdle;
	image_speed = 0;
	if (sign(vsp) > 0) image_index = 1; else image_index = 0
//this is gonna be jump
}
else
{
	image_speed = 1
	if (hsp == 0)
	{
		sprite_index = WizardIdle;
	}
	else
	{
		sprite_index = WizardMove
	}
}

if (hsp != 0) image_xscale = -sign(hsp);

//TESTING
// Only trigger if left mouse clicked and not already casting
if (mouse_check_button_pressed(mb_left))
{
    sprite_index = WizardCast;  // switch to casting animation
    image_index = 0;                 // start from first frame
}

// If currently casting, check if animation finished
if (sprite_index == WizardCast) {
    if (image_index >= image_number - 1) {
        sprite_index = WizardIdle; // revert to idle sprite
        image_index = 0;               // start idle animation from frame 0
    }
}
if (hp <= 0) {
    // Game Over
    show_message("Game Over"); // or use a Game Over room
    game_end();                // stops the game
}

/////////////////////////////////////
// -------------------
// Handle firing
firingdelay -= 1;
recoil = max(0, recoil - 1);

if (mouse_check_button(mb_left) && firingdelay <= 0) {
    firingdelay = 20; // delay between shots
    recoil = 4;

    var _proj = instance_create_layer(x, y, layer, oProjectile);
    _proj.speed = 8;
    _proj.direction = point_direction(x, y, mouse_x, mouse_y) + random_range(-3,3);
    _proj.image_angle = _proj.direction;
}

// Flip wizard sprite based on aim
if (point_direction(x, y, mouse_x, mouse_y) > 90 &&
    point_direction(x, y, mouse_x, mouse_y) < 270) {
    image_yscale = -1;
} else {
    image_yscale = 1;
}