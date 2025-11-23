package Technique;

import java.util.Objects;

public abstract class Engine extends Device implements Workable {
    private boolean isWork = false;

    public Engine(String name) {
        super(name);
    }

    public abstract void getEngineType();

    @Override
    public String work() {
        if (isWork) {
            return name + " шумит ";
        } else {
            return name + " простаивает ";
        }
    }

    @Override
    public void start() {
        if (isWork) {
            System.out.print(name + " : двигатель уже запущен ");
        } else {
            isWork = true;
            System.out.print(name + " : двигатель запущен ");
        }
    }

    @Override
    public void stop() {
        if (!isWork) {
            System.out.print(name + " : двигатель уже остановлен ");
        } else {
            isWork = false;
            System.out.print(name + " : двигатель остановлен ");
        }
    }

    @Override
    public String toString() {
        return "Engine " + name;
    }

    @Override
    public int hashCode() {
        return Objects.hash(name);
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof Engine)) { return false; }
        if (o.hashCode() != hashCode()) { return false; }
        Engine other = (Engine) o;
        return other.name == name;
    }
}
