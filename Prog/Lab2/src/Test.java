import ru.ifmo.se.pokemon.*;
//import moves.*;
import pokemons.*;

public class Test {
    public static void main(String[] args) {
        Pokemon pokemon = new Pokemon("Test", 1);
        System.out.println(pokemon.getStat(Stat.ATTACK));
        pokemon.setMod(Stat.ATTACK, -1);
//        pokemon.setMod(Stat.HP, 2);
//        Effect effect = new Effect().stat(Stat.HP, (int) 2 / 2);
//        pokemon.addEffect(effect);
//        double maxHP = pokemon.getStat(Stat.HP);
//        double currentHP = pokemon.getHP();

//        System.out.println(pokemon.getHP());
    }
}
