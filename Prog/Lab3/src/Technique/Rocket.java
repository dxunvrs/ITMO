package Technique;

import Interfaces.Flyable;
import Enums.SpaceObjects;

public final class Rocket extends Device implements Flyable {
    private final Engine engine;
    private boolean isFlying = false;
    private final SpaceObjects target;

    public Rocket(String name, Engine engine, SpaceObjects type) {
        super(name);
        this.engine = engine;
        this.target = type;
    }

    public Engine getEngine() {
        return engine;
    }

    public void getTarget() {
        System.out.print(name + " летит, цель: " + target.getName());
    }

    @Override
    public void start() {
        isFlying = true;
        System.out.print("Полет начался");
    }

    @Override
    public boolean isFlying() {
        return isFlying;
    }

    @Override
    public String work() {
        return name + " летит";
    }
}
