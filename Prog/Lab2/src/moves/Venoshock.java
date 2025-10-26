package moves;

import ru.ifmo.se.pokemon.*;

public final class Venoshock extends SpecialMove {
    public Venoshock() {
        super(Type.POISON, 65, 100);
    }

    @Override
    protected void applyOppDamage(Pokemon pokemon, double damage) {
        Status condition = pokemon.getCondition();
        if (condition == Status.POISON) {
            pokemon.setMod(Stat.HP, -2 * (int) damage);
        }
    }

    @Override
    public String describe() {
        return "использует Venoshock";
    }
}
