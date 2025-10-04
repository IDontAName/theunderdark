if (!variable_instance_exists(id, "speed")) speed = 6;
if (!variable_instance_exists(id, "direction")) direction = 0;

// Calculate horizontal and vertical speed from direction
hsp = lengthdir_x(speed, direction);
vsp = lengthdir_y(speed, direction);

// Set sprite orientation
image_angle = direction;

lifespan = 180; // destroy after 180 steps (3 seconds at 60 fps)

image_xscale = 3;
image_yscale = 3;