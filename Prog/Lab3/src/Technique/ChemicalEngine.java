package Technique;

import java.util.Objects;

public class ChemicalEngine extends Engine {
    public ChemicalEngine(String name) {
        super(name);
    }

    @Override
    public void getEngineType() {
        System.out.print(name + " - химический двигатель ");
    }

    @Override
    public String toString() {
        return "ChemicalEngine " + name;
    }

    @Override
    public int hashCode() {
        return Objects.hash(name);
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof ChemicalEngine)) { return false; }
        if (o.hashCode() != hashCode()) { return false; }
        ChemicalEngine other = (ChemicalEngine) o;
        return other.name == name;
    }

}
