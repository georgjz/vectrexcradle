; Copyright (C) 2018 Georg Ziegler
;
; Permission is hereby granted, free of charge, to any person obtaining a copy of
; this software and associated documentation files (the "Software"), to deal in
; the Software without restriction, including without limitation the rights to
; use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
; of the Software, and to permit persons to whom the Software is furnished to do
; so, subject to the following conditions:
;
; The above copyright notice and this permission notice shall be included in
; all copies or substantial portions of the Software.
; -----------------------------------------------------------------------------
;   File: HelloWorld.asm
;   Author(s): Georg Ziegler
;   Description: Simple program that will display "HELLO WORLD" on the Vectrex
;

;-------------------------------------------------------------------------------
;   Symbols for BIOS routines
;-------------------------------------------------------------------------------
Intensity5F equ $f2a5           ; BIOS Intensity routine
PrintStrD   equ $f37a           ; BIOS Print routine
WaitRecal   equ $f192           ; BIOD recalibration
music1      equ $fd0d           ; address of BIOS ROM music

;-------------------------------------------------------------------------------
;   Start of Cartridge ROM
;-------------------------------------------------------------------------------
    section CODE
        org $0000
        opt c                   ; trace cycle count
        ; Header required by Vectrex
        .ascii  "g GCE 2018"            ; Copyright mark
        .byte   $80
        .word   music1                  ; music from ROM
        .byte   $f8,$50,$20,-$56        ; height, width, rel y, rel x (from 0, 0)
        .ascii  "HELLO WORLD PROG 1"    ; Game title
        .byte   $80
        .byte   $00                     ; end of header

        ; Code
main:
        jsr WaitRecal           ; recalibrate Vectrex
        jsr Intensity5F         ; Set Intensity to $5f
        ldu #HelloWorldString   ; address of string
        lda #$10                ; Text position relative Y
        ldb #-$50               ; Text position relative X
        jsr PrintStrD           ; BIOS print routine
        bra main                ; repeat forever

;-------------------------------------------------------------------------------
;   Data
;-------------------------------------------------------------------------------
HelloWorldString:
        .ascii  "HELLO WORLD"           ; Vectrex can only display capital letter
        .byte   $80

endsection
