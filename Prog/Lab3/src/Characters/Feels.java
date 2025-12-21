package Characters;

public enum Feels {
    FUN("радость"), SAD("грусть");

    private final String name;

    Feels(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}
