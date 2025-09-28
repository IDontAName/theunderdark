// Step Event
if (done == 0) {
    // Apply gravity
    vsp += grv;

    // Horizontal collision
    if (place_meeting(x + hsp, y, oWall)) {
        while (!place_meeting(x + sign(hsp), y, oWall)) {
            x += sign(hsp);
        }
        hsp = 0;
    }
    x += hsp;

    // Vertical collision
    if (place_meeting(x, y + vsp, oWall)) {
        if (vsp > 0) {
            // Landed on the ground
            while (!place_meeting(x, y + sign(vsp), oWall)) {
                y += sign(vsp);
            }
            vsp = 0;

            // Switch to death state
            done = 1;
            sprite_index = ReaperDeath; 
            image_index = 0;
            image_speed = 1;   // play fast
        } else {
            vsp = 0;
        }
    } else {
        y += vsp;
    }

} else if (done == 1) {
    // Death state: lock in place
    hsp = 0;
    vsp = 0;

    // Don’t do any more collision checks after death
    // Just play the anim in place

    if (image_index >= image_number - 1) {
        instance_destroy();
    }
}
