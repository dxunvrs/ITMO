TEMP_DIR=temp
OUTPUT_DIR=output

$(TEMP_DIR):
	mkdir -p $@

$(OUTPUT_DIR):
	mkdir -p $@

$(TEMP_DIR)/lib.o: lib.asm lib.inc | $(TEMP_DIR)
	nasm -f elf64 -o $(TEMP_DIR)/lib.o lib.asm

$(TEMP_DIR)/%.o: %.asm $(TEMP_DIR)/lib.o | $(TEMP_DIR)
	nasm -f elf64 -o $@ $<

task1: $(TEMP_DIR)/task1.o | $(OUTPUT_DIR)
	ld -o $(OUTPUT_DIR)/task1 $(TEMP_DIR)/task1.o $(TEMP_DIR)/lib.o

task2: $(TEMP_DIR)/main.o | $(OUTPUT_DIR)
	ld -o $(OUTPUT_DIR)/task2 $(TEMP_DIR)/main.o $(TEMP_DIR)/lib.o

clean:
	rm -r $(TEMP_DIR)
	rm -r $(OUTPUT_DIR)

.PHONY: clean
