package environment;

import java.util.Objects;

public class Sound {
    private String name;

    public Sound(String name) {
        this.name = name;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String newName) {
        this.name = newName;
    }

    @Override
    public String toString() {
        return "Sound " + name;
    }

    @Override
    public int hashCode() {
        return Objects.hash(name);
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof Sound) || o.hashCode() != hashCode()) {
            return false;
        }
        Sound other = (Sound) o;
        return name.equals(other.name);
    }
}
