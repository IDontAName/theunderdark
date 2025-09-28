// Draw wizard normally
draw_self();

// HP bar settings
var bar_width = 40;    // width of the full bar
var bar_height = 6;    // height of the bar
var bar_x = x - bar_width/2; // center above wizard
var bar_y = y - sprite_height/2 - 10; // slightly above sprite

// Draw background (gray)
draw_set_color(c_gray);
draw_rectangle(bar_x, bar_y, bar_x + bar_width, bar_y + bar_height, false);

// Draw health (red)
draw_set_color(c_red);
draw_rectangle(bar_x, bar_y, bar_x + bar_width * (hp / hp_max), bar_y + bar_height, false);

// Reset color
draw_set_color(c_white);
