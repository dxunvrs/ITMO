package technique;

import environment.Sound;

import java.util.Objects;

public abstract class Device {
    protected String name;
    private final Sound sound;

    public Device(String name, Sound sound) {
        this.name = name;
        this.sound = sound;
    }

    public void setName(String newName) {
        name = newName;
    }

    public String getName() {
        return name;
    }

    public Sound getSound() {
        return sound;
    }

    @Override
    public String toString() {
        return "Device " + name;
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, sound);
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof Device) || o.hashCode() != hashCode()) { return false; }
        Device other = (Device) o;
        return name.equals(other.name) && sound.equals(other.sound);
    }
}
