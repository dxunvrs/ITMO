package moves;

import ru.ifmo.se.pokemon.*;

public class Refresh extends StatusMove {
    public Refresh() {
        super(Type.NORMAL, 0, 0);
    }

    @Override
    protected void applySelfEffects(Pokemon pokemon) {
        Status condition = pokemon.getCondition();
        if (condition == Status.BURN || condition == Status.POISON || condition == Status.PARALYZE) {
            Effect effect = new Effect().condition(Status.NORMAL);
            pokemon.setCondition(effect);
        }
    }

    @Override
    public String describe() {
        return "использует Refresh";
    }
}
