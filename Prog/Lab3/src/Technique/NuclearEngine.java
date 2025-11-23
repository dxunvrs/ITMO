package Technique;

import java.util.Objects;

public class NuclearEngine extends Engine {
    public NuclearEngine(String name) {
        super(name);
    }

    @Override
    public void getEngineType() {
        System.out.print(name + " - электрический двигатель ");
    }

    @Override
    public String toString() {
        return "NuclearEngine " + name;
    }

    @Override
    public int hashCode() {
        return Objects.hash(name);
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof NuclearEngine)) { return false; }
        if (o.hashCode() != hashCode()) { return false; }
        NuclearEngine other = (NuclearEngine) o;
        return other.name == name;
    }
}
