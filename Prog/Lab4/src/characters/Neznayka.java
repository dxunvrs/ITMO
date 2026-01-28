package characters;

public class Neznayka extends Shorty{
    public Neznayka(String name) {
        super(name);
    }

    public void feelFunnyOfFlight() {
        if (!isSleep) {
            System.out.println(name + " чувствует радость от полета");
        }
    }

    @Override
    public String toString() {
        return "Neznayka " + name;
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof Neznayka) || o.hashCode() != hashCode()) {
            return false;
        }
        Neznayka other = (Neznayka) o;
        return name.equals(other.name);
    }
}
