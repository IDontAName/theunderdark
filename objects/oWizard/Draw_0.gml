// Draw the wizard normally
draw_self();

// ----------------------
// Top-left HP bar
var bar_width = 200;       // full width
var bar_height = 20;       // height
var bar_x = 20;            // X position
var bar_y = 20;            // Y position

// Background (dark gray)
draw_set_color(c_black);
draw_rectangle(bar_x-2, bar_y-2, bar_x + bar_width + 2, bar_y + bar_height + 2, false);

// Health ratio
var health_ratio = clamp(hp / hp_max, 0, 1);

// Smooth gradient: green → yellow → red
var bar_color;
if (health_ratio > 0.5) {
    // Green → Yellow
    var t = (health_ratio - 0.5) * 2; // 0 → 1
    bar_color = make_color_rgb(lerp(255, 0, t), 255, 0); // R,G,B
} else {
    // Yellow → Red
    var t = health_ratio * 2; // 0 → 1
    bar_color = make_color_rgb(255, lerp(0, 255, t), 0);
}

// Draw health bar
draw_set_color(bar_color);
draw_rectangle(bar_x, bar_y, bar_x + bar_width * health_ratio, bar_y + bar_height, false);

// Border
draw_set_color(c_white);
draw_rectangle(bar_x-2, bar_y-2, bar_x + bar_width + 2, bar_y + bar_height + 2, true);

// Reset color
draw_set_color(c_white);
