# from lex to c
flex -o LAB01.yy.cpp LAB01.l

# from c to out
g++ -std=c++11 -o LAB01.out LAB01.yy.cpp -lfl