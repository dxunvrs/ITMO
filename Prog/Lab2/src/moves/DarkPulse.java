package moves;

import ru.ifmo.se.pokemon.*;

public class DarkPulse extends SpecialMove {
    public DarkPulse() {
        super(Type.DARK, 80, 1.0);
    }

    @Override
    protected void applyOppEffects(Pokemon pokemon) {
        Effect effect = new Effect().chance(0.2);
        effect.flinch(pokemon);
    }

    @Override
    public String describe() {
        return "использует Dark Pulse";
    }
}
