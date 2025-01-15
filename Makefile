# Variáveis para os compiladores e as flags de compilação
CC = g++
CFLAGS = -Wall -std=c++11
GCOVFLAGS = -fprofile-arcs -ftest-coverage
LDFLAGS = -lgcov --coverage

# Nome dos executáveis
MAIN = conta_palavras
TEST = testa_conta_palavras

# Diretórios de código fonte e testes
SRCDIR = src
TESTDIR = tests

# Arquivos-fonte
SOURCES := $(wildcard $(SRCDIR)/*.cpp)
TESTS := $(wildcard $(TESTDIR)/*.cpp)

# Arquivos objeto
OBJECTS := $(SOURCES:.cpp=.o)
TEST_OBJECTS := $(TESTS:.cpp=.o)

# Regra padrão
all: $(MAIN)

# Linkando os objetos para criar o executável principal
$(MAIN): $(OBJECTS)
	$(CC) $(CFLAGS) $^ -o $@

# Linkando os objetos de teste e criando o executável de testes
$(TEST): $(TEST_OBJECTS) $(OBJECTS)
	$(CC) $(CFLAGS) $(GCOVFLAGS) $^ -o $@ $(LDFLAGS)

# Compilando cada arquivo-fonte para um arquivo objeto
%.o: %.cpp
	$(CC) $(CFLAGS) $(GCOVFLAGS) -c $^ -o $@

# Comando para rodar os testes
test: $(TEST)
	./$(TEST)

# Comando para limpar arquivos compilados e de cobertura
clean:
	rm -f $(MAIN) $(TEST) $(SRCDIR)/*.o $(TESTDIR)/*.o *.gcda *.gcno *.gcov

# Comando para gerar relatório de cobertura
coverage:
	gcov $(SOURCES)

