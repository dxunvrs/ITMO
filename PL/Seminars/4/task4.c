#include <stdio.h>
#include <string.h>

extern void print_string(const char *str);
extern void print_file(const char *filename);

int main(void) {
    char filename[256];

    print_string("Введите имя файла: ");

    if (fgets(filename, sizeof(filename), stdin) != NULL) {
        filename[strcspn(filename, "\n")] = '\0';

        print_string("Содержимое файла:\n");
        print_file(filename);
    }

    return 0;
}
