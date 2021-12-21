.global _start
_start:
	MOV R1, #-1;
	LDR R2, =TEST_NUM;
	LDR R0, [R2];
	MOV R7, #0;
	MOV R8, #0;
	LOOP:
		CMP R1, R0;
		BGE END;
		ADD R7, R7, R0;
		ADD R8, R8, #1;
		ADD R2, R2, #4; // Cuz one word is 4 bytes
		LDR R0, [R2];
	B LOOP;
	END: B END
		
// TEST_NUM: .word 1, 2, 3, 5, 0xA, -1

.end