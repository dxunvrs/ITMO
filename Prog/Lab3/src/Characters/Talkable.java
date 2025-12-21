package Characters;

import Environment.Sound;

public interface Talkable {
    void speak(String speech);
    void hear(Sound sound);
}
