using Rankings, Test


@testset "Литвак (1982), p.78" begin
@test  ⦸(ranking"a₂,a₄,a₁,a₃",
         ranking"a₁,a₃∼a₄,a₂",
         ranking"a₂∼a₃,a₄,a₁",
         ranking"a₃,a₂,a₁∼a₄") ==
[
  0   2  0   1;
 -2   0  1  -2;
  0  -1  0  -1;
 -1   2  1   0
]
end

@testset "Bury, Wagner (2008), p.154" begin
@test  ranking"O₂,O₃,O₄,O₁,O₅" ⦸
       ranking"(O₂,O₃),O₄,(O₁,O₅)" ⦸
       ranking"O₂,(O₁,O₃,O₄),O₅" ⦸
       ranking"O₂,(O₁,O₃,O₄,O₅)" ==
[
  0  4   2   2  -2;
 -4  0  -3  -4  -4;
 -2  3   0  -2  -3;
 -2  4   2   0  -3;
  2  4   3   3   0
]
end

@testset "Bredereck (2009), p.21" begin
@test  ranking"a≻b≻c≻d" ⦸
       ranking"a≻b≻d≻c" ⦸
       ranking"a≻c≻b≻d" ⦸
       ranking"b≻a≻c≻d" ⦸
       ranking"b≻a≻d≻c" ==
[
 0  -1  -5  -5;
 1   0  -3  -5;
 5   3   0  -1;
 5   5   1   0
]
end

@testset "Muravyov, Tarakanov (2011)" begin
@test  ranking"A K D N J H E∼L P I B∼O F R M T Q S G C" ⦸
       ranking"T I C A Q F H N M G B O D R P L E K J S" ⦸
       ranking"R N T P∼I C G∼D K O H J Q S∼M B E A F L" ⦸
       ranking"H B M A Q N D O T L I G R S E∼C J F K P" ==
[
 0   0   0  -2  -2  -4  -2  0   0  -2  -2  -4   0  -2  -2  -2  -2  -2  -2   0;
 0   0   0   0  -2  -2   0  4   2   0   0  -2   0   2  -1   0   0  -2  -2   0;
 0   0   0   0  -1  -2   0  0   4  -2  -2   0   0   2   0   0   0   2   0   4;
 2   0   0   0  -4  -2  -1  0   0  -4  -2  -4   0   2  -2  -2   0  -2  -4   0;
 2   2   1   4   0  -2   2  4   2   0   0   1   2   4   2   0   2   2   0   2;
 4   2   2   2   2   0   0  2   4   2   0   0   0   2   2   0   2   0   0   2;
 2   0   0   1  -2   0   0  2   4  -2  -2   0   2   4   0   0   2   0  -2   4;
 0  -4   0   0  -4  -2  -2  0   0  -2   0  -4  -4   0  -2  -2  -2  -2  -4   0;
 0  -2  -4   0  -2  -4  -4  0   0  -2  -2   0  -2   2  -2  -1  -2  -2  -4   2;
 2   0   2   4   0  -2   2  2   2   0   2   0   0   4   2   0   0   2  -2   2;
 2   0   2   2   0   0   2  0   2  -2   0   0   0   2   0   0   0   2  -2   2;
 4   2   0   4  -1   0   0  4   0   0   0   0   2   4   2   0   2   0  -2   2;
 0   0   0   0  -2   0  -2  4   2   0   0  -2   0   2   0   0   0   0  -3   0;
 2  -2  -2  -2  -4  -2  -4  0  -2  -4  -2  -4  -2   0  -4  -4   0  -2  -4  -2;
 2   1   0   2  -2  -2   0  2   2  -2   0  -2   0   4   0   0   0  -2  -4   0;
 2   0   0   2   0   0   0  2   1   0   0   0   0   4   0   0   0   2  -2   2;
 2   0   0   0  -2  -2  -2  2   2   0   0  -2   0   0   0   0   0   0  -4   2;
 2   2  -2   2  -2   0   0  2   2  -2  -2   0   0   2   2  -2   0   0  -4   0;
 2   2   0   4   0   0   2  4   4   2   2   2   3   4   4   2   4   4   0   4;
 0   0  -4   0  -2  -2  -4  0  -2  -2  -2  -2   0   2   0  -2  -2   0  -4   0
]
@test  ranking"AIFDHCBEJG" ⦸
       ranking"BHDAFCIEGJ" ⦸
       ranking"DIEBCJAHGF" ⦸
       ranking"CJHADIFGBE" ⦸
       ranking"ICAJHDGBFE" ==
[
  0  -1   1  -1  -3  -5  -5  -1  -1  -1;
  1   0   1   3  -3  -1  -1   1   3  -1;
 -1  -1   0   1  -3  -1  -5  -1   1  -5;
  1  -3  -1   0  -5  -3  -5   1  -1  -1;
  3   3   3   5   0   3  -1   3   5  -1;
  5   1   1   3  -3   0  -1   3   3   1;
  5   1   5   5   1   1   0   5   5   3;
  1  -1   1  -1  -3  -3  -5   0   1   1;
  1  -3  -1   1  -5  -3  -5  -1   0  -3;
  1   1   5   1   1  -1  -3  -1   3   0
]
@test  ranking"J∼K A∼B∼C∼D∼E∼F∼G∼H∼I∼L∼M" ⦸
       ranking"J A∼B∼C∼D∼E∼F∼G∼H∼I∼K∼L∼M" ⦸
       ranking"J∼K A∼B∼C∼D∼E∼F∼G∼H∼I∼L∼M" ⦸
       ranking"I∼J∼K A∼B∼C∼D∼E∼F∼G∼H∼L∼M" ⦸
       ranking"H∼I∼J∼K L∼A∼B∼C∼D∼E∼F∼G∼M" ⦸
       ranking"H∼I∼J A∼B∼C∼D∼E∼F∼G∼K∼L∼M" ⦸
       ranking"K∼L A∼B∼C∼D∼E∼F∼G∼H∼I∼J∼M" ⦸
       ranking"I∼J∼K A∼B∼C∼D∼E∼F∼G∼H∼L∼M" ⦸
       ranking"B∼C A∼D∼E∼F∼G∼H∼I∼J∼K∼L∼M" ⦸
       ranking"H∼I A∼B∼C∼D∼E∼F∼G∼J∼K∼L∼M" ==
[
  0   1   1   0   0   0   0   3   5  7   6   1   0;
 -1   0   0  -1  -1  -1  -1   2   4  6   5   0  -1;
 -1   0   0  -1  -1  -1  -1   2   4  6   5   0  -1;
  0   1   1   0   0   0   0   3   5  7   6   1   0;
  0   1   1   0   0   0   0   3   5  7   6   1   0;
  0   1   1   0   0   0   0   3   5  7   6   1   0;
  0   1   1   0   0   0   0   3   5  7   6   1   0;
 -3  -2  -2  -3  -3  -3  -3   0   2  4   3  -2  -3;
 -5  -4  -4  -5  -5  -5  -5  -2   0  2   1  -4  -5;
 -7  -6  -6  -7  -7  -7  -7  -4  -2  0  -1  -6  -7;
 -6  -5  -5  -6  -6  -6  -6  -3  -1  1   0  -5  -6;
 -1   0   0  -1  -1  -1  -1   2   4  6   5   0  -1;
  0   1   1   0   0   0   0   3   5  7   6   1   0
]
end

@testset "Farnoud, Milenkovic (2014), p.6427" begin
@test  ranking"1423" ⦸
       ranking"1432" ⦸
       ranking"2314" ⦸
       ranking"4231" ⦸
       ranking"3241" ==
[
  0   1   1  -1;
 -1   0  -1   1;
 -1   1   0   1;
  1  -1  -1   0
]
@test  ranking"54132" ⦸
       ranking"15423" ⦸
       ranking"43512" ⦸
       ranking"13452" ⦸
       ranking"42531" ⦸
       ranking"12534" ⦸
       ranking"24351" ==
[
  0  -3  -1  1   1;
  3   0  -1  3   1;
  1   1   0  3   1;
 -1  -3  -3  0  -1;
 -1  -1  -1  1   0
]
@test  ranking"123" ⦸
       ranking"123" ⦸
       ranking"321" ⦸
       ranking"213" ==
[
 0  0  -2;
 0  0  -2;
 2  2   0
]
end

@testset "Бухарин, Марышев, Дивуева (2014), p.55" begin
@test  ranking"a₃,a₅,a₂,a₄,a₁" ⦸
       ranking"a₃,a₅,a₄,a₂,a₁" ⦸
       ranking"a₃,a₅,a₂∼a₄,a₁" ==
[
  0   3  3   3   3;
 -3   0  3   0   3;
 -3  -3  0  -3  -3;
 -3   0  3   0   3;
 -3  -3  3  -3   0
]
end

@testset "Болтенков, Куваева, Червоненко (2018), p.55" begin
@test  ranking"c≻e≻d≻b≻a" ⦸
       ranking"c≻e≻d≻b≻a" ⦸
       ranking"c≻e≻b≻d≻a" ⦸
       ranking"c≻e≻d≻b≻a" ⦸
       ranking"e≻c≻d≻a≻b" ⦸
       ranking"e≻d≻c≻a≻b" ⦸
       ranking"e≻c≻d≻a≻b" ⦸
       ranking"b≻e≻d≻c≻a" ⦸
       ranking"d≻b≻e≻c≻a" ==
[
  0   3   9   9  9;
 -3   0   5   5  5;
 -9  -5   0  -3  1;
 -9  -5   3   0  7;
 -9  -5  -1  -7  0
]
end

@testset "Muravyov, Baranov, Emelyanova (2019)" begin
@test  ranking"A∼C,B" ⦸
       ranking"C,A∼B" ⦸
       ranking"B∼C,A" ==
[
  0   0  2;
  0   0  2;
 -2  -2  0
]
@test  ranking"A B F D (C E)" ⦸
       ranking"D E A B C F" ⦸
       ranking"B (E A)(C D) F" ⦸
       ranking"(F C) D B (A E)" ⦸
       ranking"C D (B F) E A" ==
[
  0   1  -1  1   1  -1;
 -1   0  -1  1  -3  -2;
  1   1   0  0   0  -2;
 -1  -1   0  0  -3  -1;
 -1   3   0  3   0   1;
  1   2   2  1  -1   0
]
end