package Technique;

import java.util.Objects;

public abstract class Device {
    protected String name;

    public Device(String name) {
        this.name = name;
    }

    public void setName(String newName) {
        name = newName;
    }

    public String getName() {
        return name;
    }

    @Override
    public String toString() {
        return "Device " + name;
    }

    @Override
    public int hashCode() {
        return Objects.hash(name);
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof Device)) { return false; }
        if (o.hashCode() != hashCode()) { return false; }
        Device other = (Device) o;
        return other.name == name;
    }
}
