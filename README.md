# Asm_examples

## Registers

```asm
rax - 64bit
eax - 32bit
ax  - 16bit
ah/al - 8bit

rax - accumulator
rbx - base (pointer of data)
rcx - counter
rdx - data (division use)

rip - instruction's pointer

rsp - stack pointer (указатель на вершину стека)
rbp - base pointer  (указатель на начало стека)
```

## Operators

```asm
mov => move
cmp => compare
jmp => jump
je  => jump equal
inc => increment
dec => decrement
int => interrupt
add => addition
sub => subtraction
mux => multiplication
ret => return
xor => xor bit-operation
push => push in stack
pop  => pop from stack
call => call function - вызывает функцию (помещает текущее значение EIP в стек, затем переходит в функцию)
```

## Usage

```asm
; Пролог и эпилог функции
push    ebp        ; сохраняем в стек указатель на нкачло стека вызывающий функции
mov     ebp, esp   ; вершина стека вызывающей функции становится началом стека (формируем стековый фрейм текущей функции)
sub     esp, 8     ; резервируем 8 байт для локальной переменной

...

mov    esp, ebp    ; востанавливаем всё в обратном порядке, база стека этой функции становится вершиной вызывающей
pop    ebp         ; возвращаем из стека базу вызывающий функции
retn               ; возврат
```

* Соглашение о вызовах x86: аргументы функции передаются в стек (помещаются в обратном порядке), а возвращаемое значение передается через EAX регистр (при условии, что это не число с плавающей точкой).

### build

```Bash
sudo apt install fasm
cd /hello_world
make once run
```
