package Characters;

import Places.Place;
import Environment.Sound;
import Environment.Time;

import java.util.Objects;

public abstract class Character implements Talkable, Humanable {
    protected String name;
    protected boolean isSleep;

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
        System.out.println(name + " чувствует " + feel.getName() + " ");
    }

    @Override
    public void wakeUp(Time time) {
        isSleep = false;
        System.out.println(time.getName() + " : " + name + " просыпается ");
    }

    @Override
    public void sleep(Place place, Time time) {
        isSleep = true;
        System.out.println(time.getName() + " : " + name + " спит в " + place.getName() + " ");
    }

    @Override
    public void hear(Sound sound) {
        if (!isSleep) {
            System.out.println(name + " слышит " + sound.getName());
        } else {
            System.out.println(name + " спит и не слышит " + sound.getName());
        }

    }

    @Override
    public void speak(String speech) {
        System.out.println(name + " говорит: " + speech);
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
        if (!(o instanceof Character) || o.hashCode() != hashCode()) { return false; }
        Character other = (Character) o;
        return name.equals(other.name);
    }
}
