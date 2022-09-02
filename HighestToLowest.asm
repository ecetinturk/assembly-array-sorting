org 100h

.data

str db 10,13,"Buyukten Kucuge Siralama. Degerleri giriniz: $"  ;Kullanici deger girer.
str1 db 0dh,0ah,"Siralanmis hali: $"                           ;Dizinin son hali kullaniciya geri dondurulur.
array db 10dup(0)                                              ;Dizinin kapasitesi 10 olarak ayarlandi.
                                                               
.code                                                          
                                                               ;Burada rutin
mov ah,9                                                       ;komutlar donduruluyor.
lea dx,str                                                     ;Program baslatiliyor.
int 21h                                                        

mov cx,10                                                      ;Sayacin ilk degeri 10 olarak atandi.
mov bx,offset array                                            ;Ekrana basilacak array'in adresi bx registerine atandi. 
mov ah,1                                                       ;Bu komuttan sonra kullanici klavyeden deger girecek.

girdiler:
int 21h                                                        ;girdiler baslatiliyor. Kullanici klavyeden deger giriyor.
mov [bx],al                                                    ;al icerisindeki deger bx dizisine ataniyor.
inc bx                                                         ;bx registeri 1 arttiriliyor.
Loop girdiler                                                  ;girdiler donguye giriyor. ( while(--cx) )

mov cx,10                                                      ;cx registerine 10 degeri atanir.
dec cx                                                         ;cx registerindeki deger 1 azaltilir.

nextscan:                             
mov bx,cx                                                      ;cx registerindeki deger bx'e atanir.
mov si,0                                                       ;si (indis numarasi), 0 olarak ayarlanir.
                         
nextcomp:
mov al,array[si]                                               ;Dizideki indis numarasi, al'ye atanir.
mov dl,array[si+1]                                             ;Dizideki indis numarasi, dl'ye atanir.(Yukaridakinin her zaman 1 fazlasi.)
cmp al,dl                                                      ;al ve dl registerleri icerisindeki degerler kiyaslanir.

jnc noswap                                                     ;Kiyaslama yapiliyor.

mov array[si],dl                                               ;dl registerindeki degismis deger indise atanir.
mov array[si+1],al                                             ;al registerindeki degismis deger indise atanir.

noswap:
inc si                                                         ;Indis numarasi 1 arttirilir.
dec bx                                                         ;bx register degeri 1 azaltilir.
jnz nextcomp                                                   ;Registerdeki deger 0 degil ise nextcomp'a git. Aksi takdirde nextscana'git

loop nextscan                                                  ;nextscan'a git. ( while(--cx) )

 

mov ah,9                                                       ;Ekrana
lea dx,str1                                                    ;Donus
int 21h                                                        ;Komutlari

mov cx,10                                                      ;cx'e 10 degeri ataniyor. Dizi 10 elemanliydi.
mov bx,offset array                                            ;Bundan sonra diziye herhangi bir islem yapilmayacak.

                                                               ;Asagidaki komutlar ekranda sayilarin siralanmasi icin yazildi.
print:
mov al,array[si]                                               ;Bu iki satir sayesinde kucukten buyuge siralanan
int 10h                                                        ;diziye buyukten kucuge siralama yaptirdik.
mov ah,2
mov dl,[bx]
int 21h
inc bx
loop print

ret        
