package pokemons;

import moves.*;

public class Clawitzer extends Clauncher {
    public Clawitzer(String name, int level) {
        super(name, level);
        setStats(71, 73, 88, 120, 89, 59);
        addMove(new ShadowBall());
    }
}
