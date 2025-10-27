package moves.status;

import ru.ifmo.se.pokemon.*;

public final class Rest extends StatusMove {
    public Rest() {
        super(Type.PSYCHIC, 0, 100);
    }

    @Override
    protected void applySelfEffects(Pokemon pokemon) {
        Effect effect = new Effect().stat(Stat.HP, 0).condition(Status.SLEEP).turns(2);
        pokemon.addEffect(effect);
    }

    @Override
    public String describe() {
        return "использует Rest";
    }
}
