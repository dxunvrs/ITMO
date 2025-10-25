package moves;

import ru.ifmo.se.pokemon.*;

public class Rest extends StatusMove {
    public Rest() {
        super(Type.PSYCHIC, 0, 100);
    }

    @Override
    protected void applySelfEffects(Pokemon pokemon) {
        double maxHP = pokemon.getStat(Stat.HP);
        Effect effect = new Effect().condition(Status.SLEEP).turns(2).stat(Stat.HP, (int) maxHP);
        pokemon.addEffect(effect);
    }

    @Override
    public String describe() {
        return "использует Rest";
    }
}
