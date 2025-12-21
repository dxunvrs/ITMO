package Technique;

import java.util.Objects;

public class ChemicalEngine extends Engine {
    public ChemicalEngine(String name) {
        super(name, 500000);
    }

    @Override
    public String getEngineType() {
        return name + " - химический двигатель ";
    }

    @Override
    public String toString() {
        return "ChemicalEngine " + name;
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof ChemicalEngine) || o.hashCode() != hashCode()) { return false; }
        ChemicalEngine other = (ChemicalEngine) o;
        return name.equals(other.name);
    }

}
