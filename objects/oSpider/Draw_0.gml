/// oSpider Draw Event

// Flash white when hit
if (flash > 0) {
    shader_set(shWhite);
    draw_self();
    shader_reset();
} else {
    draw_self();
}

// Health bar position
var bar_y = y - sprite_get_bbox_top(sprite_index) - 12;
var bar_w = 40;
var bar_h = 5;

// Health ratio
var health_ratio = hp / hp_max;

// Draw background
draw_set_color(c_black);
draw_rectangle(x - bar_w / 2, bar_y, x + bar_w / 2, bar_y + bar_h, false);

// Draw fill
draw_set_color(merge_color(c_red, c_lime, health_ratio));
draw_rectangle(x - bar_w / 2 + 1, bar_y + 1, x - bar_w / 2 + bar_w * health_ratio - 1, bar_y + bar_h - 1, false);

// Reset color
draw_set_color(c_white);
