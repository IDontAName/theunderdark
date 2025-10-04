// Move projectile
x += hsp;
y += vsp;

// Optional: lifespan
lifespan -= 1;
if (lifespan <= 0) instance_destroy();
