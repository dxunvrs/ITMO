package pokemons;

import ru.ifmo.se.pokemon.*;
import moves.*;

public class Furfrou extends Pokemon {
    public Furfrou(String name, int level) {
        super(name, level);
        setType(Type.NORMAL);
        setStats(75, 80, 60, 65, 90, 102);
        setMove(new Facade(), new Refresh(), new DarkPulse(), new Rest());
    }
}
