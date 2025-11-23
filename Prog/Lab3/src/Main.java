import Characters.Feels;
import Environment.SpaceObjects;
import Environment.Time;
import Exceptions.DistanceException;
import Technique.*;
import Characters.Shorty;

import java.util.ArrayList;
import java.util.List;


public class Main {
    public static void main(String[] args) {
        // старт ракеты
        Engine engine = new ChemicalEngine("Двигатель");
        Rocket rocket = new Rocket("Ракета1", engine, SpaceObjects.MOON);
        rocket.start();
        System.out.println();

        // погрузка коротышек
        ArrayList<Shorty> shorties = new ArrayList<Shorty>(List.of(
                new Shorty("Винтик"),
                new Shorty("Шпунтик"),
                new Shorty("Пилюлькин")
        ));
        Shorty znayka = new Shorty("Знайка");
        shorties.add(znayka); // добавление через add

        for (Shorty shorty : shorties) {
            shorty.onBoard(rocket);
            System.out.print(" ");
        }
        System.out.println();

        // Незнайка спит в отсеке, затем просыпается и вспоминает где он
        Shorty neznayka = new Shorty("Незнайка");
        neznayka.sleep("Пищевой отсек");
        System.out.println();
        neznayka.wakeUp(Time.NIGHT);
        System.out.println();
        neznayka.remember("Нарочно забрался в ракету");
        System.out.println();

        // Незнайка слышит шум двигателя и ощущает невесомость
        neznayka.feel(Feels.WEIGHTLESS);
        System.out.println();
        neznayka.hear(rocket.getEngine().work());
        System.out.println();

        // Незнайка понимает что ракета в полете и думает что все именно так как и хотел
        neznayka.understand(rocket.work());
        System.out.println();
        neznayka.think("Все так, как я и хотел");
        System.out.println();

        // Незнайка чувствует радость
        neznayka.feel(Feels.FUN);
        System.out.println();

        // Незнайка хотел сказать о своем присутствии Знайке, но в конце передумал
        neznayka.wish().speak("Скажу Знайке, что я без спросу залез в ракету ");
        System.out.println();
        neznayka.think("Ладно, подожду ещё чуть-чуть");
        System.out.println();

        // сколько до луны
        //System.out.println(rocket.getTarget().getEarthDistanceInKilometers());

         // тест исключения
         //System.out.println(SpaceObjects.TEST.getEarthDistanceInKilometers());

    }
}
