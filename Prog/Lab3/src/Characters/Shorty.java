package Characters;

import Technique.Rocket;

import java.util.Objects;

public class Shorty extends Character {

    public Shorty(String name) {
        super(name);
    }

    public void onBoard(Rocket rocket) {
        rocket.addPassengers(this);
        System.out.println(name + " погрузился в " + rocket.getName());
    }

    @Override
    public String toString() {
        return "Shorty " + name;
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof Shorty) || o.hashCode() != hashCode()) { return false; }
        Shorty other = (Shorty) o;
        return name.equals(other.name);
    }
}
