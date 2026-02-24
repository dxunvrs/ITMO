import characters.Feel;
import characters.Neznayka;
import distance.SpaceObject;
import environment.Time;
import places.ControlRoom;
import places.EngineRoom;
import places.FoodCompartment;
import technique.*;
import characters.Shorty;

import java.util.ArrayList;


public class Main {
    public static void main(String[] args) {
        // сеттинг
        Neznayka neznayka = new Neznayka("Незнайка");
        Rocket rocket = new Rocket("Ракета", new NuclearEngine("Двигатель"));
        ControlRoom controlRoom = new ControlRoom("Пульт управления");
        FoodCompartment foodCompartment = new FoodCompartment("Пищевой отсек");
        EngineRoom engineRoom = new EngineRoom("Машинное отделение");
        Shorty shorty1 = new Shorty("Коротышка1");
        Shorty shorty2 = new Shorty("Коротышка2");
        Shorty znayka = new Shorty("Знайка");
        ArrayList<Shorty> shorties = new ArrayList<Shorty>();
        shorties.add(shorty1); shorties.add(shorty2); shorties.add(znayka);

        controlRoom.setRocket(rocket);
        foodCompartment.setRocket(rocket);
        engineRoom.setRocket(rocket);

        // погрузка коротышек
        for (Shorty shorty : shorties) {
            shorty.onBoard(rocket);
        }

        neznayka.onBoard(rocket);

        // запуск ракеты
        rocket.start();

        // Незнайка
        neznayka.sleep(foodCompartment, Time.NIGHT);
        neznayka.wakeUp(Time.NIGHT);
        neznayka.speak("Я в ракете");
        neznayka.hear(rocket.getEngine().getSound());
        neznayka.feel(Feel.FUN);

        // тест исключений и активностей
        engineRoom.checkEngine(neznayka);
        controlRoom.changeTarget(neznayka, SpaceObject.MARS);

        Shorty shorty3 = new Shorty("Коротышка");
        controlRoom.changeTarget(shorty3, SpaceObject.MOON);

        controlRoom.changeTarget(neznayka, SpaceObject.TEST);

        Rocket rocket2 = new Rocket("Ракета2", new ChemicalEngine("Двигатель"));
        controlRoom.setRocket(rocket2);
        
        // приземление
        rocket.stop();
    }
}
