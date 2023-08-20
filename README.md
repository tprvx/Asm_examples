# asm_examples
```
rax - accumulator
rbx - base (pointer of data)
rcx - counter
rdx - data (division use)
rip - instruction's pointer
rsp - stack pointer

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
call => call function (jump to label)

rax - 64bit
eax - 32bit
ax  - 16bit
ah/al - 8bit
```
### build
```
sudo apt install fasm
cd /hello_world
make once run
```
