package Characters;

abstract class Character {
    protected String name;

    public Character(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    abstract void feel(String feel);
    abstract void wakeUp(String time);
    abstract void sleep(String place);
    abstract void hear(String sound);
    abstract void speak(String speech);
    abstract void think(String thought);
    abstract void remember(String text);
    abstract void understand(String text);
    abstract Character wish();
}
