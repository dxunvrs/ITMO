package Places;

public class FoodCompartment extends Place{
    public FoodCompartment(String name) {
        super(name);
    }

    @Override
    public String toString() {
        return "FoodCompartment " + name;
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof FoodCompartment) || o.hashCode() != hashCode()) {
            return false;
        }
        FoodCompartment other = (FoodCompartment) o;
        return name.equals(other.name);
    }
}
