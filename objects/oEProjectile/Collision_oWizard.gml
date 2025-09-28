// Collision with Wizard
if (variable_instance_exists(other, "hp")) {
    other.hp -= 1;    // reduce health
    instance_destroy(); // destroy projectile
}
