if (variable_instance_exists(other, "hp")) {
    other.hp -= 1; // damage player
    instance_destroy(); // destroy projectile
}
