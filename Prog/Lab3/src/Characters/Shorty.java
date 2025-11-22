package Characters;

import Technique.Rocket;

public class Shorty extends Character {
    public Shorty(String name) {
        super(name);
    }

    public void onBoard(Rocket rocket) {
        System.out.print(name + " погрузился в " + rocket.getName());
    }

    public void sayTo(String text, Shorty shorty) {
        System.out.print(text + " - сказал " + name + " для " + shorty.getName());
    }

    @Override
    public void feel(String feel) {
        System.out.print(name + " чувствует " + feel);
    }

    @Override
    public void wakeUp(String time) {
        System.out.print(time + " : " + name + " просыпается");
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
    public Shorty wish() {
        System.out.print(name + " хотел: ");
        return this;
    }
}
