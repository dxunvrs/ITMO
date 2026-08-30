package characters;

public enum Feel {
    FUN("радость"), SAD("грусть");

    private final String name;

    Feel(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}
