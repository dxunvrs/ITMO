package Characters;

import Technique.Rocket;

import java.util.Objects;

public class Shorty extends Character {

    public Shorty(String name) {
        super(name);
    }

    public void onBoard(Rocket rocket) {
        System.out.print(name + " погрузился в " + rocket.getName());
    }

    @Override
    public String toString() {
        return "Shorty " + name;
    }

    @Override
    public int hashCode() {
        return Objects.hash(name);
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof Shorty)) { return false; }
        if (o.hashCode() != hashCode()) { return false; }
        Shorty other = (Shorty) o;
        return other.name == name;
    }
}
