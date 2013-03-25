alloc(newmem,2048) ; Allocating 2kb. That's enough
label(returnhere)
label(originalcode)
label(loop1)
label(endloop1)
label(continue)
alloc(script,4096) ; Allocating 4kb for the script.
label(exit)

script:
db 77 61 69 74 28 31 30 29 0D 0A 67 61 6D 65 2E 50 6C 61 79 65 72 73 2E 4C 6F 63 61 6C 50 6C 61 79 65 72 2E 43 68 61 74 74 65 64 3A 63 6F 6E 6E 65 63 74 28 66 75 6E 63 74 69 6F 6E 28 73 74 29 0D 0A 53 70 61 77 6E 28 66 75 6E 63 74 69 6F 6E 28 29 0D 0A 6C 6F 61 64 73 74 72 69 6E 67 28 73 74 29 28 29 20 0D 0A 65 6E 64 29 0D 0A 65 6E 64 29 2D 2D 5B 5B 30 2F 32 39 2F 31 30 0D 0A 2D 2D 20 50 6C 65 61 73 65 20 6E 6F 74 65 20 74 68 61 74 20 74 68 65 73 65 20 61 72 65 20 6C 6F 61 64 65 64 20 69 6E 20 61 20 73 70 65 63 69 66 69 63 20 6F 72 64 65 72 20 74 6F 20 64 69 6D 69 6E 69 73 68 20 65 72 72 6F 72 73 2F 70 65 72 63 65 69 76 65 64 20 6C 6F 61 64 20 74 69 6D 65 20 62 79 20 75 73 65 5D 5D 20

newmem:



originalcode:
cmp byte ptr[eax+3],43 ; Original code for ObjSpawn, found inside of the ROM.
jne continue
cmp byte ptr[eax+4],72 ; This calls up the spawn function, which calls the ObjSpawn function.
jne continue

pushad
mov ecx,0
loop1: ; Looping this process to keep it up to date.
mov bl,byte ptr[script+ecx] ; Hijacking the ObjSpawn Task and integrating it into our GUI.
mov byte ptr [eax+ecx],bl
add ecx,1 ; Makes a X = 80, Y = 40 GUI.
cmp cl,E6 ; Color = green.
jnb endloop1 ; Ends the loop if everything went right. (It will jump back again if it updated)
jmp loop1
endloop1:
popad      ; Showing it inside of the Emu Screen. 
continue:
push edx
push ecx
push eax
push ebx   ; Pushing all registers and checking if everything went right.
call 008D4B20 ; Calls the Display List, it checks if everything went right and of course it loads all the objects into the GUI.

exit:
jmp returnhere ; Exit.

00716A1D:
jmp newmem ; Providing freespace.
nop
nop
nop
nop
returnhere: