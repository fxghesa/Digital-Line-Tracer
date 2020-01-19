	org 0h
;P1.4 rencana belok kiri
;P1.5 rencana belok kanan
;P1.0 motor kiri
;P1.1 motor kanan
;P2.0 sensor kanan
;P2.1 sensor kiri
;P2.2 sensor sayap

belok1:;utk set perempatan ke1
	mov b,#01h
	mov a,0h
	clr P1.4
	setb p1.5
	call mulai
belok2:;set setelah perempatan ke1
	mov b,#01h
	mov a,0h
	clr P1.4
	setb p1.5
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
	setb P1.1;
	ret
mkanan: 
	clr P1.1;
	ret
kiri: 
	JNB P2.1, mkiri
	setb P1.0;
	ret
mkiri: 
	clr P1.0;
	ret
mulai:
	jb P1.5, cek;cek keadaan standby
	ret;sudah belok
cek:
	call jalan
	jnb P2.2, hitung
	sjmp cek;sayap kena hitam
hitung:
	jnb P2.2,hitung;tunggu putih
	inc a
	cjne a,b,cek;belum saatnya
	sjmp belok;saatnya perempatan
belok:
	jnb p1.4, belok_kiri;cek rencana
	sjmp belok_kanan
belok_kiri:
	clr P1.1;
	setb p1.0;
	clr P1.5
	sjmp mulai
belok_kanan:
	clr P1.0
	setb p1.1
	clr P1.5
	sjmp mulai
