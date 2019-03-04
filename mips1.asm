.data
msg_ola: .asciiz "Bem vindo ao jogo de adivinhação!"		# 
insert: .asciiz "\nInsira um numero de 0 a 10:"			# 
str2: .asciiz "Acertou Mizeravi!\n"				# Strings prontas para usar ao longo
str3: .asciiz "Errou! Tente um numero MENOR!"			# do programa.
str4: .asciiz "Errou! Tente um numero MAIOR!"			# 
str5: .asciiz "O numero sorteado foi:"				# 
.text
.globl	main
main:

		la $a0, msg_ola		#
		li $v0, 4		# Exibe mensagem de Olá
	syscall				#
	
loop1:li $v0, 41     		        # Serviço 41, random int
	syscall      		        # Gera o inteiro randomico (retorna o valor em $a0)
		bltz $a0, loop1         # Verifica se o int gerado é menor que 0, se sim, gera outro.
		addi $t1, $zero, 11     # 
		div $a0, $t1	        # Resto da divisão por 11 para transformar o int em um numero de 0 á 10
		mfhi $t1	        # Salva o valor do resto em $t1
		
ENTRAR:
		la $a0, insert		
		li $v0, 4		#Serviço 4, print string
	syscall
		li	$v0,5		#Serviço 5, scan int
	syscall
		sub $t0,$t0,$t0		# Limpa o registrador
		add $t0, $v0, $t0	# Salva o valor digitado em $t0
				
		beq $t0,$t1,exit        # Testa se o int rand é igual ao digitado
		ble $t0, $t1, MENOR     # Testa se o valor digitado é MENOR/MAIOR que o sorteado
		
		la $a0, str3		# Caso o valor seja
		li $v0, 4		# Maior ou Menor
	syscall				# Ao valor que
		j ENTRAR		# foi sorteado,
		MENOR:			# é exibida uma
		la $a0, str4		# mensagem, e volta 
		li $v0, 4		# para o usuario
	syscall				# digitar um novo
		j ENTRAR		# numero
		
exit:
		la $a0, str2		# Final da comparação
		li $v0, 4		# apos usuario acertar
	syscall				# o num, aparece uma msg
		la $a0, str5		# e finaliza exibindo 
		li $v0, 4		# o num que foi
	syscall				# sorteado no
		sub $a0, $a0, $a0	# inicio do
		add $a0, $t1, $a0	# programa.
		li $v0, 1	        # Serviço 1, print int
	syscall 			# 
