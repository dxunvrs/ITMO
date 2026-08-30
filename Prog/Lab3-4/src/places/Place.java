package places;

import technique.Rocket;
import technique.RoomInAnotherRocketException;

import java.util.Objects;

public abstract class Place {
    protected String name;
    protected Rocket rocket;

    public Place(String name) {
        this.name = name;
    }

    public void setRocket(Rocket newRocket) {
        try {
            newRocket.addPlace(this);
            this.rocket = newRocket;
        }
        catch (RoomInAnotherRocketException e) {
            System.out.println(e.getMessage());
        }
    }

    public Rocket getRocket() {
        return rocket;
    }

    public String getName() {
        return name;
    }

    public void setName(String newName) {
        this.name = newName;
    }

    @Override
    public String toString() {
        return "Place " + name;
    }

    @Override
    public int hashCode() {
        return Objects.hash(name);
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof Place) || o.hashCode() != hashCode()) {
            return false;
        }
        Place other = (Place) o;
        return name.equals(other.name);
    }
}
