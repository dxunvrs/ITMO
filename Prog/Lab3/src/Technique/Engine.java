package Technique;

public final class Engine extends Device {
    public Engine(String name) {
        super(name);
    }

    @Override
    public String work() {
        return name + " шумит";
    }
}
