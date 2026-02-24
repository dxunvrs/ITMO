package places;

import characters.Shorty;

public class EngineRoom extends Place {
    public EngineRoom(String name) {
        super(name);
    }

    public void checkEngine(Shorty character) {
        if (rocket == null) {
            System.out.println("Помещение не в ракете!");
            return;
        }
        if (!rocket.getPassengers().contains(character)) {
            System.out.println(character.getName() + " не в ракете!");
            return;
        }
        System.out.println(character.getName() + " осматривает двигатель ракеты: ");
        long currentTime = System.currentTimeMillis();
        long timeDelta = currentTime - rocket.getEngine().getTimeOfLastCheck();
        if (timeDelta < 5) {
            System.out.println("Двигатель в отличном состоянии");
        } else if (timeDelta < 15) {
            System.out.println("Двигатель в оптимальном состоянии");
        } else {
            System.out.println("Двигателю требуется ремонт");
        }
        rocket.getEngine().setTimeOfLastCheck(currentTime);
    }

    @Override
    public String toString() {
        return "EngineRoom " + name;
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof EngineRoom) || o.hashCode() != hashCode()) {
            return false;
        }
        EngineRoom other = (EngineRoom) o;
        return name.equals(other.name);
    }
}
