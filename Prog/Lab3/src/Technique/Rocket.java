package Technique;

import Characters.Neznayka;
import Characters.Shorty;
import Distance.SpaceObjects;
import Environment.Sound;
import Places.Place;

import java.util.ArrayList;
import java.util.Objects;

public final class Rocket extends Device {
    private final Engine engine;
    private SpaceObjects target;
    private final ArrayList<Shorty> passengers = new ArrayList<>();
    private final ArrayList<Place> places = new ArrayList<>();

    public Rocket(String name, Engine engine, SpaceObjects target) {
        super(name, new Sound("шум ракеты"));
        this.engine = engine;
        this.target = target;
    }

    public Rocket(String name, Engine engine) {
        this(name, engine, SpaceObjects.MOON);
    }

    public Engine getEngine() {
        return engine;
    }

    public SpaceObjects getTarget() {
        return target;
    }

    public void setTarget(SpaceObjects newTarget) throws TargetFarAwayException {
        if (engine.getMaxDistance() >= newTarget.getEarthDistanceInKilometers()) {
            target = newTarget;
        } else {
            throw new TargetFarAwayException("Цель слишком далеко", newTarget.getEarthDistanceInKilometers());
        }
    }

    public void start() {
        System.out.print("Полет начался ");
        System.out.println();
        System.out.println(name + " летит, цель: " + target.getName() + " ");

        for (Shorty passenger : passengers) {
            if (passenger instanceof Neznayka) {
                ((Neznayka) passenger).feelFunnyOfFlight();
            }
        }
    }

    public void stop() {
        System.out.println("Полет завершился");
        for (Shorty passenger : passengers) {
            System.out.println(passenger.getName() + " сошел с борта ракеты");
        }
    }

    public void addPassengers(Shorty character) {
        passengers.add(character);
    }

    public ArrayList<Shorty> getPassengers() {
        return passengers;
    }

    public void addPlace(Place place) throws RoomInAnotherRocketException {
        if (place.getRocket() == null) {
            places.add(place);
        } else {
            throw new RoomInAnotherRocketException("Помещение уже в другой ракете", place.getName());
        }

    }

    @Override
    public String toString() {
        return "Rocket " + name + " with " + engine + " go to " + target;
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, engine, target);
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof Rocket) || o.hashCode() != hashCode()) { return false; }
        Rocket other = (Rocket) o;
        return name.equals(other.name) && engine.equals(other.engine) && target.equals(other.target);
    }
}
