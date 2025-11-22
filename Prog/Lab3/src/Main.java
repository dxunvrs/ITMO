import Technique.Engine;
import Technique.Rocket;
import Enums.*;
import Characters.Shorty;

import java.util.ArrayList;
import java.util.List;


public class Main {
    public static void main(String[] args) {
        // старт ракеты
        Engine engine = new Engine("Двигатель");
        Rocket rocket = new Rocket("Ракета1", engine, SpaceObjects.MOON);
        rocket.start();
        System.out.println();
        rocket.getTarget();
        System.out.println();

        // погрузка коротышек
        ArrayList<Shorty> shorties = new ArrayList<Shorty>(List.of(
                new Shorty("Винтик"),
                new Shorty("Шпунтик"),
                new Shorty("Пилюлькин")
        ));
        Shorty znayka = new Shorty("Знайка");
        shorties.add(znayka);

        for (Shorty shorty : shorties) {
            shorty.onBoard(rocket);
            System.out.print(" ");
        }
        System.out.println();

        // Незнайка спит в отсеке, затем просыпается и вспоминает где он
        Shorty neznayka = new Shorty("Незнайка");
        neznayka.sleep("Пищевой отсек");
        System.out.println();
        neznayka.wakeUp(Time.NIGHT.getName());
        System.out.println();
        neznayka.remember("Нарочно забрался в ракету");
        System.out.println();

        // Незнайка слышит шум двигателя и ощущает невесомость
        neznayka.feel(Feels.WEIGHTLESS.getName());
        System.out.println();
        neznayka.hear(rocket.getEngine().work());
        System.out.println();

        // Незнайка понимает что ракета в полете и думает что все именно так как и хотел
        neznayka.understand(rocket.work());
        System.out.println();
        neznayka.think("Все так, как я и хотел");
        System.out.println();

        // Незнайка чувсвует радость
        neznayka.feel(Feels.FUN.getName());
        System.out.println();

        // Незнайка хотел сказать о своем присутствии Знайке, но в конце передумал
        neznayka.wish().sayTo("Я без спросу залез в ракету", znayka);
        System.out.println();
        neznayka.think("Ладно, подожду ещё чуть-чуть");
    }
}
