// ----------------------
// Draw Reaper sprite with flash effect
if (flash > 0) {
    shader_set(shWhite);
    draw_self();
    shader_reset();
    flash--;
} else {
    draw_self();
}

// ----------------------
// Floating health bar above Reaper
var bar_width = 80;               // smaller width
var bar_height = 10;              // slightly thinner
var bar_x = x - bar_width / 2;    // center above Reaper
var bar_y = y - sprite_get_bbox_top(sprite_index) - 50; 

// Background (dark gray)
draw_set_color(c_black);
draw_rectangle(bar_x-2, bar_y-2, bar_x + bar_width + 2, bar_y + bar_height + 2, false);

// Health ratio
var health_ratio = clamp(hp / 13, 0, 1); // max hp = 13

// Gradient: Green → Yellow → Red
var bar_color;
if (health_ratio > 0.5) {
    var t = (health_ratio - 0.5) * 2; // 0 → 1
    bar_color = make_color_rgb(lerp(0, 255, 1-t), 255, 0); // green → yellow
} else {
    var t = health_ratio * 2; // 0 → 1
    bar_color = make_color_rgb(255, lerp(0, 255, t), 0); // yellow → red
}

// Draw health bar
draw_set_color(bar_color);
draw_rectangle(bar_x, bar_y, bar_x + bar_width * health_ratio, bar_y + bar_height, false);

// Border
draw_set_color(c_white);
draw_rectangle(bar_x-2, bar_y-2, bar_x + bar_width + 2, bar_y + bar_height + 2, true);

// Reset color
draw_set_color(c_white);
