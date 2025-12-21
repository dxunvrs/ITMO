package Technique;

import java.util.Objects;

public class NuclearEngine extends Engine {
    public NuclearEngine(String name) {
        super(name, 500000000);
    }

    @Override
    public String getEngineType() {
        return name + " - ядерный двигатель ";
    }

    @Override
    public String toString() {
        return "NuclearEngine " + name;
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof NuclearEngine) || o.hashCode() != hashCode()) { return false; }
        NuclearEngine other = (NuclearEngine) o;
        return name.equals(other.name);
    }
}
