Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6243F481E4B
	for <lists+linux-mmc@lfdr.de>; Thu, 30 Dec 2021 17:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240187AbhL3Qns (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 30 Dec 2021 11:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240031AbhL3Qnr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Dec 2021 11:43:47 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1959C061574
        for <linux-mmc@vger.kernel.org>; Thu, 30 Dec 2021 08:43:47 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id ke6so22591300qvb.1
        for <linux-mmc@vger.kernel.org>; Thu, 30 Dec 2021 08:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=4mRMpl/lbZzS4Dbc9ZDklo5pRxIVzQ5ZV5gWwYp30tk=;
        b=LjlkKStMD/LlZP6tUR6Giy1EQqXmjKaU1lb1PaJDKfuAloG6c8PYY82t3cSIDjBUKx
         RXT+uTwWP4Qy/8vJ7jiP6ROW+/oQOvm4Yj/AJmMRaclprbBZYgDdrgoLbt2ng+82FWXu
         +W0boYy3Y+XPUu/nHh6ckYeudsrR6CutS66dNO4pwod7NomxBnV+RBHKL/RKjYEP67h5
         t8/sq5Smq0pS6cjO6Y570QOAS9nroHpwmWtbxKWucacBGsZuphjDvP4Hpe7eDzYiwdmK
         TrGZ3aLTgkEcd7EDRTo3WPm6fziFd6BPIknyfBsGfOn6EvoI71D/gwUepUfQEg+UzRKC
         XKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=4mRMpl/lbZzS4Dbc9ZDklo5pRxIVzQ5ZV5gWwYp30tk=;
        b=5v1djUAKuagM2cSZEaumab95NdDEvXEEC+az0TDWfLSsZicQluuJcIn0DMH56qsqoZ
         DR0vib2TTZl3lmsSk8hEn0BLx+PYM9SFKNm6Xa40Yl08ooG9nLOVlFX+THhVWQXNolR2
         xLmJR7eropJB1SYhulnhfJEYFlJfD2CS+dNxElasjhIx2RCZ0T6xnoFn3tyhXqDu3M2i
         AEDVEONFLWH6o//xgRektFT3t7BLIuBrQm6iv/j2Y2b+pGy1f2zkN8tchR6EEkDmEEcL
         5z3qUbeJM5TEe8jipyLddMyMwXBvLoYfWi16t7JNGp6b2YYCrilXhepg2SbohP+B9voi
         iMog==
X-Gm-Message-State: AOAM531/9u7QBTYDr3Pe4YwVmDEgG+v44s1Wu9mB5iuCAyFN+UvIo3fW
        i0s75yvFgaRyhe8VrDWv7T0dLoQ6yGgE8fawGfA=
X-Google-Smtp-Source: ABdhPJzN/zuzrSQVYieMSrVBFZ2gQ8zxiDSqGBSmP1X6SHKYEJLLrD7JAQSeSxZ5Bsd4iL4q9vSeJoAs3oLq3XQ+CSU=
X-Received: by 2002:a05:6214:f61:: with SMTP id iy1mr28466127qvb.28.1640882626794;
 Thu, 30 Dec 2021 08:43:46 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6214:b67:0:0:0:0 with HTTP; Thu, 30 Dec 2021 08:43:46
 -0800 (PST)
Reply-To: msbelinaya892@gmail.com
From:   msbelinaya <unlonw135@gmail.com>
Date:   Thu, 30 Dec 2021 16:43:46 +0000
Message-ID: <CAGqEqnYyKO9dokN=ZNMAN-2mGDmNPenszos1YpaOCRLjvf0W9w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Felaj=C3=A1nlom a bar=C3=A1ts=C3=A1gomat, =C3=A9s hiszem, hogy j=C3=B3 sz=
=C3=ADvvel fogadsz. Arra
k=C3=A9rtek, hogy vegyem fel =C3=96nnel a kapcsolatot, =C3=A9s n=C3=A9zz=C3=
=BCk meg, hogyan
tudjuk a legjobban t=C3=A1mogatni egym=C3=A1st. Ms. Kodjovi Hegbor vagyok
T=C3=B6r=C3=B6korsz=C3=A1gb=C3=B3l, =C3=A9s a StandardBNP bank limited Turk=
ey-n=C3=A1l az
=C3=BCzemeltet=C3=A9si r=C3=A9szleg vezet=C5=91jek=C3=A9nt dolgozom. Hiszem=
, hogy Isten
akarata, hogy most tal=C3=A1lkozzam veled. Van egy fontos =C3=BCzleti
besz=C3=A9lget=C3=A9sem, amelyet szeretn=C3=A9k megosztani =C3=96nnel, =C3=
=A9s =C3=BAgy gondolom,
hogy =C3=A9rdekelni fogja =C3=96nt, mivel ez az =C3=96n vezet=C3=A9knev=C3=
=A9hez kapcsol=C3=B3dik,
=C3=A9s haszn=C3=A1ra v=C3=A1lik.

 2006-ban az =C3=96n orsz=C3=A1g=C3=A1nak =C3=A1llampolg=C3=A1ra 8 400 000 =
GBP =C3=A9rt=C3=A9k=C5=B1 36
h=C3=B3napos nem rezidens sz=C3=A1ml=C3=A1t nyitott a bankomn=C3=A1l a napt=
=C3=A1rban. Ennek a
let=C3=A9ti szerz=C5=91d=C3=A9snek a lej=C3=A1rati d=C3=A1tuma 2009. janu=
=C3=A1r 16. Sajn=C3=A1latos
m=C3=B3don 2008. m=C3=A1jus 12-=C3=A9n a k=C3=ADnai Szecsu=C3=A1nban egy v=
=C3=A9gzetes f=C3=B6ldreng=C3=A9sben
halt meg, legal=C3=A1bb 68 000 ember hal=C3=A1l=C3=A1t okozva =C3=BCzleti =
=C3=BAton.

Bankom vezet=C3=A9se m=C3=A9g nem hallott a hal=C3=A1l=C3=A1r=C3=B3l, =C3=
=A9n tudtam r=C3=B3la, mert =C5=91 a
bar=C3=A1tom volt, =C3=A9n pedig a sz=C3=A1mlavezet=C5=91je voltam, amikor =
a sz=C3=A1mla
megnyit=C3=A1sa el=C5=91tt az el=C5=91l=C3=A9ptet=C3=A9sem el=C5=91tt t=C3=
=B6rt=C3=A9nt. Azonban uram
 nem eml=C3=ADtette a hozz=C3=A1tartoz=C3=B3it/=C3=B6r=C3=B6k=C3=B6seit a s=
z=C3=A1mlanyit=C3=A1skor, =C3=A9s nem
volt h=C3=A1zas vagy nem volt gyermeke. M=C3=BAlt h=C3=A9ten a banki vezet=
=C5=91s=C3=A9g
megk=C3=A9rt, hogy adjak utas=C3=ADt=C3=A1st arra vonatkoz=C3=B3an, mit teg=
yek a p=C3=A9nz=C3=A9vel,
ha meg kell =C3=BAj=C3=ADtani a szerz=C5=91d=C3=A9st.

Tudom, hogy ez meg fog t=C3=B6rt=C3=A9nni, =C3=A9s ez=C3=A9rt kerestem mego=
ld=C3=A1st a helyzet
kezel=C3=A9s=C3=A9re, mert amikor a bankigazgat=C3=B3im tudj=C3=A1k, hogy m=
eghaltak, =C3=A9s
nincs =C3=B6r=C3=B6k=C3=B6s=C3=BCk, elviszik a p=C3=A9nzt szem=C3=A9lyes ha=
szn=C3=A1latra, =C3=ADgy nem nem
akarom, hogy ilyesmi t=C3=B6rt=C3=A9njen. Ekkor l=C3=A1ttam a vezet=C3=A9kn=
ev=C3=A9t, =C3=B6r=C3=BCltem,
=C3=A9s most keresem az egy=C3=BCttm=C5=B1k=C3=B6d=C3=A9s=C3=A9t, hogy a le=
gk=C3=B6zelebbi
hozz=C3=A1tartoz=C3=B3jak=C3=A9nt / a sz=C3=A1mla =C3=B6r=C3=B6k=C3=B6sek=
=C3=A9nt bemutassam =C3=96nt, mivel
ugyanaz a vezet=C3=A9kneve, mint =C5=91, =C3=A9s a banki sz=C3=A9khelyem fe=
lszabad=C3=ADtja a
sz=C3=A1ml=C3=A1t. neked. Nincs kock=C3=A1zat; a tranzakci=C3=B3t olyan t=
=C3=B6rv=C3=A9nyes
meg=C3=A1llapod=C3=A1s alapj=C3=A1n hajtj=C3=A1k v=C3=A9gre, amely megv=C3=
=A9di =C3=96nt a jogs=C3=A9rt=C3=A9st=C5=91l.

Jobb nek=C3=BCnk k=C3=B6vetelni a p=C3=A9nzt, mint hagyni, hogy a bankigazg=
at=C3=B3k
vigy=C3=A9k el, =C5=91k m=C3=A1r gazdagok. Nem vagyok kapzsi ember, ez=C3=
=A9rt azt
javaslom, hogy a p=C3=A9nzt egyenl=C5=91en osszuk el, 50/50%-ban mindk=C3=
=A9t f=C3=A9l
k=C3=B6z=C3=B6tt. Az =C3=A9n r=C3=A9szesed=C3=A9sem seg=C3=ADteni fog abban=
, hogy saj=C3=A1t v=C3=A1llalkoz=C3=A1st
ind=C3=ADtsak, =C3=A9s a bev=C3=A9telt j=C3=B3t=C3=A9kony c=C3=A9lra ford=
=C3=ADtom, ami az =C3=A1lmom volt.

K=C3=A9rem, mondja el v=C3=A9lem=C3=A9ny=C3=A9t javaslatommal kapcsolatban,=
 nagyon
sz=C3=BCks=C3=A9gem van a seg=C3=ADts=C3=A9g=C3=A9re ebben a tranzakci=C3=
=B3ban. T=C3=A9ged
v=C3=A1lasztottalak, hogy seg=C3=ADts nekem, de nem a saj=C3=A1t munk=C3=A1=
mb=C3=B3l, kedvesem,
hanem Istent=C5=91l. Azt akartam, hogy tudd, hogy id=C5=91t szak=C3=ADtotta=
m arra,
hogy im=C3=A1dkozzam ez=C3=A9rt az =C3=BCzenet=C3=A9rt, miel=C5=91tt kapcso=
latba l=C3=A9ptem volna
veled, =C3=A9s elmondod a v=C3=A9lem=C3=A9nyed, =C3=A9s k=C3=A9rlek b=C3=A1=
nj veled. ez az
inform=C3=A1ci=C3=B3 SZIGOR=C3=9AAN TITKOS. V=C3=A1lasz=C3=A1t k=C3=B6vet=
=C5=91en, kiz=C3=A1r=C3=B3lag szem=C3=A9lyes
e-mail c=C3=ADmemen, msbelinaya892@gmail.com
r=C3=A9szleteket ad a tranzakci=C3=B3r=C3=B3l. Valamint az alap let=C3=A9ti=
 igazol=C3=A1s=C3=A1nak
=C3=A9s az alapot l=C3=A9trehoz=C3=B3 c=C3=A9g l=C3=A9tes=C3=ADt=C5=91 okir=
at=C3=A1nak m=C3=A1solata.
Isten =C3=A1ld=C3=A1sa v=C3=A1rja s=C3=BCrg=C5=91s v=C3=A1lasz=C3=A1t
=C3=9Cdv=C3=B6zlettel
Kodjovi Hegborn=C3=A9
msbelinaya892@gmail.com
