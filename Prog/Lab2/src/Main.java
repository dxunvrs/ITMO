import ru.ifmo.se.pokemon.*;
import moves.*;
import pokemons.*;

public class Main {
    public static void main(String[] args) {
        Battle b = new Battle();
        Furfrou p1 = new Furfrou("Кубодед", 1);
        Pokemon p2 = new Pokemon("Карпов", 1);
        b.addAlly(p1);
        b.addFoe(p2);
        b.go();
    }
}


