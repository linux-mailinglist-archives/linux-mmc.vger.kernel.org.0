Return-Path: <linux-mmc+bounces-1023-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB138536D7
	for <lists+linux-mmc@lfdr.de>; Tue, 13 Feb 2024 18:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604EA1C23133
	for <lists+linux-mmc@lfdr.de>; Tue, 13 Feb 2024 17:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FD25FBB1;
	Tue, 13 Feb 2024 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVBXP0LF"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4C75FBAB
	for <linux-mmc@vger.kernel.org>; Tue, 13 Feb 2024 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844109; cv=none; b=cOc3o5JxFS8VDvvor/B2yytddiG1fYzZZaXQOOZrsMMLEb3UaNaBju85k/9a90xJpfofWLF0l7U7QwS/A9fsiMGQoVOzIyPC/MPMTplcvbLGoHu2hPcPSeJPB9g6OQHNGLh0o+L7GlfdK3GYgxmKzPpxZTJZVtfSJ8Vf937Nn4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844109; c=relaxed/simple;
	bh=LYH9G16owoiQc2zjjn+FIjNJu//wkldV8uQ1hDcVPwY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SAuAxnGKV+TMu1DZI3vvp9KjKvQKmtMapfxMjYm+MfuHv1QSnisDydOvmZrJy+OrZSyrwIDQL2RdMfoY7OMYpLxgcXHixiiiHCAZM1g7zEm8x5/dvak/2CK4P1snTg90Jjg+OnKu/KrMBbb6SfO9K9s744cbWJquN8WK9J47pHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVBXP0LF; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33cdedb40c4so410360f8f.2
        for <linux-mmc@vger.kernel.org>; Tue, 13 Feb 2024 09:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707844104; x=1708448904; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RIdHArSuo+enb7F0NImkd1XDVwnqmG4CQxNnqHKLMU=;
        b=NVBXP0LFq+GYt/YgMe7NjLfvKTSG5hF8a4qoMQI2LPvb35/S8eSAYKvpd2Ms0TdDGh
         VQvqoNM1y2lrn0GvkOA8gHWzxdWs2HBm33FlPWfO8qvBxbVekylUnBkkJk9En17QsUpK
         ecZfNZcU1s2nmwD1aBMB4JOsZfyXlSMCMd+uDhIq2dK33F6crAa+l1rJqVZXR5e9mY2R
         48elhMyTWbIHs9lUiHxYX2idK+UFED048m1wqlEszC4XVa24wRKO9ieJP5TAuEDB1dsx
         6mWdvGEdtoyUH8yl/SedZLWxys3egv8VkeOs3e/Z+BUOmps820pasHyX4MtTU0tNQkNv
         pOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707844104; x=1708448904;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RIdHArSuo+enb7F0NImkd1XDVwnqmG4CQxNnqHKLMU=;
        b=LiOEzHaNX8nEzuo8uLOE2mSnCIyboAHMbjuk6ZzFcg8YcqfJzTcSkTeBUfYdeixVDa
         EKlDQASNtkaC6R/IQX0o8CsHAIY0bL0KFYHTbgtx1qnyy4HPfAq0yc3tCA8nSyOzzS4a
         r3Mkmi59gim6WojSrEyp+jPivpF4GWvEWu7FZE53H42v8mRPWhqL9Qsf/zNChem1VWxn
         XnonSdrOlYkevnAHCnbl04PMzImL7iFlS+8ZdI/QMmetLSYvW7KtMPHyDIam2p4Wq6Bw
         YO8qE1xWUusQ5LtHzMFhEEqNYl8XFTq8kmOmC3f9WS2N+EJL0vGVYsSJuuzvBWUsvrL2
         KSpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNI26CXVKY3A0BloTfXKHU80Y/woiYo6Ybfj4jniYWpmNdnk3FqMtHtC9nXUFmn+TvQVrrgjuClP7bgGQvRtVOP0MVUB/3aBam
X-Gm-Message-State: AOJu0YzmZrW7BGUxJVrf57uzeZP+n/68PRsurlKYKMzbTFn39Wh6tIY5
	eF7gVKV9yglX2JGIi8kBSxglsoEqwFqds02pWUibAQwJolBrSpan
X-Google-Smtp-Source: AGHT+IEkhdRFyRVSGeEgdg5vjSLw96onAWi760GcFdjgdCcbXs8aUH78ixuYsPLlJAKCoqqiiSvj9Q==
X-Received: by 2002:adf:fe08:0:b0:33b:2fba:1ea8 with SMTP id n8-20020adffe08000000b0033b2fba1ea8mr6534414wrr.52.1707844104178;
        Tue, 13 Feb 2024 09:08:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXqYUUsMBjDTxhBUpGWU4QmLXFW9HqJmyWPqD1t4/zltuXqlKPwNghgOpow7walYTwMDCJ/kzWdN4OJs+xmSx1Qe/B629BRdkudWLkUkNojtAQtok4JVPKAYixW/FweWQ==
Received: from smtpclient.apple ([31.216.122.163])
        by smtp.gmail.com with ESMTPSA id a14-20020adff7ce000000b0033b2276e71csm10040549wrq.62.2024.02.13.09.08.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Feb 2024 09:08:24 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH] mmc: Fix eMMC initialization with 1-bit bus connection
From: Ivan Semenov <vanyas@gmail.com>
In-Reply-To: <CAPDyKFpfHyhuRBT7yQ_jCe_XBg0VbP90fr3vLy6v-DLgq7sCzQ@mail.gmail.com>
Date: Tue, 13 Feb 2024 19:08:11 +0200
Cc: Ivan Semenov <ivan@semenov.dev>,
 linux-mmc@vger.kernel.org,
 tgih.jun@samsung.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <0ED18BA8-1F24-4A2C-8A16-1D2A7DDDD7A6@gmail.com>
References: <20240206172845.34316-1-ivan@semenov.dev>
 <CAPDyKFpfHyhuRBT7yQ_jCe_XBg0VbP90fr3vLy6v-DLgq7sCzQ@mail.gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
X-Mailer: Apple Mail (2.3774.300.61.1.2)



> On Feb 13, 2024, at 18:40, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>=20
> On Tue, 6 Feb 2024 at 18:28, Ivan Semenov <ivan@semenov.dev> wrote:
>>=20
>> The Linux mmc driver currently encounters a problem with eMMC chips =
connected via a 1-bit bus, when the chip supports a 4-bit bus. This =
regression was introduced in commit 577fb13 after functioning correctly =
in kernel version 3.15.
>>=20
>> In the function mmc_select_bus_width, the driver attempts to switch =
to 8-bit and 4-bit modes, but if the 4-bit bus test fails, it does not =
fall back to 1-bit mode and leaves eMMC in broken 4-bit mode. This =
results in I/O errors and failure to read the partition table.
>>=20
>> This patch addresses the issue by ensuring that the driver fallback =
to 1-bit bus mode if the attempt to switch to 4-bit mode fails.
>>=20
>> dmesg log for Samsung eMMC 5.1 chip connected  via 1bit bus (only D0 =
pin) before patch:
>=20
> Wow, that was an old bug you found there.
>=20
> Just to make sure I understand correctly, the platform only supports
> 1-bit bus, but the DTS doesn't reflect that correctly as it instead
> indicates that 4 and 8-bit modes are supported?

Yes, you are correct, and the second case - with no DTS, when emmc is
connected to PC via cardreader, but via 1bit connection only

>=20
> Don't get me wrong, I think the initialization-error-path should be
> able to cope with that, so we should certainly fix it!
>=20
>>=20
>> [134509.044225] mmc0: switch to bus width 4 failed
>> [134509.044509] mmc0: new high speed MMC card at address 0001
>> [134509.054594] mmcblk0: mmc0:0001 BGUF4R 29.1 GiB
>> [134509.281602] mmc0: switch to bus width 4 failed
>> [134509.282638] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags =
0x0 phys_seg 1 prio class 2
>> [134509.282657] Buffer I/O error on dev mmcblk0, logical block 0, =
async page read
>> [134509.284598] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags =
0x0 phys_seg 1 prio class 2
>> [134509.284602] Buffer I/O error on dev mmcblk0, logical block 0, =
async page read
>> [134509.284609] ldm_validate_partition_table(): Disk read failed.
>> [134509.286495] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags =
0x0 phys_seg 1 prio class 2
>> [134509.286500] Buffer I/O error on dev mmcblk0, logical block 0, =
async page read
>> [134509.288303] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags =
0x0 phys_seg 1 prio class 2
>> [134509.288308] Buffer I/O error on dev mmcblk0, logical block 0, =
async page read
>> [134509.289540] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags =
0x0 phys_seg 1 prio class 2
>> [134509.289544] Buffer I/O error on dev mmcblk0, logical block 0, =
async page read
>> [134509.289553]  mmcblk0: unable to read partition table
>> [134509.289728] mmcblk0boot0: mmc0:0001 BGUF4R 31.9 MiB
>> [134509.290283] mmcblk0boot1: mmc0:0001 BGUF4R 31.9 MiB
>> [134509.294577] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags =
0x80700 phys_seg 1 prio class 2
>> [134509.295835] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags =
0x0 phys_seg 1 prio class 2
>> [134509.295841] Buffer I/O error on dev mmcblk0, logical block 0, =
async page read
>>=20
>> After patch:
>>=20
>> [134551.089613] mmc0: switch to bus width 4 failed
>> [134551.090377] mmc0: new high speed MMC card at address 0001
>> [134551.102271] mmcblk0: mmc0:0001 BGUF4R 29.1 GiB
>> [134551.113365]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 =
p14 p15 p16 p17 p18 p19 p20 p21
>> [134551.114262] mmcblk0boot0: mmc0:0001 BGUF4R 31.9 MiB
>> [134551.114925] mmcblk0boot1: mmc0:0001 BGUF4R 31.9 MiB
>=20
> To allow me to apply the patch, you need to provide your
> Signed-off-by-tag. According to the below:
>=20
> Signed-off-by: Ivan Semenov <ivan@semenov.dev>
>=20
> Please tell me if you are okay with that, then I can amend the patch
> when applying. No need for you to post a new version.

I=E2=80=99m ok with that, is it ok to put it here or I need to send a =
patch again?
Signed-off-by: Ivan Semenov <ivan@semenov.dev>

>=20
>> ---
>> drivers/mmc/core/mmc.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>=20
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index f410bee50132..58ed7193a3ca 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1015,10 +1015,12 @@ static int mmc_select_bus_width(struct =
mmc_card *card)
>>        static unsigned ext_csd_bits[] =3D {
>>                EXT_CSD_BUS_WIDTH_8,
>>                EXT_CSD_BUS_WIDTH_4,
>> +               EXT_CSD_BUS_WIDTH_1,
>>        };
>>        static unsigned bus_widths[] =3D {
>>                MMC_BUS_WIDTH_8,
>>                MMC_BUS_WIDTH_4,
>> +               MMC_BUS_WIDTH_1,
>>        };
>>        struct mmc_host *host =3D card->host;
>>        unsigned idx, bus_width =3D 0;
>=20
> For my understanding, does your platform support HS200 mode too? Or
> only high-speed mode?
>=20
> The reason for my question is that it would be interesting to
> understand whether we end up running the error path in
> mmc_select_hs200() or not.

In my case, platform supports only High-Speed mode, so I can=E2=80=99t =
test in
with HS200 mode.

>=20
> [...]
>=20
> Kind regards
> Uffe



