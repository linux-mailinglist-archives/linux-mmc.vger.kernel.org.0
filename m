Return-Path: <linux-mmc+bounces-2318-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E860F8FB7AF
	for <lists+linux-mmc@lfdr.de>; Tue,  4 Jun 2024 17:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4D11F25BB4
	for <lists+linux-mmc@lfdr.de>; Tue,  4 Jun 2024 15:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3DD15E83;
	Tue,  4 Jun 2024 15:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XNkPjkhY"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CC9145A03
	for <linux-mmc@vger.kernel.org>; Tue,  4 Jun 2024 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717515772; cv=none; b=ZG86xDyknRA9SGp7a9i1CCd84tep503PJEM/MSd6V6hr4FvWdlkBUmKRSp5Jlk6tc8CgRNngcLTHS3JsTQI3Z1MkkrF+6VTML5t38LN4BiZH0hH8cP950VluQJohcw5EibAWRnpI1e4tznntFqYFKli4Nhqax3ePEoJ6WCfK3Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717515772; c=relaxed/simple;
	bh=9TbsJFtaPUbCJoDjh/fow7fFlKMisHx6OakI+PBDzd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ti8iCxXYqeoUbQ4Ii0Gnk/6aDwY4n0PuGKZWxKXt0JFccrFwQMZlzfAwzJ4draAEzTgGK9zcWj7i0OnfmR/XPpNi6d1XvIOI9GxPsCFsdMVLAG5PpUBmurR737ER+M/vy0APGYpBhuEQBdAqjcLHQw9EU18skyhoro6qfkYhFhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XNkPjkhY; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2510648fbacso457344fac.1
        for <linux-mmc@vger.kernel.org>; Tue, 04 Jun 2024 08:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1717515769; x=1718120569; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eGmMGG4m4qTTbpagci4R5HMhIwKsm4Q6LdlN7j5XVqI=;
        b=XNkPjkhYUMe8+PX8SFwj0fI9xCWgxhnXAogL1+RYins3gpCmyE91V2+Hd9qVe0GCyT
         9/Gio40v6I2b250Ofu99PoWUYKVwpaRZ9vW7vbNKdN199A6Bsfq++0lolnWUEXWweFzo
         xCVNuUMurxfjk5Tq1L642SA3uPKdGnmxP2CKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717515769; x=1718120569;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eGmMGG4m4qTTbpagci4R5HMhIwKsm4Q6LdlN7j5XVqI=;
        b=DtYk5sqgFd4fiGbbCZNaoKMp95gHTE95EILjTQ7gCSaSxtSnvtSvkkcNcGsgpKED+2
         IMAv16WI5yuf3ANXfIpzzyZdFBIkvcVppL5oDmkkGjFgExe0pYPEIX+Tn1T+6ytIekcA
         Y4Nf8KKMwGa6mSqAghij3/LJqMs3ogJMO3F3/CvXz+9uDS0Px9zzR94AyOI8X3ZCBYga
         RT6jqx0C1KTzXM1d+dsL+AY/MGwNzaiCdcYcFj9XSOPGoyZr4D07JYO1mtGwE/7pbL+9
         JGqKMohAkXl/sUIPPpXmYb03yDagci2a5PtngWDaJ3ltWEYtLyHgJW0Ctxu33mJQdxMr
         tSfg==
X-Forwarded-Encrypted: i=1; AJvYcCXNer8ownoxEmh1Jc3ucGL8fRKooA20UN6/OQEgI2JqtRuStLSaiV+AvvpZZGuP/Pw0N4XYVcdPsFhblXlfDBdS202Bv2XJJMYP
X-Gm-Message-State: AOJu0Yz5tPEZgR152MIVO/fmZ1x7vAr/CJ4rlaMV608NwzKhj64mVL7t
	s0PjGXEP8VnwJZm1vLB2o/SmK9rsojdismoxLwNrNWyYBEQeE8MMS+mJR8eIJfD9rr4aaql1rJz
	LG3YiMK90IBFu3QNDvB7CSwpmtGErVb2pC4er
X-Google-Smtp-Source: AGHT+IGB/rduOe7VuUnqKKPTpxby23105z+u+FGKaOfGxDOzBmoKc4Rdtq6ADa5DDVWLsYkCNGB3fzck976BtNYJJw4=
X-Received: by 2002:a05:6870:e9a0:b0:24f:ca0b:a416 with SMTP id
 586e51a60fabf-2508b993cfamr15623795fac.25.1717515768507; Tue, 04 Jun 2024
 08:42:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603220834.21989-1-kamal.dasu@broadcom.com>
 <20240603220834.21989-2-kamal.dasu@broadcom.com> <CAPDyKFqk4uzSm_ti=66wU22GM8TqeM83aCz6=j9Gr9-sCUuR8Q@mail.gmail.com>
In-Reply-To: <CAPDyKFqk4uzSm_ti=66wU22GM8TqeM83aCz6=j9Gr9-sCUuR8Q@mail.gmail.com>
From: Kamal Dasu <kamal.dasu@broadcom.com>
Date: Tue, 4 Jun 2024 11:42:12 -0400
Message-ID: <CAKekbetJT1hob1Bd9ZOsf+J9JVfjRanq6GUdKF7oZr6xkPCzZw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mmc: sdhci-brcmstb: check R1_STATUS for erase/trim/discard
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	ludovic.barre@st.com, f.fainelli@gmail.com, 
	bcm-kernel-feedback-list@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000545065061a124dc9"

--000000000000545065061a124dc9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 7:14=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Tue, 4 Jun 2024 at 00:09, Kamal Dasu <kamal.dasu@broadcom.com> wrote:
> >
> > When erase/trim/discard completion was converted to mmc_poll_for_busy()=
,
> > optional ->card_busy() host ops support was added as part of
> > dd0d84c3e6a5b2 ("mmc: core: Convert to mmc_poll_for_busy() for erase/tr=
im/discard").
>
> I can't find the above commit hash. You probably want "0d84c3e6a5b2"?
>
> > sdhci card->busy() could return busy for long periods to cause
> > mmc_do_erase() to block during discard operation as shown below
> > during mkfs.f2fs :
> >
> >     Info: [/dev/mmcblk1p9] Discarding device
> >     [   39.597258] sysrq: Show Blocked State
> >     [   39.601183] task:mkfs.f2fs       state:D stack:0     pid:1561  t=
gid:1561  ppid:1542   flags:0x0000000d
> >     [   39.610609] Call trace:
> >     [   39.613098]  __switch_to+0xd8/0xf4
> >     [   39.616582]  __schedule+0x440/0x4f4
> >     [   39.620137]  schedule+0x2c/0x48
> >     [   39.623341]  schedule_hrtimeout_range_clock+0xe0/0x114
> >     [   39.628562]  schedule_hrtimeout_range+0x10/0x18
> >     [   39.633169]  usleep_range_state+0x5c/0x90
> >     [   39.637253]  __mmc_poll_for_busy+0xec/0x128
> >     [   39.641514]  mmc_poll_for_busy+0x48/0x70
> >     [   39.645511]  mmc_do_erase+0x1ec/0x210
> >     [   39.649237]  mmc_erase+0x1b4/0x1d4
> >     [   39.652701]  mmc_blk_mq_issue_rq+0x35c/0x6ac
> >     [   39.657037]  mmc_mq_queue_rq+0x18c/0x214
> >     [   39.661022]  blk_mq_dispatch_rq_list+0x3a8/0x528
> >     [   39.665722]  __blk_mq_sched_dispatch_requests+0x3a0/0x4ac
> >     [   39.671198]  blk_mq_sched_dispatch_requests+0x28/0x5c
> >     [   39.676322]  blk_mq_run_hw_queue+0x11c/0x12c
> >     [   39.680668]  blk_mq_flush_plug_list+0x200/0x33c
> >     [   39.685278]  blk_add_rq_to_plug+0x68/0xd8
> >     [   39.689365]  blk_mq_submit_bio+0x3a4/0x458
> >     [   39.693539]  __submit_bio+0x1c/0x80
> >     [   39.697096]  submit_bio_noacct_nocheck+0x94/0x174
> >     [   39.701875]  submit_bio_noacct+0x1b0/0x22c
> >     [   39.706042]  submit_bio+0xac/0xe8
> >     [   39.709424]  blk_next_bio+0x4c/0x5c
> >     [   39.712973]  blkdev_issue_secure_erase+0x118/0x170
> >     [   39.717835]  blkdev_common_ioctl+0x374/0x728
> >     [   39.722175]  blkdev_ioctl+0x8c/0x2b0
> >     [   39.725816]  vfs_ioctl+0x24/0x40
> >     [   39.729117]  __arm64_sys_ioctl+0x5c/0x8c
> >     [   39.733114]  invoke_syscall+0x68/0xec
> >     [   39.736839]  el0_svc_common.constprop.0+0x70/0xd8
> >     [   39.741609]  do_el0_svc+0x18/0x20
> >     [   39.744981]  el0_svc+0x68/0x94
> >     [   39.748107]  el0t_64_sync_handler+0x88/0x124
> >     [   39.752455]  el0t_64_sync+0x168/0x16c
> >
> > This problem is obsereved with BLKSECDISCARD ioctl on brcmstb mmc
> > controllers. Fix makes mmc_host_ops.card_busy NULL and forces
> > MMC_SEND_STATUS and R1_STATUS check in mmc_busy_cb() function.
> >
> > Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
>
> We probably want a fixes/stable tag for this too, right?
>
> Fixes: 0d84c3e6a5b2 ("mmc: core: Convert to mmc_poll_for_busy() for
> erase/trim/discard")
>
> I have amended the commit message and applied this for fixes, thanks!
>

Thank you Ulffe.

> Kind regards
> Uffe
>
>
> > ---
> >  drivers/mmc/host/sdhci-brcmstb.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-=
brcmstb.c
> > index 9053526fa212..150fb477b7cc 100644
> > --- a/drivers/mmc/host/sdhci-brcmstb.c
> > +++ b/drivers/mmc/host/sdhci-brcmstb.c
> > @@ -24,6 +24,7 @@
> >  #define BRCMSTB_MATCH_FLAGS_NO_64BIT           BIT(0)
> >  #define BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT     BIT(1)
> >  #define BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE     BIT(2)
> > +#define BRCMSTB_MATCH_FLAGS_USE_CARD_BUSY      BIT(4)
> >
> >  #define BRCMSTB_PRIV_FLAGS_HAS_CQE             BIT(0)
> >  #define BRCMSTB_PRIV_FLAGS_GATE_CLOCK          BIT(1)
> > @@ -384,6 +385,9 @@ static int sdhci_brcmstb_probe(struct platform_devi=
ce *pdev)
> >         if (match_priv->flags & BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT)
> >                 host->quirks |=3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> >
> > +       if (!(match_priv->flags & BRCMSTB_MATCH_FLAGS_USE_CARD_BUSY))
> > +               host->mmc_host_ops.card_busy =3D NULL;
> > +
> >         /* Change the base clock frequency if the DT property exists */
> >         if (device_property_read_u32(&pdev->dev, "clock-frequency",
> >                                      &priv->base_freq_hz) !=3D 0)
> > --
> > 2.17.1
> >

--000000000000545065061a124dc9
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
DxuNuBlySpn/GYqPcDcRZd8EENWqnZrjtjHMk0j7ZfrPGXq8sQkbG3OX+DOwSaefPRq1pLGWBZaZ
YuUo5O7CNHo7h7Hc9GgjiW+6X9BjKAzSaDy8jwIDAQABo4IB2DCCAdQwDgYDVR0PAQH/BAQDAgWg
MIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUFBzABhjVo
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMDBNBgNV
HSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2ln
bi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAiBgNVHREEGzAZ
gRdrYW1hbC5kYXN1QGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAW
gBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUcRYSWvAVyA3hgTrQ2c4AFquBsG0wDQYJ
KoZIhvcNAQELBQADggEBAIKB2IOweF2sIYGBZTDm+Hwmhga+sjekM167Sk/KwxxvQFwZYP6i0SnR
7aR59vbfVQVaAiZH/a+35EYxP/sXaIM4+E3bFykBuXwcGEnYyEn6MceiOCkjkWQq1Co2JyOdNvkP
nAxyPoWlsJtr+N/MF1EYKGpYMdPM7S2T/gujjO9N56BCGu9yJElszWcXHmBl5IsaQqMS36vhsV0b
NxffjNkeAdgfN/SS9S9Rj4WXD7pF1M0Xq8gPLCLyXrx1i2KkYOYJsj0PWlC6VRg6E1xXkYDte0VL
fAAG4QsETU27E1HBNQyp5zF1PoPCPvq3EnWQnbLgYk+Jz2iwIUwiqwr/bDgxggJtMIICaQIBATBr
MFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9i
YWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgw89WX2Pp7ue922QVkwDQYJYIZI
AWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOBTFgWLQQBjz+trPDKlf7VieljOl91AU8rEPK0X
WFTeMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYwNDE1NDI0
OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkq
hkiG9w0BAQEFAASCAQCHDitsVrSIBqEBfi+BtUh/VV4n01E3KUZmMiIeHPu26bc/VPdvyKtajqAM
WcXtKSxa/LIduy33Uf9rBZIbMYXAMetjJeD1ez4diXNfgtDhy94kokDyIRP7MdmN5yivsr111KXs
inzTLpTxSanh5pGzsyWCdqVOPoZWaxXfc5T9l2Lb2eHa7onxds3wqFe2qA7fIY6gTsKoRxlD9oR9
ixEzo5s6kxydsYO7olMixGTpbVwiC+0GKNOTzM1PKRxAPQB7nQhNhdzoPRn3Bes0hsP8HkFoDE20
s1Et24gsdM6Q3loughwUE0Eif4Am5EKHx9Sf2KsAvWA2aYgxzU72IvVv
--000000000000545065061a124dc9--

