CC=gcc
PP=g++
FLAGS=-Wall -Wextra -Werror -std=c++17 -Wpedantic
TEST_FILE=testing_vector.cpp
all: clean format test coverage
clean:
	@clear
	@rm -rf *.[og]* vector* REPORT.html unit_test
test:
	@echo "==========================="
	@echo "The program is being tested\n==========="
	@echo "Please wait\n==========="
	$(CC) $(FLAGS) -c $(TEST_FILE) --coverage
	$(PP) $(FLAGS) -o unit_test *.o -lgtest -lgtest_main --coverage
	chmod +x unit_test
	./unit_test
coverage:
	gcovr -r . --html-details -o vector_coverage_report.html
rebuild: all
format:
	@clang-format -i *.cpp *.h -style=Google
cppcheck:
	cppcheck --enable=all --suppress=missingIncludeSystem *.cpp *.h vector_cpps/* 
valgrind:
	valgrind --tool=memcheck --leak-check=yes ./vector_test
