;P1.6 rencana belok kiri
;P1.7 rencana belok kanan

;P1.0 motor kiri maju
;P1.3 motor kiri diam
;P3.1 motor kanan maju
;P3.0 motor kanan mundur

;P2.0 sensor kanan
;P2.1 sensor kiri
;P2.2 sensor sayap
	org 0h
belok1:;utk set perempatan ke1
	mov b,#01h
	mov a,0h
	clr P1.6
	setb p1.7
	call mulai
belok2:;set setelah perempatan ke1
	mov b,#01h
	mov a,0h
	clr P1.6
	setb p1.7
	call mulai
finish:
	call jalan
	sjmp finish
jalan:
	acall kanan;cek sensor kanan??
	acall kiri;cek sensor kiri??
	ret
kanan: 
	JNB P2.0, mkanan
	setb P1.0
	clr P1.3
	ret
mkanan: 
	clr P1.0
	setb P1.3
	ret
kiri: 
	JNB P2.1, mkiri
	setb P3.1
	clr P3.0
	ret
mkiri:
	clr P3.1
	setb P3.0 
	ret
mulai:
	jb P1.7, cek;cek keadaan standby
	ret;sudah belok
cek:
	call jalan
	jnb P2.2, hitung;sayap kena hitam
	sjmp cek
hitung:
	jnb P2.2,hitung;tunggu putih
	inc a
	cjne a,b,cek;belum saatnya
	sjmp belok;saatnya perempatan
belok:
	jnb p1.7, belok_kiri;cek rencana
	sjmp belok_kanan
belok_kiri:
	clr P3.1
	setb p3.0
	setb P1.0
	setb P1.3
	clr P1.7
	sjmp mulai
belok_kanan:
	setb P3.1
	setb p3.0
	clr P1.0
	setb P1.3
	clr P1.7
	sjmp mulai
