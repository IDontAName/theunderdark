with (other) {
    if (variable_instance_exists(self, "hp")) {
        hp -= 1;
        flash = 3;
    }
}
instance_destroy();
