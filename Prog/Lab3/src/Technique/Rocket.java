package Technique;

import Environment.SpaceObjects;

import java.util.Objects;

public final class Rocket extends Device implements Workable {
    private Engine engine;
    private SpaceObjects target;
    private boolean isWork = false;

    public Rocket(String name, Engine engine, SpaceObjects type) {
        super(name);
        this.engine = engine;
        this.target = type;
    }

    public Engine getEngine() {
        return engine;
    }

    public SpaceObjects getTarget() {
        return target;
    }

    public void setEngine(Engine newEngine) {
        engine = newEngine;
    }

    public void setTarget(SpaceObjects newTarget) {
        target = newTarget;
    }

    public void stopEngine() {
        engine.stop();
    }

    public void startEngine() {
        engine.start();
    }

    @Override
    public void start() {
        isWork = true;
        startEngine();
        System.out.print("Полет начался ");
        System.out.println();
        System.out.print(name + " летит, цель: " + target.getName() + " ");
    }

    @Override
    public void stop() {
        isWork = true;
        stopEngine();
        System.out.print("Полет завершился ");
    }

    @Override
    public String work() {
        if (isWork) {
            return name + " летит ";
        } else {
            return name + " простаивает ";
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
        if (!(o instanceof Rocket)) { return false; }
        if (o.hashCode() != hashCode()) { return false; }
        Rocket other = (Rocket) o;
        return other.name == name && other.engine == engine && other.target == target;
    }
}
