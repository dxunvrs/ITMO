package characters;

import environment.Sound;

public interface Talkable {
    void speak(String speech);
    void hear(Sound sound);
}
