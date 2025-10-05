if (instance_exists(global.target)) {
    // Smoothly follow the player
    var targetX = global.target.x - global.baseW / 2;
    var targetY = global.target.y - global.baseH / 2;
    
    view_xview[0] = lerp(view_xview[0], targetX, global.cam_lerp);
    view_yview[0] = lerp(view_yview[0], targetY, global.cam_lerp);
}

// Letterboxing / viewport scaling
var dispW = display_get_width();
var dispH = display_get_height();

var scale = min(dispW / global.baseW, dispH / global.baseH);

var wport = floor(global.baseW * scale);
var hport = floor(global.baseH * scale);

view_set_wport(0, wport);
view_set_hport(0, hport);

// Center the viewport on screen
view_set_xport(0, (dispW - wport) div 2);
view_set_yport(0, (dispH - hport) div 2);
