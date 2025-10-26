package moves.special;

import ru.ifmo.se.pokemon.*;

public final class MegaDrain extends SpecialMove {
    public MegaDrain() {
        super(Type.GRASS, 40, 100);
    }

    @Override
    protected void applySelfDamage(Pokemon pokemon, double damage) {
        Effect effect = new Effect().stat(Stat.HP, (int) damage / 2);
        pokemon.addEffect(effect);
    }

    @Override
    public String describe() {
        return "использует Mega Drain";
    }
}
