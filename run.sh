# compiling from lex to c
flex -o LAB01.yy.cpp LAB01.l

# from c to out
g++ -o LAB01.out LAB01.yy.cpp

#running the executable
./LAB01.out entrada.txt > salida.txt
