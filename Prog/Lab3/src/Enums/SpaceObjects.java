package Enums;

public enum SpaceObjects {
    EARTH("Земля"), MOON("Луна");

    private final String name;

    SpaceObjects(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}
