# exHitAndBlow

Hit & Blow (Bulls and Cows) Offense & Defense program by Elixir.<br>
Offence Script solve the number of N digits you have decided.<br>
<br>
https://en.wikipedia.org/wiki/Bulls_and_Cows


## Related article

- Elixirでつくるn桁版Hit&Blow(ヌメロン(Numer0n))の出題者側プログラムおよび質問者側プログラム<br>
https://qiita.com/gx3n-inue/private/2b20aa477fcc7072bee5<br>

- n桁版Hit&Blow(ヌメロン(Numer0n))の出題者側プログラムおよび質問者側プログラム<br>
https://qiita.com/gx3n-inue/items/396eddf69fbfa1eacc65<br>
https://github.com/NobuyukiInoue/pyHitAndBlow<br>

## 1. compile

```
mix escript.build
```

Running it without any options will show usage.

```
./main
Usage)
./main defence [N [enable_print [answer_number]]]
./main offence [N [enable_print [answer_number]]]
./main repeat [repeat_count [N [enable print [answer number]]]]

Example)
./main defence 4
./main defence 4 true 0123
./main offence 4 true 0123
./main repeat 100 4
./main repeat 200 5 true
```

## 2. offence mode

Auto Caluculate Hit & Blow (Bulls and Cows) Offence mode.

### 2-1. usage

```
./main offence [N [enable print] [answer number]]]
```

### 2-2. Options

Usage)
./main defence [N [enable_print [answer_number]]]
./main offence [N [enable_print [answer_number]]]
./main repeat_offence [repeat_count [N [enable print [answer number]]]]

|Options|Explanation|
|-------|-----------|
mode|"defence" or "offence" or "repeat"
N|digits of answer number. (2 <= N <= 10)<br>(default ... 4)
enable print|when "True" then enable print remaining target numbers. <br>(default ... False)
answer number|Predetermined your unique N-digit answer number.

### 2-3. Execution examples

#### sample1

N(digits of answer number) = 4.<br>
Predetermine your unique 4-digit number.<br>
If run with no arguments, enter as many Hit and Blow answers as the number offered by your computer.

```
$ ./main offence

(remaining count = 5040) Is your number 7016 ?
[1] : please input H, B = 0,1            <--- "0,1", "0 1", "01" are also acceptable.

(remaining count = 1440) Is your number 2950 ?
[2] : please input H, B = 0,1            <--- "0,1", "0 1", "01" are also acceptable.

(remaining count =  378) Is your number 4365 ?
[3] : please input H, B = 0,2            <--- "0,2", "0 2", "02" are also acceptable.

(remaining count =   99) Is your number 3628 ?
[4] : please input H, B = 0,2            <--- "0,2", "0 2", "02" are also acceptable.

(remaining count =   19) Is your number 1234 ?
[5] : please input H, B = 4,0            <--- "4,0", "4 0", "40", "4" are also acceptable.
calculate successful.

===== challenge history =====
[1] (5040) ---> 7016 (0, 1)
[2] (1440) ---> 2950 (0, 1)
[3] ( 378) ---> 4365 (0, 2)
[4] (  99) ---> 3628 (0, 2)
[5] (  19) ---> 1234 (4, 0)
```

#### sample2

N(digits of answer number) = 4.<br>
If you give the argument answer_number, it will be in automatic answer mode.

```
$ ./main offence 4 false 1234
N ... 4
set answer number ... 1234

(remaining count = 5040) Is your number 1653 ?
input response is Hit = 1, Blow = 1

(remaining count =  720) Is your number 7463 ?
input response is Hit = 0, Blow = 2

(remaining count =  165) Is your number 6054 ?
input response is Hit = 1, Blow = 0

(remaining count =   16) Is your number 3257 ?
input response is Hit = 1, Blow = 1

(remaining count =    2) Is your number 1234 ?
input response is Hit = 4, Blow = 0
calculate successful.

===== challenge history =====
[1] (5040) ---> 1653 (1, 1)
[2] ( 720) ---> 7463 (0, 2)
[3] ( 165) ---> 6054 (1, 0)
[4] (  16) ---> 3257 (1, 1)
[5] (   2) ---> 1234 (4, 0)
```

#### sample3

N(digits of answer number) = 7.<br>
And give the argument answer_number.

```
$ ./main offence 7 false 3456789
N ... 7
set answer number ... 3456789

(remaining count = 604800) Is your number 1896204 ?
input response is Hit = 1, Blow = 3

(remaining count = 59640) Is your number 5647803 ?
input response is Hit = 0, Blow = 6

(remaining count = 8370) Is your number 3586027 ?
input response is Hit = 2, Blow = 3

(remaining count =  708) Is your number 1573046 ?
input response is Hit = 0, Blow = 5

(remaining count =   73) Is your number 3756498 ?
input response is Hit = 3, Blow = 4

(remaining count =   11) Is your number 3456789 ?
input response is Hit = 7, Blow = 0
calculate successful.

===== challenge history =====
[1] ( 604800) ---> 1896204 (1, 3)
[2] (  59640) ---> 5647803 (0, 6)
[3] (   8370) ---> 3586027 (2, 3)
[4] (    708) ---> 1573046 (0, 5)
[5] (     73) ---> 3756498 (3, 4)
[6] (     11) ---> 3456789 (7, 0)
```

## 3. defence mode

Auto Caluculate Hit & Blow (Bulls and Cows) Defence Script.

### 3-1. Usage

```
./main defence [N [enable print] [answer number]]]
```

### 3-2. Options

|Options|Explanation|
|-------|-----------|
N|digits of answer number. (2 <= N <= 10)<br>(default ... 4)
enable print|not use.<br>(default ... False)
answer number|Predetermined unique N-digit answer number.

### 3-3. Execution examples

```
$ ./main defence.py 4
N ... 4
When you want to end on the way, please input 0

[1] : select number xxxx = 3429
input response is Hit = 0, Blow = 2
[2] : select number xxxx = 7594
input response is Hit = 0, Blow = 1
[3] : select number xxxx = 9613
input response is Hit = 1, Blow = 2
[4] : select number xxxx = 9386
input response is Hit = 2, Blow = 1
[5] : select number xxxx = 9036
input response is Hit = 1, Blow = 3
[6] : select number xxxx = 9360
input response is Hit = 4, Blow = 0

congratulations!!!
my answer number is 9360.


===== challenge history ======
[1]  .... 3429 (0, 2)
[2]  .... 7594 (0, 1)
[3]  .... 9613 (1, 2)
[4]  .... 9386 (2, 1)
[5]  .... 9036 (1, 3)
[6]  .... 9360 (4, 0)
```

## 4. repeat mode.

This mode is executes offence continuously and calculates the average value.

#### 4-1. Usage.
```
./main repeat [repeat_count [N [enable_print [answer_number]]]]
```

#### 4-2. Options.

|Options|Explanation|
|-------|-----------|
N|digits of answer number. (2 <= N <= 10)<br>(default ... 4)
MAX|repeat count.<br>(default ... 10)

#### 4-3. Execution example

```
$ ./main repeat 10 4
...
...
(remaining count =    2) Is your number 3970 ?
input response is Hit = 2, Blow = 2

(remaining count =    1) Is your number 9370 ?
input response is Hit = 4, Blow = 0

===== challenge history ======
[1]  .... 5076 (1, 1)
[2]  .... 6049 (0, 2)
[3]  .... 5634 (0, 1)
[4]  .... 4870 (2, 0)
[5]  .... 3970 (2, 2)
[6]  .... 9370 (4, 0)

# Latest Average = 5.4000

==== ResultCount history =====
ResultCount[0] = 6
ResultCount[1] = 7
ResultCount[2] = 6
ResultCount[3] = 5
ResultCount[4] = 5
ResultCount[5] = 6
ResultCount[6] = 5
ResultCount[7] = 5
ResultCount[8] = 4
ResultCount[9] = 5
======== distribution ========
0 ... 0
1 ... 0
2 ... 0
3 ... 0
4 ... 1
5 ... 5
6 ... 3
7 ... 1
8 ... 0
9 ... 0
10 ... 0
11 ... 0
12 ... 0
Distribution list Total = 10
==============================
Total Questions = 54
Total Average   = 5.4
==============================
Total execution time ... 0.034[s]
```

## Licence

[MIT](https://github.com/NobuyukiInoue/exHitAndBlow/blob/main/LICENSE)


## Author

[Nobuyuki Inoue](https://github.com/NobuyukiInoue/)
