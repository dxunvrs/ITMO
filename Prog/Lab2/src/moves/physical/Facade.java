package moves.physical;

import ru.ifmo.se.pokemon.*;

public final class Facade extends PhysicalMove{
    public Facade() {
        super(Type.NORMAL, 70, 100);
    }

    @Override
    protected void applySelfEffects(Pokemon pokemon) {
        Status condition = pokemon.getCondition();
        if (condition == Status.BURN || condition == Status.POISON || condition == Status.PARALYZE) {
            double currentAtk = pokemon.getStat(Stat.ATTACK);
            Effect effect = new Effect().stat(Stat.ATTACK, (int) currentAtk * 2);
            pokemon.addEffect(effect);
        }
    }

    @Override
    protected String describe() {
        return "использует Facade";
    }
}
