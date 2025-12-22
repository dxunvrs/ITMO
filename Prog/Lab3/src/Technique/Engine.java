package Technique;

import Environment.Sound;

import java.util.Objects;

public abstract class Engine extends Device {
    protected final int maxDistance;
    private long timeOfLastCheck;

    public Engine(String name, int maxDistance) {
        super(name, new Sound("шум двигателя"));
        this.maxDistance = maxDistance;
        timeOfLastCheck = System.currentTimeMillis();
    }

    public abstract String getEngineType();

    public int getMaxDistance() {
        return maxDistance;
    }

    public void setTimeOfLastCheck(long time) {
        timeOfLastCheck = time;
    }

    public long getTimeOfLastCheck() {
        return timeOfLastCheck;
    }

    @Override
    public String toString() {
        return "Engine " + name;
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, maxDistance);
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof Engine) || o.hashCode() != hashCode()) { return false; }
        Engine other = (Engine) o;
        return name.equals(other.name) && maxDistance == other.maxDistance;
    }
}
