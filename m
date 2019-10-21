Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F37C0DE4A8
	for <lists+linux-mmc@lfdr.de>; Mon, 21 Oct 2019 08:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfJUGj1 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 21 Oct 2019 02:39:27 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:15465 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfJUGj0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Oct 2019 02:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1571639964;
        s=strato-dkim-0002; d=xenosoft.de;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=3UBB5clmU7fA5BGvkmZS0yRq/X7oZ5egdfXk19oe4zg=;
        b=o7rJc6cCQADo+CY+SMO9KmdJXZ9TmVmLdtHMK2ka2oNWCtqKpIP8cJoBMI5gxVS3AB
        uO6qekdwCMeFCtvhzAIpOEHBKXVA1erTxJVDVC1hg2wsNppp1Av4/81OPaT/JhMJPlmE
        Tpa1RA4SmxwsNItwEJAcLJlWKPXAyFasY/7bJyDx0IKdgqAEM7YkEltnvp5lACz/p1gy
        1l49bDlkM+5Q02uKgScLv225mebWVmQkkGi0n9dYjw/ZfpJb1uItZy9rrg4S3TFCNoyd
        2y9yNN20bBJ1tpTrmnRiMyKKTMe11S4JnSjMkSfIzzuY+1W4XIj8fdDs875PtdBsDwGQ
        1DtQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7R7b2dxj7pgkHNyX0QJBlJikPGlH8iz3wQ3Yxi1V3y8"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a01:598:b004:5d53:5912:7f11:1734:a6b7]
        by smtp.strato.de (RZmta 44.28.1 AUTH)
        with ESMTPSA id 60869dv9L6dKRl1
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 21 Oct 2019 08:39:20 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: Onboard SD card doesn't work anymore after the 'mmc-v5.4-2' updates
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailer: iPhone Mail (16G102)
In-Reply-To: <c467eeb45a545263311ae28a49ea5599bb2a882c.camel@kernel.crashing.org>
Date:   Mon, 21 Oct 2019 08:39:19 +0200
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "contact@a-eon.com" <contact@a-eon.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <850A5079-4B0D-4508-9B46-A79074DAEEFD@xenosoft.de>
References: <7b549219-a2e1-08c7-331b-9c3e4fdb8a8f@xenosoft.de> <3aeae0d8-e9be-2585-cbbd-70263cb495f1@xenosoft.de> <20191015125105.GU25745@shell.armlinux.org.uk> <5611f3bc-68aa-78ec-182a-1cb414202314@xenosoft.de> <20191015131750.GV25745@shell.armlinux.org.uk> <CAPDyKFq_0P8X-6hkjko1chLtOrwsxGcEFR31GcbffhhUQNw+bw@mail.gmail.com> <ed35a87495b0f0d322f555a16fb3e0f7574415ac.camel@kernel.crashing.org> <20191018101323.GG25745@shell.armlinux.org.uk> <499d70835d5f3e3cc191e5b5444475cd5a8c4604.camel@kernel.crashing.org> <8d7fd474-a1ad-e33f-f2ba-ec47f4bcc995@xenosoft.de> <c467eeb45a545263311ae28a49ea5599bb2a882c.camel@kernel.crashing.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



> On 21. Oct 2019, at 02:06, Benjamin Herrenschmidt <benh@kernel.crashing.or=
g> wrote:
>=20
>> On Sun, 2019-10-20 at 14:04 +0200, Christian Zigotzky wrote:
>>=20
>> Thanks a lot for your suggestion!
>>=20
>> I had to create a patch because I wasn't able to select=20
>> "CONFIG_NOT_COHERENT_CACHE" in the kernel configuration (patch attached).=

>>=20
>> After patching I was able to select "CONFIG_NOT_COHERENT_CACHE" in the=20=

>> kernel config. I compiled a new RC3 of kernel 5.4 with this kernel=20
>> config option yesterday.
>>=20
>> The good news is, that the onboard SD card works! We successfully tested=20=

>> it on two AmigaOnes (X5000/20 and X5000/40) yesterday but we need a new=20=

>> patch
>> because of the possibility to select "CONFIG_NOT_COHERENT_CACHE" in the=20=

>> kernel config
>=20
> What I find weird is why would it be non-coherent ? A system based on a
> E500 should be coherent afaik...
>=20
> Cheers,
> Ben.
>=20

Hi Ben,

I think it isn=E2=80=99t good to use the kernel config option "CONFIG_NOT_CO=
HERENT_CACHE" if the system is coherent, is it?

We tested the kernel with "CONFIG_NOT_COHERENT_CACHE" yesterday but we didn=E2=
=80=99t find any differences to the coherent kernel.

Could you please explain us the difference between the coherent and not cohe=
rent kernel?

Thanks,
Christian=
