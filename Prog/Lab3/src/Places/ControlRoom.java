package Places;

import Characters.Shorty;
import Distance.SpaceObjects;

public class ControlRoom extends Place {
    public ControlRoom(String name) {
        super(name);
    }

    public void changeTarget(Shorty character, SpaceObjects newTarget) {
        if (rocket == null) {
            System.out.println("Помещение не в ракете!");
            return;
        }
        if (!rocket.getPassengers().contains(character)) {
            System.out.println(character.getName() + " не в ракете!");
            return;
        }
        if (newTarget.getEarthDistanceInKilometers() == -1) {
            System.out.println(character.getName() + " не смог поменять цель");
            return;
        }
        try {
            this.getRocket().setTarget(newTarget);
            System.out.println(character.getName() + " поменял цель ракеты на " + newTarget.getName());
        }
        catch (TargetFarAwayException e) {
            System.out.println(character.getName() + " пытался поменять цель ракеты на " + newTarget.getName() + ", но");
            System.out.println(e.getMessage());
        }
    }

    @Override
    public String toString() {
        return "ControlRoom " + name;
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof ControlRoom) || o.hashCode() != hashCode()) {
            return false;
        }
        ControlRoom other = (ControlRoom) o;
        return name.equals(other.name);
    }
}
