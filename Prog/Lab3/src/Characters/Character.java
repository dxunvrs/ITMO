package Characters;

import Environment.Time;

import java.util.Objects;

public abstract class Character implements Talkable, Thinkable, Humanable {
    protected String name;

    protected Character(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public Character wish() {
        System.out.print(name + " хотел: ");
        return this;
    }

    @Override
    public void feel(Feels feel) {
        System.out.print(name + " чувствует " + feel.getName());
    }

    @Override
    public void wakeUp(Time time) {
        System.out.print(time.getName() + " : " + name + " просыпается");
    }

    @Override
    public void sleep(String place) {
        System.out.print(place + " : " + name + " спит");
    }

    @Override
    public void hear(String sound) {
        System.out.print(name + " слышит " + sound);
    }

    @Override
    public void speak(String speech) {
        System.out.print(name + " говорит: " + speech);
    }

    @Override
    public void think(String thought) {
        System.out.print(thought + " - думает " + name);
    }

    @Override
    public void remember(String text) {
        System.out.print(text + " - вспомнил " + name);
    }

    @Override
    public void understand(String text) {
        System.out.print(text + " - понял " + name);
    }

    @Override
    public String toString() {
        return "Character " + name;
    }

    @Override
    public int hashCode() {
        return Objects.hash(name);
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof Character)) { return false; }
        if (o.hashCode() != hashCode()) { return false; }
        Character other = (Character) o;
        return other.name == name;
    }
}
